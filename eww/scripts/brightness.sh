#!/bin/bash

case "$1" in
listen)
  # Monitorea cambios y calcula el porcentaje real basado en el máximo del sistema
  while true; do
    max=$(brightnessctl m)
    curr=$(brightnessctl g)
    echo $((curr * 100 / max))
    sleep 1
  done
  ;;
set)
  brightnessctl s "$2%"
  ;;
esac
