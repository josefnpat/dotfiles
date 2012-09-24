#!/bin/bash


if [ "$(whoami)" != 'root' ]; then
  echo "You have no permission to run $0 as non-root user."
  exit 1;
fi

./setup-software.sh
./setup-config.sh
./setup-scripts.sh

read -p "Setup Laptop (y/N)? " ans
if [[ $ans == y* ]] || [[ $ans == Y* ]]; then
  ./setup-laptop.sh
fi

read -p "Setup Server (y/N)? " ans
if [[ $ans == y* ]] || [[ $ans == Y* ]]; then
  ./setup-server.sh
fi
