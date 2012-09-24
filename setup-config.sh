#!/bin/sh
ln -s ~/dotfiles/config/conkyrc ~/.conkyrc
ln -s ~/dotfiles/config/nanorc ~/.nanorc
#Avoid the nano history error
rm ~/.nano_history
ln -s ~/dotfiles/config/openbox ~/.config/openbox
ln -s ~/dotfiles/config/gnome-terminal/ ~/.gconf/apps/gnome-terminal
ln -s ~/dotfiles/config/gedit-2/ ~/.gconf/apps/gedit-2
ln -s ~/dotfiles/config/gtk-3.0/ ~/.config/gtk-3.0
ln -s ~/dotfiles/config/irssi/ ~/.irssi
ln -s ~/dotfiles/config/bashrc ~/.bashrc