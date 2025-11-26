#!/usr/bin/env bash
wallpapers_dir="$HOME/Pictures/Wallpapers"

# Check if directory exists
if [ ! -d "$wallpapers_dir" ]; then
    notify-send "Random Wallpaper" "No wallpapers found in $wallpapers_dir"
    exit 1
fi

random_wallpaper=$(find "$wallpapers_dir" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)

if [ -n "$random_wallpaper" ]; then
    swaymsg output "*" bg "$random_wallpaper" fill
    notify-send "Random Wallpaper" "Applied: $(basename "$random_wallpaper")"
fi
