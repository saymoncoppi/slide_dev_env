#!/bin/bash

echo 'NEW APT SETTINGS'
echo 'APT
{
  NeverAutoRemove
  {
	"^firmware-linux.*";
	"^linux-firmware$";
  };
  VersionedKernelPackages
  {
	# linux kernels
	"linux-image";
	"linux-headers";
	"linux-image-extra";
	"linux-signed-image";
	# kfreebsd kernels
	"kfreebsd-image";
	"kfreebsd-headers";
	# hurd kernels
	"gnumach-image";
	# (out-of-tree) modules
	".*-modules";
	".*-kernel";
	"linux-backports-modules-.*";
        # tools
        "linux-tools";
  };
  Never-MarkAuto-Sections
  {
	"metapackages";
	"contrib/metapackages";
	"non-free/metapackages";
	"restricted/metapackages";
	"universe/metapackages";
	"multiverse/metapackages";
  };
  Move-Autobit-Sections
  {
	"oldlibs";
	"contrib/oldlibs";
	"non-free/oldlibs";
	"restricted/oldlibs";
	"universe/oldlibs";
	"multiverse/oldlibs";
  };
};
APT::Install-Recommends "0" ;
APT::Install-Suggests "0" ;
Acquire::Languages { "none";
Apt::AutoRemove::SuggestsImportant "false";
Acquire::GzipIndexes "true";
Acquire::CompressionTypes::Order:: "gz";
DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };
Dir::Cache::pkgcache "";
Dir::Cache::srcpkgcache "";' > /etc/apt/apt.conf.d/01_custom_slide


# no docs
echo "
path-exclude /usr/share/doc/*
# we need to keep copyright files for legal reasons
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
# lintian stuff is small, but really unnecessary
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
path-exclude /usr/share/locale/*
path-include /usr/share/locale/en*
" > /etc/dpkg/dpkg.cfg.d/01_nodoc

echo "done"

echo 'NEW FLAVOR'

# edit /etc/issue
echo "slide 0.1" > /etc/issue

# edit /etc/motd
echo "" > /etc/motd

# edit /etc/lsb-release
echo 'DISTRIB_ID=slide
DISTRIB_RELEASE="0.1"
DISTRIB_DESCRIPTION="slide 0.1 "
DISTRIB_CODENAME=unstable' >  /etc/lsb-release

# edit /etc/hostname
echo "slide" > /etc/hostname

echo "done"

echo 'APT UPDATE'
apt update

echo 'NEW X'

apt-get install --yes --allow --no-install-recommends \
xserver-xorg-core \
xserver-xorg-legacy \
xserver-xorg-video-vesa \
xinit \
xfonts-base \
x11-utils \
libxcursor1 \
libdrm-intel1 \
libgl1-mesa-dri \
libglu1-mesa



# install x11 server utils, apt-get would add cpp dependency, bullshit!
cd /tmp
apt-get download x11-xserver-utils
dpkg -x x11-xserver-utils*.deb /tmp/x11utils
cd /tmp/x11utils
cp -aR * /

# replace localhost with your current IP
echo "Enter the vcxsrv IP address: "
read vcxsrv_ip
echo "export DISPLAY=$vcxsrv_ip:0.0" >> ~/.bashrc



echo 'INSTALL DEV TOOLS'
apt-get install --yes --allow --no-install-recommends wget gpg \
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg \
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list \
apt-get update && apt-get install --no-install-recommends -y \
python3 python3-dev python3-setuptools python3-pip \
gcc git openssh-client less curl nano vim bsdmainutils snapd apt-transport-https openjdk-11-jdk qemu qemu-kvm \
libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 libpq-dev libglu1-mesa \
# dev-tools
sudo zip unzip file sublime-text terminator git-cola gitk meld nautilus \
# buser-djangosu
wait-for-it jq libgdal-dev locales supervisor libmagic-dev build-essential libgeos-dev libffi-dev libxml2-dev libxslt1-dev rustc cargo \
# && rm -rf /var/lib/apt/lists/* \
systemctl enable snapd \
groupadd -g 1000 -r developer \
useradd -u 1000 -g 1000 -ms /bin/bash -r developer \
echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-developer \
adduser developer kvm


echo 'CLEANUP'
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo 'done'
