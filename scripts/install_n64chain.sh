#!/bin/bash

echo "Installing n64chain..."

apt-get -y install libgmp-dev
apt-get -y install libmpfr-dev
apt-get -y install libmpc-dev

if [ "$1" = "false" ]; then
    echo "Using prebuilt toolchain..."
    
    apt-get -y install xz-utils
    tar xJf /n64chain/n64chain.tar.xz    
else
    echo "Building toolchain from source..."
    
    rm -rf /n64chain
    git clone https://github.com/tj90241/n64chain.git

    mkdir -p /n64chain/tools/tarballs
    mkdir -p /n64chain/tools/stamps
    mkdir /n64chain/tools/make-build
    mkdir /n64chain/tools/make-source

    apt-get -y install git
    apt-get -y install wget
    apt-get -y install build-essential    
    apt-get -y install bison
    apt-get -y install flex

    wget ftp://ftp.gnu.org/gnu/make/make-4.2.1.tar.bz2 -O /n64chain/tools/tarballs/make-4.2.1.tar.bz2
    touch /n64chain/tools/stamps/make-download

    tar -xf /n64chain/tools/tarballs/make-4.2.1.tar.bz2 -C /n64chain/tools/make-source --strip 1
    patch /n64chain/tools/make-source/glob/glob.c /patches/glob.patch
    touch /n64chain/tools/stamps/make-extract

    chmod +x /n64chain/tools/build-posix64-toolchain.sh
    /n64chain/tools/build-posix64-toolchain.sh    
fi    
