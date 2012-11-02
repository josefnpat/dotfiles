#!/bin/sh

apt-get install tasksel
tasksel install lamp-server

apt-get install phpmyadmin

# enable mod_rewrite
a2enmod rewrite

# restart apache
service apache2 restart

# Install of drush is a little more extensive than
# apt-get install drush, as it's not always the newest version.
# Bleeding edge, man! Install Gentoo.

# install php's pear
apt-get install php-pear
# discover the proper channel
pear channel-discover pear.drush.org
# download drush
pear install drush/drush
# run drush so it can get the proper files while in root
# (this is a one time thing.)
drush