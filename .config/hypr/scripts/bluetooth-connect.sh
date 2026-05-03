#!/bin/bash

paired=$(bluetoothctl devices Paired)

if [ -z "$paired" ]; then
    notify-send "Bluetooth" "No hay dispositivos emparejados"
    exit 0
fi

menu=$(echo "$paired" | while read -r _ mac name; do
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        echo "󰂱 $name [$mac]"
    else
        echo "  $name [$mac]"
    fi
done)

selected=$(echo "$menu" | rofi -dmenu -p "󰂰 Bluetooth" -i)

[ -z "$selected" ] && exit 0

mac=$(echo "$selected" | grep -oP '([0-9A-F]{2}:){5}[0-9A-F]{2}')

if echo "$selected" | grep -q "󰂱"; then
    bluetoothctl disconnect "$mac"
    notify-send "Bluetooth" "Desconectado"
else
    bluetoothctl connect "$mac"
    notify-send "Bluetooth" "Conectando..."
fi
