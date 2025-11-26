#!/usr/bin/env bash
# This requires 'yad' - install with: sudo dnf install yad
if ! command -v yad &> /dev/null; then
    notify-send "Key Hints" "Please install 'yad' package:\nsudo dnf install yad"
    exit 1
fi

if pidof yad > /dev/null; then
    pkill yad
fi

yad --center --title="Keybinding Hints - Vaelix" --no-buttons --list \
    --column=Key: --column="" --column=Description: \
    --timeout-indicator=bottom \
"  =   "          "        "  "SUPER KEY (Command/Windows Key)" \
"" "" "" \
"  H"              "        "  "Show keybinding hints" \
"  Space"          "        "  "Open terminal" \
"  E"              "        "  "Open file manager" \
"  B"              "        "  "Open browser" \
"" "" "" \
"  Shift Ctrl Esc" "        "  "Exit Sway" \
"  Q"              "        "  "Close active window" \
"  Shift Q"        "        "  "Kill active window by PID" \
"" "" "" \
"  F"              "        "  "Toggle floating" \
"  P"              "        "  "Toggle split layout" \
"  J"              "        "  "Toggle layout" \
"" "" "" \
"  L"              "        "  "Lock screen" \
"ALT Space"         "        "  "App launcher" \
"  ."              "        "  "Emoji selector" \
"  V"              "        "  "Clipboard manager" \
"  W"              "        "  "Choose wallpaper" \
"  Shift W"        "        "  "Random wallpaper" \
"  Shift S"        "        "  "Screenshot (region)" \
"" "" "" \
"  [1 -> 0]"       "        "  "Switch workspace 1-10" \
"  Shift [1 -> 0]" "        "  "Move window to workspace 1-10" \
"" "" "" \
"More Keybindings"   "        "  "$HOME/.config/sway/config"
