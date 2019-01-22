#!/bin/bash

if [ "$1" = "false" ]; then
    echo "Installing rust..."
    echo "After it is installed, it may appear to hang for a minute.  Just let it be."

    apt-get -y install curl

    export CARGO_HOME=/cargo

    curl https://sh.rustup.rs -sSf | sh -s -- -y

    export PATH=/cargo/bin:$PATH

    rustup override set nightly
    rustup component add rust-src

    cargo install xargo
else
    echo "Skipping installation of rust"
fi
