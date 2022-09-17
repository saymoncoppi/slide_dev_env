#!/bin/bash

sleep 3; echo '
# NEW APT SETTINGS
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
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


sleep 3; echo '
# NEW FLAVOR
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

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

sleep 3; echo '
# APT UPDATE
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
apt update

sleep 3; echo '
# NEW X
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

apt-get install --yes --force-yes --no-install-recommends \
xserver-xorg-core \
xserver-xorg-legacy \
xserver-xorg-video-vesa \
xserver-xorg-video-vmware \
xserver-xorg-input-all \
xinit \
xfonts-base \
x11-utils \
libxcursor1 \
libdrm-intel1 \
libgl1-mesa-dri \
libglu1-mesa \
openbox 

# install x11 server utils, apt-get would add cpp dependency, bullshit!
cd /tmp
apt-get download x11-xserver-utils
dpkg -x x11-xserver-utils*.deb /tmp/x11utils
cd /tmp/x11utils
cp -aR * /

echo "export DISPLAY=localhost:0.0" >> ~/.bashrc

# make folder .config/openbox
mkdir -p ~/.config/openbox/
cd ~/.config/openbox/

echo 'done'


sleep 3; echo '
# CLEANUP
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo 'done'