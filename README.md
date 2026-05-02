# dotfiles — Hyprland

Rice personal sobre Arch Linux + Hyprland.

---

## Sistema

**Hyprland** como compositor Wayland con layout dwindle, animaciones fluidas, blur y bordes redondeados. Los colores de toda la sesión (barra, bordes, notificaciones, terminal...) se generan automáticamente con **matugen** siguiendo el sistema Material You — al cambiar el wallpaper, la paleta entera del sistema cambia con él.

**Waybar** como barra superior con workspaces numerados, reloj, controles de audio y notificaciones. **Swaync** gestiona las notificaciones con un panel lateral. **Rofi** como lanzador de aplicaciones.

El bloqueo de pantalla lo maneja **Hyprlock** con **Hypridle** para activarlo tras inactividad. El OSD de volumen y brillo usa **Swayosd**, que muestra un indicador visual al pulsar las teclas de función. Los wallpapers los gestiona **Awww**.

El workspace 1 es un dashboard estético que arranca automáticamente con Spotify, un reloj (`tty-clock`), un bonsái animado (`cbonsai`) y pipes animados, todo distribuido en pantalla completa.

---

## Chuleta

### Apps

| Atajo | Acción |
|---|---|
| `SUPER + Enter` | Terminal |
| `SUPER + Space` | Lanzador (Rofi) |
| `SUPER + E` | Gestor de archivos |
| `SUPER + W` | Cambiar wallpaper |
| `SUPER + I` | IntelliJ IDEA |

### Ventanas

| Atajo | Acción |
|---|---|
| `SUPER + C` | Cerrar ventana |
| `SUPER + V` | Flotar / desflotar |
| `SUPER + P` | Pseudotile |
| `SUPER + J` | Rotar split |
| `SUPER + H / L / K / J` | Mover foco |

### Workspaces

| Atajo | Acción |
|---|---|
| `SUPER + 1..0` | Ir al workspace |
| `SUPER + SHIFT + 1..0` | Mover ventana al workspace |
| `SUPER + Tab` | Vista general (hyprexpo) |
| `SUPER + Scroll` | Workspace anterior / siguiente |
| `3 dedos izq / der` | Workspace anterior / siguiente |

### Scratchpad

| Atajo | Acción |
|---|---|
| `SUPER + S` | Mostrar / ocultar scratchpad |
| `SUPER + SHIFT + S` | Enviar ventana al scratchpad |

### Sistema

| Atajo | Acción |
|---|---|
| `SUPER + SHIFT + L` | Bloquear pantalla |
| `SUPER + M` | Salir de Hyprland |
| `Print` | Captura de ventana |
| `SHIFT + Print` | Captura de región |
| Teclas `XF86` | Volumen / brillo / media |
