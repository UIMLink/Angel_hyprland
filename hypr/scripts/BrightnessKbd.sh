#!/bin/bash

# Path to the brightness file
brightness_file="/sys/class/leds/kbd_backlight/brightness"

# Function to get current keyboard brightness
get_kbd_backlight() {
    cat "$brightness_file"
}

# Function to change keyboard brightness
change_kbd_backlight() {
    current_brightness=$(get_kbd_backlight)
    if [[ "$1" == "--inc" ]]; then
        new_brightness=$((current_brightness + 15))
    elif [[ "$1" == "--dec" ]]; then
        new_brightness=$((current_brightness - 15))
    else
        echo "Invalid argument: $1"
        exit 1
    fi

    # Ensure brightness is within valid range
    if [[ "$new_brightness" -lt 0 ]]; then
        new_brightness=0
    elif [[ "$new_brightness" -gt 255 ]]; then
        new_brightness=255
    fi

    echo "Setting brightness to: $new_brightness"
    echo "$new_brightness" | sudo tee "$brightness_file" >/dev/null
    local result=$?
    echo "Result of setting brightness: $result"
    notify_user "$new_brightness"
}

# Function to notify user about brightness change
notify_user() {
    current="$1"
    iDIR="$HOME/.config/swaync/icons"
    echo "Keyboard Brightness changed to: $current%"
}

# Debugging statement to log script execution with arguments
echo "Script executed with argument: $1" >> /tmp/brightness_log.txt

# Main script logic
case "$1" in
    "--inc")
        change_kbd_backlight "--inc"
        ;;
    "--dec")
        change_kbd_backlight "--dec"
        ;;
    *)
        echo "Usage: $0 {--inc|--dec}"
        exit 1
        ;;
esac

exit 0
x