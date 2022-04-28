#!/bin/bash

# Download Debian netinstaller
curl https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso

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

# Repack as EFI based bootable ISO

# TODO: https://wiki.debian.org/RepackBootableISO

# Contents of file iso/.disk/mkisofs
xorriso -as mkisofs \
   -r -checksum_algorithm_iso sha256,sha512 \
   -V 'Debian 11.3.0 amd64 n' \
   -o /srv/cdbuilder.debian.org/dst/deb-cd/out/2bullseyeamd64/debian-11.3.0-amd64-NETINST-1.iso \
   -md5-list /srv/cdbuilder.debian.org/src/deb-cd/tmp/2bullseyeamd64/bullseye/checksum-check \
   -J -joliet-long -cache-inodes \
   -isohybrid-mbr syslinux/usr/lib/ISOLINUX/isohdpfx.bin -b isolinux/isolinux.bin \
   -c isolinux/boot.cat -boot-load-size 4 -boot-info-table -no-emul-boot \
   -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat \
   -isohybrid-apm-hfsplus boot1 CD1
