#!/bin/bash

case "$1" in
listen)
  while true; do
    pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n1 | tr -d '%'
    sleep 1
  done
  ;;
set)
  pactl set-sink-volume @DEFAULT_SINK@ "$2%"
  ;;
esac
