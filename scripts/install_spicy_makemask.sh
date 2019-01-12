#!/bin/bash

echo "Installing spicy and makemask..."

apt-get -y install git
apt-get -y install openssl
apt-get -y install golang-go

export GOPATH=/go
export GOBIN=/usr/local/bin

go get github.com/trhodeos/spicy/cmd/spicy
go get github.com/trhodeos/makemask
