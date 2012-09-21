#!/bin/sh

# init to home folder
cd ~
# alternate binaries
mkdir ~/bin -p

# cli-funtime
apt-get install irssi qalc git moc -y

# ppa's
apt-add-repository ppa:bartbes/love-stable -y
apt-add-repository ppa:ubuntu-wine/ppa -y
apt-add-repository ppa:team-xbmc/ppa -y
apt-get update -y

# repos

# Skype is another kind of exception. Using Skype to talk with someone else
# who is using Skype is encouraging the other to use nonfree software. So I
# won't use it under any circumstances. -RMS
add-apt-repository \
  "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

# openbox
# I think obkey got added to the ubuntu 12.04 repos
apt-get install openbox obconf obmenu grun feh conky lxappearance -y

# obkey (No idea why this isn't in the repos.)
# source
cd ~/bin/
git clone https://github.com/nsf/obkey.git
ln ~/bin/obkey/obkey /usr/games/ -s

# internet
apt-get install chromium-browser transmission pidgin skype -y

# desktop
apt-get install nvidia-settings gtk-recordmydesktop -y

# dev
apt-get install gimp gcolor2 agave libreoffice kodos meld mercurial gedit-developer-plugins php5-cli -y

# vidya
apt-get install love wine gweled -y

# media
apt-get install vlc rhythmbox audacity xbmc -y

# don't want this!
#apt-get remove

apt-get upgrade -y
apt-get autoclean -y
apt-get autoremove -y
