#! /bin/bash

set -e

git clone git://github.com/jhford/screenresolution.git

BUILD=screenresolution
if ! [ -d $BUILD ]; then
    echo "Run this from the root of the cloned git repo git://github.com/jhford/screenresolution.git"
    echo "You'll need the latest versions of Xcode, command line tools, and auxiliary tools installed"
    exit 1
fi

# prep
cd $BUILD
set version of dmg to create
sed -i .bak 's/1.6dev/1.6/g' Makefile
#set location of packager maker that's installed from Apple's auxillary tools download
sed -i .bak 's/\/Developer\/usr\/bin\/packagemaker/\/Volumes\/Auxiliary\\ Tools\/PackageMaker.app\/Contents\/MacOS\/PackageMaker/' Makefile

echo $VERSION
echo $PACKGAGE_MAKER

# build the package
make dmg
