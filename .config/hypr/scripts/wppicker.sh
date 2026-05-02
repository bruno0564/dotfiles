#!/bin/bash

# === CONFIG ===
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"

cd "$WALLPAPER_DIR" || exit 1

# === handle spaces name
IFS=$'\n'

# === ICON-PREVIEW SELECTION WITH ROFI, SORTED BY NEWEST ===
SELECTED_WALL=$(for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -p "")
[ -z "$SELECTED_WALL" ] && exit 1
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

# === GENERATE COLORS ===
matugen image "$SELECTED_PATH" --prefer saturation

# === UPDATE STARSHIP COLORS ===
COLORS_CSS="$HOME/.config/waybar/colors.css"
STARSHIP_TOML="$HOME/.config/starship.toml"

get_color() {
    grep "@define-color $1 " "$COLORS_CSS" | grep -oP '#[0-9a-fA-F]+'
}

for key in primary on_primary secondary on_secondary tertiary on_tertiary surface surface_container on_surface error; do
    value=$(get_color "$key")
    [ -n "$value" ] && sed -i "/^${key}\s*=/{s|\"#[0-9a-fA-F]*\"|\"${value}\"|}" "$STARSHIP_TOML"
done

# === SET WALLPAPER ===
awww img "$SELECTED_PATH" --transition-type any --transition-fps 60

# === CREATE SYMLINK ===
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"

