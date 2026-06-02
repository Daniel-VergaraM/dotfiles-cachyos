#!/bin/bash

MODE=$(~/.config/local-bin/fan-toggle.sh get)

case "$MODE" in
quiet)
  echo '{"text":" Silent","class":"quiet"}'
  ;;
balanced)
  echo '{"text":" Normal","class":"balanced"}'
  ;;
performance)
  echo '{"text":" Turbo","class":"performance"}'
  ;;
esac
