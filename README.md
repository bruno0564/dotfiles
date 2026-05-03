# dotfiles — Hyprland rice

Rice personal sobre **Arch Linux + Hyprland**. Paleta Material You generada dinámicamente desde el wallpaper con matugen — al cambiar el fondo, todos los colores del sistema cambian con él.

---

## Componentes

| Rol | Herramienta |
|---|---|
| Compositor | Hyprland |
| Barra | Waybar |
| Notificaciones | Swaync |
| Lanzador | Rofi |
| Terminal | Kitty |
| Shell prompt | Starship |
| Gestor de archivos | Nautilus |
| Fondo de pantalla | Awww |
| Lock screen | Hyprlock + Hypridle |
| OSD volumen/brillo | Swayosd |
| Colores dinámicos | Matugen |
| Música | Spotify + Spicetify |
| Browser | Zen Browser |
| Discord | Vesktop |

---

## Matugen — colores dinámicos

El núcleo estético del rice. `matugen` toma el wallpaper activo, extrae su color dominante y genera una paleta Material You completa que se propaga a todos los componentes en tiempo real:

- **Hyprland** — bordes, gradientes (`colors.conf`)
- **Waybar** — toda la barra (`colors.css`)
- **Rofi** — fondo, selección, bordes (`colors.rasi`)
- **Kitty** — esquema de color de la terminal (`colors.conf`)
- **Spicetify** — tema de Spotify (`color.ini`)
- **Vesktop** — QuickCSS para Discord
- **GTK 3/4** — diálogos y apps nativas
- **Cava** — visualizador de audio
- **Zen Browser** — `userChrome.css`
- **Starship** — prompt de la terminal

Para regenerar la paleta al cambiar wallpaper:
```bash
matugen image /ruta/al/wallpaper.jpg
```

---

## Hyprland

Layout **dwindle** con splits automáticos. Bordes de 2px con gradiente activo en 45° usando los colores primario y terciario de la paleta. Rounding de 10px. Blur activo (size 5, 3 pasadas).

### Monitor

```
eDP-1  →  resolución preferida, escala 1.33
```

### Variables de entorno (NVIDIA + Wayland)

```
LIBVA_DRIVER_NAME       = nvidia
GBM_BACKEND             = nvidia-drm
__GLX_VENDOR_LIBRARY_NAME = nvidia
NVD_BACKEND             = direct
GTK_THEME               = Adwaita:dark
ELECTRON_OZONE_PLATFORM_HINT = auto   # Spotify, VSCode, Discord en Wayland nativo
```

### Workspace 1 — dashboard

Al arrancar el sistema, el workspace 1 se configura automáticamente como un dashboard estético con cuatro ventanas flotantes posicionadas:

| Ventana | Posición | Tamaño |
|---|---|---|
| Spotify | esquina superior izquierda | 706 × 759 |
| tty-clock | esquina superior derecha | 706 × 373 |
| pipes.sh | esquina inferior derecha | 706 × 372 |

Al login, Hyprland salta automáticamente al workspace 2 para dejar el dashboard listo de fondo.

---

## Animaciones

Beziers personalizados con diferentes curvas para cada tipo de evento:

| Evento | Bezier | Estilo |
|---|---|---|
| Apertura de ventana | `slow` | `popin` suave |
| Cierre de ventana | `been` | `popin 70%` |
| Mover ventana | `wind` | `slide` |
| Cambio de workspace | `wind` | — |
| Fade | `overshot` | — |
| Ventana genérica | `bounce` | `popin` |

---

## Waybar

Barra superior con márgenes laterales (8px) y margen superior (3px). Estructura:

- **Izquierda** — reloj
- **Centro** — workspaces numerados
- **Derecha** — grupo laptop (batería), grupo audio, notificaciones swaync, grupo status

---

## Rofi

Lanzador centrado de 1000px de ancho con panel izquierdo mostrando el wallpaper actual como imagen de fondo. Colores tomados de la paleta matugen. Fuente JetBrainsMono Nerd Font, iconos Papirus. Tres modos: `drun`, `window`, `run`.

---

## Kitty

Terminal con **JetBrainsMono NF Bold** a 12pt. Cursor trail activado, scroll de 2000 líneas, padding de 4px. Opacidad gestionada por windowrules de Hyprland (`0.7` activa, `0.875` inactiva). Colores generados por matugen y recargados en caliente con `SIGUSR1`.

---

## Starship

Prompt en dos líneas con segmentos en píldoras usando la paleta Material You:

```
╭ joyboy  ~/directorio  󰘬 rama  cambios   HH:MM 
╰ ❯
```

Color de error en rojo Material You, modo vim con `❮`.

---

## Hyprlock

Pantalla de bloqueo con el wallpaper actual como fondo (blur + noise + contraste aumentado). Muestra hora en dos bloques grandes (112px), día de la semana y fecha debajo. Input field con rounding 22 y colores de la paleta activa.

---

## Hypridle

