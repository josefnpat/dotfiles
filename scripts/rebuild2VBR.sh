#!/bin/bash

if [ $# != 2 ]; then
	echo "\nThis script will lame all files with
an ID3 in SOURCE directory recursively
to the DEST directory.
DEST must have trailing \"/\".
Usage: sh rebuildVBR.sh SOURCE DEST

mp3's without ID3 tags can be identified with a \"✕\".
They are not copied.
mp3's that are processed succesfully can be identified with a \"✔\".

Written by Josef N Patoprsty
email:seppi(at)josefnpat.com"
else
	GOOD="0"
	BAD="0"

	find "$1" -type f | while read i ; do

		#get info from file
		TITLE="`id3tool "$i" | grep '^Song Title:' | awk '{ for (i=3;i<=NF;i++) { printf $i; printf " " } }'`"
		ARTIST="`id3tool "$i" | grep '^Artist:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
		ALBUM="`id3tool "$i" | grep '^Album:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
		TRACKNUM="`id3tool "$i" | grep '^Track:' | awk '{ print $2 }'`"
   	YEAR="`id3tool "$i" | grep '^Year:' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"
		HASTAG="`id3tool "$i" | grep '^No\ ID3\ Tag' | awk '{ for (i=2;i<=NF;i++) { printf $i; printf " " } }'`"

		#output info
	
		if [ "$HASTAG" = "" ]; then
			GOOD=$((GOOD+1))
			#Has Tag
			echo "✔$GOOD: $ARTIST"/"$ALBUM"/"$TRACKNUM - $TITLE".mp3

			#replace slashes with underscores
			ARTIST=$(echo $ARTIST | sed -e 's/\//_/g')
			ALBUM=$(echo $ALBUM | sed -e 's/\//_/g')
			TRACKNUM=$(echo $TRACKNUM | sed -e 's/\//_/g')
			TITLE=$(echo $TITLE | sed -e 's/\//_/g')

			#install the file to new pos
         mkdir "$2$ARTIST"/
         mkdir "$2$ARTIST"/"$ALBUM"/
         lame -vh --add-id3v2 --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tn "$TRACKNUM" "$i" "$2$ARTIST"/"$ALBUM"/"$TRACKNUM - $TITLE".mp3
		else
			BAD=$((BAD+1))
			#No Tag
			echo "✕$BAD: $i"
		fi
	done
fi
