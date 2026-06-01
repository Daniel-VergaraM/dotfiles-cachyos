#!/bin/bash

URL="https://minimalistic-wallpaper.demolab.com/?random"
FILE="/tmp/wall_lock.jpg"

while true; do
  curl -L "$URL" -o "$FILE" >/dev/null 2>&1
  sleep 300
done
