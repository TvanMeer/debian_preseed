# debian_preseed
A script to automate the installation of Debian. 

# Description

This installs a minimal AMD64 image of Debian Bullseye, the current stable branch of Debian.
See the [docs](https://wiki.debian.org/DebianInstaller/Preseed) for more info about preseeding.

The package OpenSSH is installed to prepare the system for provisioning by [Ansible](https://docs.ansible.com/ansible/latest/index.html).

## Usage

1. [Download](https://www.debian.org/download) the netinstaller ISO.
2. Create a bootable USB or virtual machine with this image.
3. Start the installation wizard and choose Advanced options -> Automated install.
4. Type the URL **http://github.com/TvanMeer/debian_preseed/preseed.cfg** and press enter.
