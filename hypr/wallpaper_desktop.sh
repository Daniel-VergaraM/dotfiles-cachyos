#!/bin/bash

URL="https://minimalistic-wallpaper.demolab.com/?random"
FILE="/tmp/wall_desktop.jpg"

while true; do
  curl -L "$URL" -o "$FILE" >/dev/null 2>&1
  awww img "$FILE" >/tmp/awww.log 2>&1
  sleep 300
done
