#!/bin/sh
# Recursively expand
find . -name "$1" | while read line
do
  expand --tabs=2 $line > $line.tmp
  mv $line.tmp $line
done