| Tiempo inactivo | Acción |
|---|---|
| 2 min 30 s | Atenúa pantalla al 10% |
| 5 min | Bloquea pantalla (`hyprlock`) |
| 5 min 30 s | Apaga display (DPMS off) |
| 30 min | Suspende el sistema |

Al volver del suspend: enciende DPMS y restaura brillo previo.

---

## Scripts

| Script | Descripción |
|---|---|
| `wppicker.sh` | Abre selector de wallpaper, aplica con awww y lanza `matugen` para regenerar colores |
| `tty-clock.sh` | Lanza `tty-clock` con colores de la paleta para el dashboard del workspace 1 |
| `pipes.sh` | Lanza `pipes.sh` animado para el dashboard del workspace 1 |
| `cbonsai.sh` | Lanza `cbonsai` animado |
| `cmatrix.sh` | Lanza `cmatrix` |
| `hyprlock.sh` | Wrapper para lanzar hyprlock evitando instancias duplicadas |
| `Wlogout.sh` | Abre el menú de apagado con wlogout |
| `AirplaneMode.sh` | Activa/desactiva modo avión (wifi + bluetooth) |
| `bluetooth-connect.sh` | Conecta dispositivos bluetooth rápidamente |
| `network-connect.sh` | Gestiona conexiones de red desde terminal |

---

## Atajos de teclado

> `SUPER` = tecla Windows/Meta

### Apps

| Atajo | Acción |
|---|---|
| `SUPER + Enter` | Abre Kitty (terminal) |
| `SUPER + Space` | Abre Rofi (lanzador de apps) |
| `SUPER + E` | Abre Nautilus (gestor de archivos) |
| `SUPER + Z` | Abre Zen Browser |
| `SUPER + I` | Abre IntelliJ IDEA |
| `SUPER + W` | Abre selector de wallpaper y regenera paleta de colores |

### Gestión de ventanas

| Atajo | Acción |
|---|---|
| `SUPER + C` | Cierra la ventana activa |
| `SUPER + V` | Alterna entre flotante y tileado |
| `SUPER + P` | Pseudotile — tilea la ventana sin cambiar su tamaño |
| `SUPER + J` | Rota la dirección del split (horizontal ↔ vertical) |
| `SUPER + M` | Sale de Hyprland (o abre menú de apagado si hyprshutdown está instalado) |

### Foco

| Atajo | Acción |
|---|---|
| `SUPER + H` | Mueve el foco a la ventana de la izquierda |
| `SUPER + L` | Mueve el foco a la ventana de la derecha |
| `SUPER + K` | Mueve el foco a la ventana de arriba |
| `SUPER + J` | Mueve el foco a la ventana de abajo |

### Workspaces

| Atajo | Acción |
|---|---|
| `SUPER + 1..9 / 0` | Va al workspace 1–10 |
| `SUPER + SHIFT + 1..9 / 0` | Mueve la ventana activa al workspace 1–10 |
| `SUPER + Tab` | Vista general de todos los workspaces (hyprexpo, grid 3×3) |
| `SUPER + Scroll arriba` | Va al workspace siguiente |
| `SUPER + Scroll abajo` | Va al workspace anterior |
| `3 dedos → izquierda` | Va al workspace siguiente |
| `3 dedos → derecha` | Va al workspace anterior |

### Scratchpad

| Atajo | Acción |
|---|---|
| `SUPER + S` | Muestra u oculta el scratchpad |
| `SUPER + SHIFT + S` | Envía la ventana activa al scratchpad |

### Capturas de pantalla

| Atajo | Acción |
|---|---|
| `Print` | Captura la ventana activa (hyprshot) |
| `SHIFT + Print` | Captura una región seleccionable (hyprshot) |

### Bloqueo

| Atajo | Acción |
|---|---|
| `SUPER + SHIFT + L` | Bloquea la pantalla con hyprlock |

### Volumen

| Atajo | Acción |
|---|---|
| `XF86AudioRaiseVolume` | Sube el volumen (OSD visual con swayosd) |
| `XF86AudioLowerVolume` | Baja el volumen (OSD visual con swayosd) |
| `XF86AudioMute` | Silencia/activa el audio |
| `XF86AudioMicMute` | Silencia/activa el micrófono |

### Brillo

| Atajo | Acción |
|---|---|
| `XF86MonBrightnessUp` | Sube el brillo de la pantalla (OSD visual con swayosd) |
| `XF86MonBrightnessDown` | Baja el brillo de la pantalla (OSD visual con swayosd) |

### Reproducción de media

| Atajo | Acción |
|---|---|
| `XF86AudioPlay / Pause` | Play / pausa (playerctl) |
| `XF86AudioNext` | Siguiente pista (playerctl) |
| `XF86AudioPrev` | Pista anterior (playerctl) |

### Mouse

| Acción | Resultado |
|---|---|
| `SUPER + clic izquierdo` | Arrastra y mueve ventana |
| `SUPER + clic derecho` | Redimensiona ventana |
| `SUPER + borde de ventana` | Redimensiona ventana (resize_on_border) |
