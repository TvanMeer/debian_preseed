# debian_preseed
A script to automate the installation of Debian. See the [docs](https://wiki.debian.org/DebianInstaller/Preseed) for more info.
This installs a minimal AMD64 image of Debian Bookworm, the current *test* branch of Debian.
Bleeding edge but not unworkably unstable, because development takes place in the *dev* branch.

The package OpenSSH is installed to prepare the system for provisioning by [Ansible](https://docs.ansible.com/ansible/latest/index.html).

## usage

1. [download](https://www.debian.org/devel/debian-installer/) the netinstaller ISO.
2. Create a bootable USB or virtual machine with this image.
3. Start the installation wizard and choose Advanced options -> Automated install.
4. Enter the URL **http://github.com/TvanMeer/debian_preseed/preseed.cfg** and press enter.
