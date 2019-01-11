from ubuntu

# meta
label version="1.0"
label description="Docker build for C/Rust N64 build environment"
label maintainer="MrPnut"

# get dependencies we need for rest of script
run apt-get update
run apt-get -y upgrade

run apt-get -y install git
run apt-get -y install wget
run apt-get -y install build-essential
run apt-get -y install libgmp-dev
run apt-get -y install libmpfr-dev
run apt-get -y install libmpc-dev
run apt-get -y install bison
run apt-get -y install flex

# copy sdk and patches over to build context
copy n64sdk n64sdk
copy patches patches

run git clone https://github.com/tj90241/n64chain.git

# make dirs that the installation script would do otherwise
run mkdir -p /n64chain/tools/tarballs
run mkdir -p /n64chain/tools/stamps
run mkdir /n64chain/tools/make-build
run mkdir /n64chain/tools/make-source

# patch make because it won't build otherwise
run wget ftp://ftp.gnu.org/gnu/make/make-4.2.1.tar.bz2 -O /n64chain/tools/tarballs/make-4.2.1.tar.bz2
run touch /n64chain/tools/stamps/make-download

run tar -xf /n64chain/tools/tarballs/make-4.2.1.tar.bz2 -C /n64chain/tools/make-source --strip 1
run patch /n64chain/tools/make-source/glob/glob.c /patches/glob.patch
run touch /n64chain/tools/stamps/make-extract

# build rest of toolchain
run chmod +x /n64chain/tools/build-posix64-toolchain.sh
run /n64chain/tools/build-posix64-toolchain.sh

# set up environment variables each invocation of docker run will reuse
env ROOT=/n64sdk/ultra
env PATH=/n64chain/tools/bin:$PATH
env GCCDIR=$ROOT/GCC

# copy any overlays over for files we want to modify
copy overlays /
