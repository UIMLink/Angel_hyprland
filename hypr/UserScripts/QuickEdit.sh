#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

configs="$HOME/.config/hypr/configs"
hypr="$HOME/.config/hypr"
Configs="$HOME/.config/hypr/Configs"

menu(){
  printf "1. edit WindowRules\n"
  printf "2. edit Startup Apps\n"
  printf "3. edit Keybinds\n"
  printf "4. edit Monitors\n"
  printf "5. edit Settings\n"
  printf "6. edit Hyprland.conf\n"
  printf "7. edit Hyprlock.conf\n"
  printf "8. edit Pyprland.conf\n"
}

main() {
    choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
    case $choice in
        1)
            code "$Configs/WindowRules.conf"
            ;;
        2)
            code "$Configs/Startup_Apps.conf"
            ;;
        3)
            code "$Configs/Keybinds.conf"
            ;;
        4)
            code "$Configs/Monitors.conf"
            ;;
        5)
            code "$Configs/Settings.conf"
            ;;
        6)
            code "$hypr/hyprland.conf"
            ;;
        7)
            code "$hypr/hyprlock.conf"
            ;;
        8)
            code "$hypr/pyprland.toml"
            ;;
        *)
            ;;
    esac
}

main