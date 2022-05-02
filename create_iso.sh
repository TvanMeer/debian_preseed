#!/bin/bash


# Make sure relative paths work
cd $(dirname $0)


# Download Debian netinstaller
curl -O https://laotzu.ftp.acc.umu.se/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso


# See https://wiki.debian.org/DebianInstaller/Preseed/EditIso

# Extracting the Initrd from an ISO Image
sudo apt install libarchive-tools
mkdir iso
bsdtar -C iso -xf debian-11.3.0-amd64-netinst.iso


# Adding a Preseed File to the Initrd
chmod +w -R iso/install.amd/
gunzip iso/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F iso/install.amd/initrd
gzip iso/install.amd/initrd
chmod -w -R iso/install.amd/


# Regenerating md5sum.txt
cd iso
chmod +w md5sum.txt
find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt
chmod -w md5sum.txt
cd ..


# See https://wiki.debian.org/RepackBootableISO

# Repack as EFI based bootable ISO
current_path=$(pwd)

orig_iso=$current_path/debian-11.3.0-amd64-netinst.iso
new_files=$current_path/iso
new_iso=$current_path/debian-11.3.0-amd64-modified.iso
mbr_template=$current_path/isohdpfx.bin


# Extract MBR template file to disk
dd if="$orig_iso" bs=1 count=432 of="$mbr_template"


# Install xorriso packager
sudo apt-get -f install xorriso


# Run modified contents of file iso/.disk/mkisofs
xorriso -as mkisofs \
   -V 'Debian 11.3.0 amd64 n' \
   -o debian-11.3.0-amd64-modified.iso \
   -J -joliet-long -cache-inodes \
   -isohybrid-mbr "$mbr_template" \
   -b isolinux/isolinux.bin \
   -c isolinux/boot.cat \
   -boot-load-size 4 -boot-info-table -no-emul-boot \
   -eltorito-alt-boot \
   -e boot/grub/efi.img \
   -no-emul-boot \
   -isohybrid-gpt-basdat \
   -isohybrid-apm-hfsplus \
   "$new_files"
