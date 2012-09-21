#!/bin/sh

# init to home folder
cd ~

# ppa's
apt-add-repository ppa:bartbes/love-stable -y
apt-add-repository ppa:ubuntu-wine/ppa -y
apt-add-repository ppa:team-xbmc/ppa -y
apt-get update -y

# openbox
apt-get install openbox obconf obmenu grun -y

# stuff I like
apt-get install chromium-browser git nvidia-settings gtk-recordmydesktop -y

# dev
apt-get install gimp gcolor2 libreoffice kodos meld -y

# vidya gamez
apt-get install love love-unsatble wine gweled -y

# media
apt-get install vlc herrie rhythmbox audacity xbmc -y

# don't want this!
#apt-get remove

apt-get upgrade -y
apt-get autoclean -y
apt-get autoremove -y

# install alternate binaries
mkdir ~/bin

# obkey (No idea why this isn't in the repos.)
# deps
apt-get install git -y
# source
cd ~/bin/
git clone https://github.com/nsf/obkey.git
ln ~/bin/obkey/obkey /usr/games/ -s

# pyfa (eve online)
# deps
apt-get install git python python-wxgtk2.8 python-sqlalchemy python-matplotlib python-numpy -y
# source
cd ~/bin/
git clone git://www.evefit.org/pyfa.git
cd pyfa
git submodule update --init
cd ..
echo "#!/bin/sh\n~/bin/pyfa/pyfa.py" > /usr/games/pyfa
chmod a+x mc.sh

# gtkevemon (eve online)
# deps
apt-get install libssl1.0.0 subversion libgtk2.0-0 libgtkmm-2.4-1c2a libgtkmm-2.4-dev libxml2 libxml2-dev -y
# source
cd ~/bin/
svn checkout svn://svn.battleclinic.com/GTKEVEMon/trunk/gtkevemon
cd gtkevemon
make
make install

# go back to games
#deps
apt-get install openjdk-7 -y
#source
mkdir ~/games
mkdir ~/games/minecraft
cd ~/games/minecraft
wget -c https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft.jar
echo "#!/bin/sh\njava -Xmx1024M -Xms512M -cp ~/games/minecraft/minecraft.jar net.minecraft.LauncherFrame" > mc.sh
chmod a+x mc.sh
ln ~/games/minecraft/mc.sh /usr/games/minecraft