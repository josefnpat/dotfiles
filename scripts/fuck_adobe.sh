#!/bin/sh

if [ "$(whoami)" != 'root' ]; then
  echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

cd /usr/lib/adobe-flashplugin
perl -pi.bak -e 's/libvdpau/lixvdpau/g' libflashplayer.so
