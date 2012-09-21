#!/bin/sh

# init to home folder
cd ~
# alternate binaries
mkdir ~/bin -p

# ppa's
apt-add-repository ppa:bartbes/love-stable -y
apt-add-repository ppa:ubuntu-wine/ppa -y
apt-add-repository ppa:team-xbmc/ppa -y
apt-get update -y

# cli
apt-get install irssi qalc git mocp -y

# openbox & more
apt-get install openbox obconf obmenu grun conky -y

# obkey (No idea why this isn't in the repos.)
# source
cd ~/bin/
git clone https://github.com/nsf/obkey.git
ln ~/bin/obkey/obkey /usr/games/ -s

# internet
apt-get install chromium-browser transmission -y

# desktop
apt-get install nvidia-settings gtk-recordmydesktop -y

# dev
apt-get install gimp gcolor2 libreoffice kodos meld mercurial -y

# vidya
apt-get install love wine gweled -y

# media
apt-get install vlc rhythmbox audacity xbmc -y

# don't want this!
#apt-get remove

apt-get upgrade -y
apt-get autoclean -y
apt-get autoremove -y