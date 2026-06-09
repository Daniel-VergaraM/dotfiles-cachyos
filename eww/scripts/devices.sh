#!/bin/bash

if [ "$1" = "set" ]; then
  pactl set-default-sink "$2"
else
  # Extrae Nombre y Descripción de la salida cruda y crea un JSON válido
  pactl list sinks | awk '
    /^[[:space:]]*Name:/ { 
      name = $2 
    }
    /^[[:space:]]*Description:/ {
      $1 = ""
      desc = $0
      # Limpiar espacios al inicio
      sub(/^[[:space:]]+/, "", desc)
      # Imprimir en formato JSON
      printf "{\"name\": \"%s\", \"desc\": \"%s\"}\n", name, desc
    }
  ' | jq -s . || echo '[]'
fi
