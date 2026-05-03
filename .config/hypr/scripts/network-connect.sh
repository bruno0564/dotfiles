#!/bin/bash

EDUROAM_IDENTITY="bcm61@alu.ua.es"
EDUROAM_ANON="joyboy@alu.ua.es"
EDUROAM_CERT="/home/joyboy/.config/certs/inal16.der"

WIFI_DEV=$(nmcli -t -f TYPE,DEVICE device | grep "^wifi:" | head -1 | cut -d: -f2)

[ -z "$WIFI_DEV" ] && notify-send "Red" "No hay adaptador WiFi" && exit 0

nmcli device wifi rescan ifname "$WIFI_DEV" 2>/dev/null
sleep 1

declare -A seen
menu_lines=()
ssid_list=()
inuse_list=()

while IFS=: read -r inuse ssid signal security; do
    [ -z "$ssid" ] && continue
    [ "${seen[$ssid]+_}" ] && continue
    seen[$ssid]=1

    if   [ "$signal" -ge 75 ]; then icon="󰤨"
    elif [ "$signal" -ge 50 ]; then icon="󰤥"
    elif [ "$signal" -ge 25 ]; then icon="󰤢"
    else icon="󰤟"; fi

    lock=""; [ "$security" != "--" ] && [ -n "$security" ] && lock=" 󰌾"
    star=""; [ "$inuse" = "*" ] && star=" ●"

    menu_lines+=("$icon $ssid [$signal%]$lock$star")
    ssid_list+=("$ssid")
    inuse_list+=("$inuse")
done < <(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list ifname "$WIFI_DEV" 2>/dev/null)

[ ${#menu_lines[@]} -eq 0 ] && notify-send "WiFi" "No se encontraron redes" && exit 0

selected=$(printf '%s\n' "${menu_lines[@]}" | rofi -dmenu -p "󰤨 WiFi" -i)
[ -z "$selected" ] && exit 0

idx=$(printf '%s\n' "${menu_lines[@]}" | grep -nxF "$selected" | head -1 | cut -d: -f1)
[ -z "$idx" ] && exit 0
ssid="${ssid_list[$((idx - 1))]}"
inuse="${inuse_list[$((idx - 1))]}"

if [ "$inuse" = "*" ]; then
    nmcli connection down "$ssid" 2>/dev/null
    notify-send "WiFi" "Desconectado de $ssid"
    exit 0
fi

# Eduroam: configuración enterprise automática
if [ "$ssid" = "eduroam" ]; then
    password=$(rofi -dmenu -p "Contraseña eduroam" -password)
    [ -z "$password" ] && exit 0

    # Eliminar perfil anterior si existe para aplicar config limpia
    nmcli connection delete "eduroam" 2>/dev/null

    nmcli connection add type wifi con-name "eduroam" ifname "$WIFI_DEV" ssid "eduroam" \
        wifi-sec.key-mgmt wpa-eap \
        802-1x.eap peap \
        802-1x.identity "$EDUROAM_IDENTITY" \
        802-1x.anonymous-identity "$EDUROAM_ANON" \
        802-1x.ca-cert "$EDUROAM_CERT" \
        802-1x.phase2-auth mschapv2 \
        802-1x.password "$password" \
        && nmcli connection up "eduroam" \
        && notify-send "WiFi" "Conectado a eduroam" \
        || notify-send "WiFi" "Error al conectar a eduroam — comprueba la contraseña"
    exit 0
fi

# Red normal con perfil guardado
if nmcli connection show "$ssid" &>/dev/null; then
    nmcli connection up "$ssid" \
        && notify-send "WiFi" "Conectado a $ssid" \
        || notify-send "WiFi" "Error al conectar a $ssid"
else
    if echo "$selected" | grep -q "󰌾"; then
        password=$(rofi -dmenu -p "Contraseña para $ssid" -password)
        [ -z "$password" ] && exit 0
        nmcli device wifi connect "$ssid" password "$password" ifname "$WIFI_DEV" \
            && notify-send "WiFi" "Conectado a $ssid" \
            || notify-send "WiFi" "Contraseña incorrecta o error al conectar"
    else
        nmcli device wifi connect "$ssid" ifname "$WIFI_DEV" \
            && notify-send "WiFi" "Conectado a $ssid" \
            || notify-send "WiFi" "Error al conectar a $ssid"
    fi
fi
