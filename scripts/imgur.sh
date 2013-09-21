#!/bin/sh

# USAGE:
# 1) Hook this script up to your favorite shortcut key, and when the dialog comes up, either;
#   a) Put in the number of seconds (e.g. 0.25 or 3, default 1)
#   b) cancel it
# 2) Select the area you want to record.
# 3) If you put in a number, you will get a GIF image. If you canceled, you will get a PNG

# DEPS
# sudo pacman -S zenity curl imagemagick notify-send xclip ffmpeg
# AUR https://aur.archlinux.org/packages.php?ID=32158 for xrectsel

TIME=`zenity --title "imgurgif" --entry --text="How many seconds?" --entry-text=1`
FPS=12
let MAXSIZE=2*1024*1024
let DELAY=1/$FPS
let GIFDELAY=$DELAY*100
TMP="/tmp/imgur/"

#http://sirupsen.com/a-simple-imgur-bash-screenshot-utility/

function uploadImage {
  LINK=`curl -s -F "image=@$1" -F "key=486690f872c678126a2c09a9e196ce1b" http://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"`
}

USEPNG=false
if [ -z "$TIME" ]
then
  TIME=0
  USEPNG=true
fi

let FRAMES=$TIME*$FPS+1

echo "Fecording: ${TIME}s @ $FPS/s"
echo "Frame Count: ${FRAMES}"

SEL=`xrectsel "-s %wx%h -i :0.0+%x,%y"`

mkdir -p $TMP

ffmpeg -r $FPS -t $TIME -f x11grab $SEL ${TMP}%09d.png

if $USEPNG
then
  notify-send "Rendering PNG"
  notify-send "Uploading PNG [ "`du -h ${TMP}1.png | awk '{print $1}'`" ]"
  uploadImage ${TMP}1.png
  echo $LINK | tr -d '\n' | xclip -selection c
  notify-send "Uploaded PNG - $LINK"
else
  notify-send "Rendering GIF"
  convert -layers OptimizeTransparency -delay $GIFDELAY \
    -loop 0 $(ls ${TMP}*.png | sort -V) ${TMP}imgmagik.gif
  notify-send "Uploading GIF [ "`du -h ${TMP}imgmagik.gif | awk '{print $1}'`" ]"
  uploadImage ${TMP}imgmagik.gif
  echo $LINK | tr -d '\n' | xclip -selection c
  notify-send "Uploaded GIF - $LINK"
fi

echo $LINK
echo $LINK >> ${TMP}imgur.log

rm ${TMP}*.png
rm ${TMP}*.gif
