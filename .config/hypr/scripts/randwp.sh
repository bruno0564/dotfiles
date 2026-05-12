#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"

# Pick random wallpaper
SELECTED_PATH=$(find "$WALLPAPER_DIR" -maxdepth 1 \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)
[ -z "$SELECTED_PATH" ] && exit 1

# Generate colors
matugen image "$SELECTED_PATH" --prefer saturation

# Update Starship colors
COLORS_CSS="$HOME/.config/waybar/colors.css"
STARSHIP_TOML="$HOME/.config/starship.toml"

get_color() {
    grep "@define-color $1 " "$COLORS_CSS" | grep -oP '#[0-9a-fA-F]+'
}

for key in primary on_primary secondary on_secondary tertiary on_tertiary surface surface_container on_surface error; do
    value=$(get_color "$key")
    [ -n "$value" ] && sed -i "/^${key}\s*=/{s|\"#[0-9a-fA-F]*\"|\"${value}\"|}" "$STARSHIP_TOML"
done

# Reload colors
hyprctl reload
pkill -x waybar; waybar &disown

# Set wallpaper
awww img "$SELECTED_PATH" --transition-type any --transition-fps 60

# Update symlink
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"
