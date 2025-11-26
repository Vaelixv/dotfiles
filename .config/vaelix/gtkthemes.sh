#!/usr/bin/env bash
SCHEME="prefer-dark"
THEME="adw-gtk3-dark"
ICONS="Adwaita"
CURSOR="Adwaita"
UI_FONT="Sans 12"
MONO_FONT="JetBrainsMono Nerd Font 12"
SCHEMA="gsettings set org.gnome.desktop.interface"

apply_themes() {
    ${SCHEMA} color-scheme "$SCHEME"
    ${SCHEMA} gtk-theme "$THEME"
    ${SCHEMA} icon-theme "$ICONS"
    ${SCHEMA} cursor-theme "$CURSOR"
    ${SCHEMA} font-name "$UI_FONT"
    ${SCHEMA} monospace-font-name "$MONO_FONT"
}

apply_themes
