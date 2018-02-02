#!/bin/bash

VERSION="9.2"

wget "http://ftp.gnu.org/gnu/mit-scheme/stable.pkg/${VERSION}/mit-scheme-${VERSION}-x86-64.tar.gz"

tar xzf mit-scheme-${VERSION}-x86-64.tar.gz

cd mit-scheme-${VERSION}/src

./configure
make
sudo make install
