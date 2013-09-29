#!/bin/bash
cd $(dirname $0)
wget -O btsync.arm.tgz     http://download-lb.utorrent.com/endpoint/btsync/os/linux-arm/track/stable
wget -O btsync.ppc.tgz http://download-lb.utorrent.com/endpoint/btsync/os/linux-powerpc/track/stable
wget -O btsync.i386.tgz    http://download-lb.utorrent.com/endpoint/btsync/os/linux-i386/track/stable
wget -O btsync.x86_64.tgz  http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable

for ARCH in arm ppc i386 x86_64; do
  tar xzf btsync.$ARCH.tgz
  mv btsync btsync.$ARCH
  rm LICENSE.TXT
  rm btsync.$ARCH.tgz
done
