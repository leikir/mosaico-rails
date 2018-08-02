#!/bin/sh

set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

cd vendor/assets/mosaico
if [ ! -d mosaico-src ]; then
  git clone https://github.com/voidlabs/mosaico.git --depth=1 mosaico-src
fi
cd mosaico-src
git pull origin master
npm install
npm install -g grunt-cli
grunt dist --force
cd ..
rm -rf mosaico
mkdir mosaico
mv mosaico-src/dist mosaico/dist
