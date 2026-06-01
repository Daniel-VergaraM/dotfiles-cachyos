#!/bin/bash

# ---- HEIGHT LIMPIO ----
HEIGHT=$(hyprctl monitors | grep -m1 -o '[0-9]\+x[0-9]\+' | head -n1 | cut -d'x' -f2 | tr -d '[:space:]')

# fallback seguro
if ! [[ "$HEIGHT" =~ ^[0-9]+$ ]]; then
  HEIGHT=1080
fi

# ---- SISTEMA DE LAYOUT (proporcional real) ----

CENTER_Y=0

AVATAR_Y=$((HEIGHT * 14 / 100))
USER_Y=$((HEIGHT * 8 / 100))
HORA_Y=0
FECHA_Y=$((HEIGHT * -6 / 100))
INPUT_Y=$((HEIGHT * -20 / 100))

# ---- TIPOGRAFÍA ----

FONT_HORA=$((HEIGHT * 6 / 100))
FONT_FECHA=$((HEIGHT * 20 / 1000))
FONT_USER=$((HEIGHT * 18 / 1000))

# ---- ELEMENTOS ----

AVATAR_SIZE=$((HEIGHT * 7 / 100))

INPUT_W=$((HEIGHT * 32 / 100))
INPUT_H=$((HEIGHT * 5 / 100))

# ---- CONFIG ----

cat >~/.config/hypr/hyprlock.conf <<EOF
general {
    grace = 2
    disable_loading_bar = true
    hide_cursor = true
}

background {
    path = /tmp/wall_lock.jpg

    blur_passes = 4
    blur_size = 7

    brightness = 0.62
    contrast = 1.12
    noise = 0.002
}

# ---- AVATAR ----
image {
    path = /home/dvergaram/Descargas/avatar.jpg
    size = $AVATAR_SIZE
    rounding = 999

    position = 0, $AVATAR_Y
    halign = center
    valign = center
}

# ---- USER ----
label {
    text = \$USER
    font_size = $FONT_USER
    font_family = Sans

    position = 0, $USER_Y
    halign = center
    valign = center

    color = rgba(255,255,255,0.72)
}

# ---- HORA ----
label {
    text = cmd[update:1000] date +"%H:%M"
    font_size = $FONT_HORA
    font_family = Sans

    position = 0, $HORA_Y
    halign = center
    valign = center

    color = rgba(255,255,255,0.98)
}

# ---- FECHA ----
label {
    text = cmd[update:1000] date +"%A, %d %B"
    font_size = $FONT_FECHA
    font_family = Sans

    position = 0, $FECHA_Y
    halign = center
    valign = center

    color = rgba(255,255,255,0.50)
}

# ---- INPUT ----
input-field {
    size = $INPUT_W, $INPUT_H
    outline_thickness = 0

    inner_color = rgba(255,255,255,0.05)
    outer_color = rgba(255,255,255,0.15)

    font_color = rgba(255,255,255,1.0)

    rounding = 24

    fade_on_empty = false
    placeholder_text = Password

    position = 0, $INPUT_Y
    halign = center
    valign = center
}
EOF
