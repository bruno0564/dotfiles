# dotfiles — Hyprland

Configuración personal de Hyprland para Arch Linux en un portátil con GPU NVIDIA.  
Los colores se generan automáticamente con **matugen** (Material You) a partir del wallpaper activo.

---

## Componentes

| Rol | Herramienta |
|---|---|
| Compositor | Hyprland |
| Terminal | Kitty |
| Lanzador | Rofi (`drun`) |
| Barra | Waybar |
| Notificaciones | Swaync |
| Idle / bloqueo | Hypridle + Hyprlock |
| OSD volumen/brillo | Swayosd |
| Wallpaper | Awww |
| Colores | Matugen (Material You) |
| Gestor de archivos | Nautilus |

---

## Atajos de teclado

`SUPER` = tecla Windows

### Aplicaciones

| Atajo | Acción |
|---|---|
| `SUPER + Enter` | Terminal (Kitty) |
| `SUPER + Space` | Lanzador (Rofi) |
| `SUPER + E` | Gestor de archivos (Nautilus) |
| `SUPER + W` | Selector de wallpaper |
| `SUPER + I` | IntelliJ IDEA |

### Gestión de ventanas

| Atajo | Acción |
|---|---|
| `SUPER + C` | Cerrar ventana activa |
| `SUPER + V` | Alternar ventana flotante |
| `SUPER + P` | Pseudotile (dwindle) |
| `SUPER + J` | Rotar split (dwindle) |
| `SUPER + M` | Salir de Hyprland |

### Foco

| Atajo | Acción |
|---|---|
| `SUPER + H` | Foco izquierda |
| `SUPER + L` | Foco derecha |
| `SUPER + K` | Foco arriba |
| `SUPER + J` | Foco abajo |

### Workspaces

| Atajo | Acción |
|---|---|
| `SUPER + 1..0` | Ir al workspace 1–10 |
| `SUPER + SHIFT + 1..0` | Mover ventana al workspace 1–10 |
| `SUPER + Scroll` | Workspace anterior / siguiente |
| `SUPER + Tab` | Vista general de workspaces (hyprexpo) |

### Scratchpad

| Atajo | Acción |
|---|---|
| `SUPER + S` | Mostrar / ocultar scratchpad |
| `SUPER + SHIFT + S` | Enviar ventana al scratchpad |

### Capturas de pantalla

| Atajo | Acción |
|---|---|
| `Print` | Captura de ventana activa |
| `SHIFT + Print` | Captura de región seleccionada |

### Sistema

| Atajo | Acción |
|---|---|
| `SUPER + SHIFT + L` | Bloquear pantalla (Hyprlock) |
| Teclas `XF86` | Volumen, silencio, micrófono (swayosd) |
| Teclas `XF86` | Brillo (swayosd) |
| Teclas media | Play/Pause, Siguiente, Anterior (playerctl) |

### Gestos touchpad

| Gesto | Acción |
|---|---|
| 3 dedos → derecha | Workspace anterior |
| 3 dedos → izquierda | Workspace siguiente |

---

## Workspace 1 — Dashboard

El workspace 1 arranca automáticamente con 4 ventanas flotantes posicionadas:

```
┌─────────────────┬─────────────────┐
│                 │   tty-clock     │
│    Spotify      ├────────┬────────┤
│                 │cbonsai │ pipes  │
└─────────────────┴────────┴────────┘
```

Todas las apps decorativas arrancan con `sleep 3` para dar tiempo a que Hyprland inicialice.

---

## Apariencia

- **Layout:** Dwindle con pseudotile
- **Gaps:** 5px interior / 5px exterior
- **Bordes:** 2px, gradiente Material You (color primario → terciario, 45°)
- **Redondeo:** 10px
- **Blur:** activado (size 5, 3 passes)
- **Sombras:** activadas
- **Opacidad inactiva:** 0.8 global; terminales al 0.7/0.875

---

## Plugins

### hyprexpo
Vista general de todos los workspaces en cuadrícula 3×3.  
Se carga automáticamente al inicio con `hyprpm reload -n`.

```ini
plugin:hyprexpo {
    columns = 3
    gap_size = 5
    bg_col = rgb(111111)
    workspace_method = center current
}
```

---

## Colores (matugen)

Los colores se generan en `~/.config/hypr/colors.conf` y se actualizan automáticamente al cambiar el wallpaper con el script `wppicker.sh`. Usan el sistema **Material You**: el wallpaper define la paleta completa de la sesión (barra, bordes, notificaciones...).

---

## Scripts

| Script | Función |
|---|---|
| `wppicker.sh` | Selector de wallpaper + regenera colores con matugen |
| `hyprlock.sh` | Lanzador de hyprlock con opciones |
| `Wlogout.sh` | Menú de cierre de sesión |
| `tty-clock.sh` | Reloj en terminal (workspace 1) |
| `cbonsai.sh` | Bonsái animado en terminal (workspace 1) |
| `pipes.sh` | Pipes animados en terminal (workspace 1) |
| `AirplaneMode.sh` | Toggle modo avión |

---

## Notas de configuración

- **Teclado:** layout `latam` (soluciona bug de dead keys con `kb_layout = es` en Wayland/libxkbcommon)
- **NVIDIA:** variables de entorno configuradas para Wayland nativo (`GBM_BACKEND`, `__GLX_VENDOR_LIBRARY_NAME`, `NVD_BACKEND`)
- **Electron apps** (Spotify, Discord, VSCode): usan backend Wayland nativo via `ELECTRON_OZONE_PLATFORM_HINT=auto`
- **Monitor:** escala 1.33× en `eDP-1` para resolución correcta en pantalla del portátil
