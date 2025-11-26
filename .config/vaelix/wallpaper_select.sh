#!/usr/bin/env bash
if pidof rofi > /dev/null; then
    pkill rofi
fi

wallpapers_dir="$HOME/Pictures/Wallpapers"

# Check if directory exists
if [ ! -d "$wallpapers_dir" ]; then
    notify-send "Wallpaper Selector" "No wallpapers found in $wallpapers_dir"
    exit 1
fi

selected_wallpaper=$(for a in "$wallpapers_dir"/*; do
    echo -en "$(basename "${a%.*}")\0icon\x1f$a\n"
done | rofi -dmenu -p " ")

if [ -n "$selected_wallpaper" ]; then
    image_fullname_path=$(find "$wallpapers_dir" -type f -name "$selected_wallpaper.*" | head -n 1)
    if [ -n "$image_fullname_path" ]; then
        swaymsg output "*" bg "$image_fullname_path" fill
        notify-send "Wallpaper Changed" "Applied: $selected_wallpaper"
    fi
fi
