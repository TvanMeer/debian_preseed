# debian_preseed
A script to create a custom Debian ISO that has its installation options preseeded. 

## Description

This script creates a custom AMD64 ISO image of Debian Bullseye, the current stable release of Debian.
The generated .ISO file contains the installation options, such that fully automated installation is possible without
the need to go through the installation process manually.
See the [docs](https://wiki.debian.org/DebianInstaller/Preseed) for more info about preseeding installation options.

## Usage

Clone this repository: 
```
git clone https://github.com/TvanMeer/debian_preseed.git
```

Edit the preseed.cfg file to your liking.

Then create the custom ISO image:
```
cd debian_preseed
sudo chmod u+x create_iso.sh
./create_iso.sh
```

The directory ``debian_preseed`` will now contain the file ``debian-11.3.0-amd64-modified.iso``.

