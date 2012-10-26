#!/bin/sh

# init to home folder
cd ~
# alternate binaries
mkdir ~/bin -p

# cli-funtime
apt-get install irssi git qalc moc tmux -y

# ppa's
apt-add-repository ppa:bartbes/love-stable -y
apt-add-repository ppa:ubuntu-wine/ppa -y
apt-add-repository ppa:team-xbmc/ppa -y
apt-add-repository ppa:a-v-shkop/chromium -y # Temporary solution for chromium 22.x
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

# dev-love
apt-get install love lua5.1 liblua5.1-socket2

# vidya
apt-get install wine gweled -y

# media
apt-get install vlc rhythmbox audacity xbmc -y

# things not included in 12.04
apt-get install synaptic gdebi gdebi-core tree

# script dependencies
#imgur [ubuntu 12.04]
apt-get install curl scrot xclip
#imgur [other]
#apt-get install grep libnotify

# don't want this!
#apt-get remove

apt-get upgrade -y
apt-get autoclean -y
apt-get autoremove -y
