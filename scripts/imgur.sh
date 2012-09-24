#!/bin/bash

#http://sirupsen.com/a-simple-imgur-bash-screenshot-utility/

function uploadImage {
  curl -s -F "image=@$1" -F "key=486690f872c678126a2c09a9e196ce1b" http://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"
}
scrot -s "shot.png"
uploadImage "shot.png" | tr -d '\n' | xclip -selection c

$temp | xclip -o

echo $temp

rm "shot.png"
notify-send "Done"