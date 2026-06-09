#!/bin/bash

if [ "$1" = "connect" ]; then
  nmcli dev wifi connect "$2"
else
  output=$(nmcli -t -f SSID dev wifi list | awk '!seen[$0]++')

  if [ -z "$output" ]; then
    echo '[]'
  else
    echo "$output" | jq -R . | jq -s .
  fi
fi
