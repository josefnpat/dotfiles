#!/bin/sh

# init to home folder
cd ~

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
  "deb http://archive.canonical.com/ $(lsb_release -sc) partner" -y

# openbox
# I think obkey got added to the ubuntu 12.04 repos
apt-get install openbox obconf obmenu grun feh conky lxappearance -y

# alternate binaries / sources
mkdir ~/bin -p
cd ~/bin/

# obkey (No idea why this isn't in the repos.)
# source
git clone https://github.com/nsf/obkey.git
ln ~/bin/obkey/obkey /usr/games/ -s

# gist - Not sure if this works.
# source
git clone https://github.com/gmarik/gist.sh.git
ln ~/bin/gist.sh/gist.sh /usr/games/gist -s

# internet
apt-get install chromium-browser transmission pidgin skype -y

# desktop
apt-get install nvidia-settings gtk-recordmydesktop -y

# dev
apt-get install gimp gcolor2 agave libreoffice kodos meld mercurial gedit-developer-plugins php5-cli -y

# dev-love
apt-get install love lua5.1 liblua5.1-socket2 -y

# vidya
apt-get install wine gweled -y

# media
apt-get install vlc rhythmbox audacity xbmc -y

# things not included in 12.04
apt-get install synaptic gdebi gdebi-core tree -y

# script dependencies
#imgur [ubuntu 12.04]
apt-get install curl scrot xclip -y
#imgur [other]
#apt-get install grep libnotify

# don't want this!
apt-get remove update-manager -y

apt-get upgrade -y
apt-get autoclean -y
apt-get autoremove -y
