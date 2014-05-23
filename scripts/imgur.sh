#!/bin/bash

# USAGE:
# 1) Hook this script up to your favorite shortcut key, and when the dialog comes up, either;
#   a) Put in the number of seconds (e.g. 0.25 or 3, default 1)
#   b) cancel it
# 2) Select the area you want to record.
# 3) If you put in a number, you will get a GIF image. If you canceled, you will get a PNG

# DEPS

# Arch
# sudo pacman -S zenity curl imagemagick notify-send xclip ffmpeg
# AUR https://aur.archlinux.org/packages.php?ID=32158 for xrectsel

# Debian
# sudo apt-get install zenity curl imagemagick notify-send xclip ffmpeg
# make install https://github.com/lolilolicon/FFcast2

TIME=`zenity --title "imgurgif" --entry --text="How many seconds?" --entry-text=1`
FPS=12
let MAXSIZE=2*1024
let DELAY=1/$FPS
let GIFDELAY=$DELAY*100
TMP="/tmp/imgur/"

#http://sirupsen.com/a-simple-imgur-bash-screenshot-utility/

function uploadImage {
  LINK=`curl -s -F "image=@$1" -F "key=486690f872c678126a2c09a9e196ce1b" http://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"`
}

function clearTemp {
  rm ${TMP}*.png
  rm ${TMP}*.gif
}

USEPNG=false
if [ -z "$TIME" ]
then
  TIME=0
  USEPNG=true
fi

echo "Fecording: ${TIME}s @ ${FPS}f/s"

mkdir -p $TMP
mkdir -p $TMP/fail

clearTemp

if $USEPNG
then
  SEL=`xrectsel "%wx%h+%x+%y"`
  import -window root -crop $SEL +repage -quality 100 ${TMP}single.png
  notify-send "Rendering PNG"
  notify-send "Uploading PNG [ "`du -h ${TMP}single.png | awk '{print $1}'`" ]"
  uploadImage ${TMP}single.png
  echo $LINK | tr -d '\n' | xclip -selection c
  notify-send "Uploaded PNG - $LINK"
else
  SEL=`xrectsel "-s %wx%h -i :0.0+%x,%y"`
  ffmpeg -r $FPS -t $TIME -f x11grab $SEL ${TMP}%09d.png
  notify-send "Rendering GIF"
  convert -layers OptimizeTransparency -delay $GIFDELAY \
    -loop 0 $(ls ${TMP}*.png | sort -V) ${TMP}imgmagik.gif
  FS=`du ${TMP}imgmagik.gif | awk '{print $1}'`
  if [ "$FS" -le "$MAXSIZE" ]
  then
    notify-send "Uploading GIF [ "`du -h ${TMP}imgmagik.gif | awk '{print $1}'`" ]"
    uploadImage ${TMP}imgmagik.gif
    echo $LINK | tr -d '\n' | xclip -selection c
    notify-send "Uploaded GIF - $LINK"
  else
    D=`date '+%s'`
    notify-send "Error: Surpassed ${MAXSIZE}K Limit. ${TMP}fail/$D.gif"
    mv ${TMP}imgmagik.gif ${TMP}fail/${D}.gif
  fi
fi

echo $LINK
echo $LINK >> ${TMP}imgur.log

clearTemp
