#!/bin/bash

if [ "$1" = "connect" ]; then
  bluetoothctl connect "$2"
else
  output=$(bluetoothctl devices | cut -d ' ' -f3-)

  if [ -z "$output" ]; then
    echo '[]'
  else
    echo "$output" | jq -R . | jq -s .
  fi
fi
