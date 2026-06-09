#!/bin/bash

if [ "$1" = "set" ]; then
  pactl set-default-source "$2"
else
  pactl list sources | awk '
    /^[[:space:]]*Name:/ { 
      name = $2 
    }
    /^[[:space:]]*Description:/ {
      $1 = ""
      desc = $0
      sub(/^[[:space:]]+/, "", desc)
      
      # Filtramos los "monitor" para que solo salgan micrófonos reales
      if (name !~ /monitor/) {
        printf "{\"name\": \"%s\", \"desc\": \"%s\"}\n", name, desc
      }
    }
  ' | jq -s . || echo '[]'
fi
