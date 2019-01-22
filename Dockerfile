from ubuntu:18.04

# meta
label version="1.0.1"
label description="Docker build for C/Rust N64 build environment"
label maintainer="MrPnut"

# arguments
arg BUILD_TOOLCHAIN=false
arg NO_RUST=false

# copy sdk and patches over to build context
copy n64sdk n64sdk
copy patches patches
copy scripts scripts
copy n64chain n64chain

# get dependencies we need for rest of script
run apt-get update
run apt-get -y upgrade

# install the toolchain
run chmod +x /scripts/install_n64chain.sh
run /scripts/install_n64chain.sh ${BUILD_TOOLCHAIN}

# install spicy / makemask
run chmod +x /scripts/install_spicy_makemask.sh
run /scripts/install_spicy_makemask.sh

# install rust
run chmod +x /scripts/install_rust.sh
run /scripts/install_rust.sh ${NO_RUST}

# set up environment variables each invocation of docker run will reuse
env ROOT=/n64sdk/ultra
env PATH=/n64chain/tools/bin:/cargo/bin:$PATH
env GCCDIR=$ROOT/GCC
env CARGO_HOME=/cargo

# copy any overlays over for files we want to modify
copy overlays /
