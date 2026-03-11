<h1 align="left">
  <img src="https://github.com/PonchoCeniceros/IDE/blob/ide/utils/imgs/main.svg" width="90" align="absmiddle">
  &nbsp;
  IDE
</h1>

Mi configuración personal de [LazyVim](https://github.com/LazyVim/LazyVim).

<p align="center">
  <img src="https://github.com/PonchoCeniceros/IDE/blob/main/utils/imgs/ide.png">
</p>


## Instalación limpia
```bash
# clonar el repositorio
git clone https://github.com/tu-usuario/IDE.git ~/.config/nvim

# iniciar neovim
nvim
```
```bash
# Respaldar tu config
mv ~/.config/nvim ~/.config/nvim.backup

# Borrar plugins instalados
rm -rf ~/.local/share/nvim/lazy

# Borrar cache y estado
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

# Borrar datos de Mason
rm -rf ~/.local/share/nvim/mason

# Restaurar tu config limpia
mv ~/.config/nvim.backup ~/.config/nvim
```

## Temas Disponibles
Puedes seleccionar el tema al iniciar Neovim utilizando la variable de entorno `NVIM_THEME`:

```bash
# para quienes pasan horas frente a la pantalla y quieren
# un entorno acogedor y visualmente cohesivo.
NVIM_THEME=catppuccin nvim

# para usuarios que buscan un aspecto serio, profesional
# y de alto rendimiento.
NVIM_THEME=carbonfox nvim
```

Usa el script `theme-selector.sh` para gestionar temas fácilmente:

```bash
# ver tema actual
./theme-selector.sh

# cambiar tema predeterminado
./theme-selector.sh catppuccin
./theme-selector.sh carbonfox
```

## Integración con `wezterm`

```bash
ln -s ~/.config/nvim/utils/wezterm/.wezterm.lua ~/.wezterm.lua
```

## Cheatsheet

| Edición de Código | Búsqueda y Navegación | Buffers y Ventanas | Productividad | LSP y Debug |
|--------------------|------------------------|----------------------|-----------------|--------------|
| `i` Insertar después del cursor | `<leader>ff` Buscar archivos | `<leader>bb` Buffer anterior | `<leader>w` Guardar archivo | `<leader>xx` Warnings/errores LSP |
| `a` Insertar antes del cursor | `<leader>fg` Buscar texto (grep) | `Shift + →` Buffer siguiente | `<leader>q` Cerrar Neovim | `<leader>ls` Símbolos del buffer |
| `I` Insertar al final de línea | `<leader>fb` Buffers abiertos | `Shift + ←` Buffer anterior | `<leader>e` Explorador archivos | `<leader>lR` Rename proyecto |
| `A` Insertar al inicio de línea | `<leader>fh` Ayuda | `<leader>bd` Cerrar buffer | `<leader>gg` Git status | `<leader>la` Code actions |
| `gcc` Comentar línea | `<leader>fr` Archivos recientes | `<leader>bD` Cerrar otros buffers | `<leader>gl` Git log | `<leader>le` Diagnósticos |
| `gc` + mov. Comentar múltiple | `gd` Ir a definición | `Shift + ↓↓` Ventana superior | `<leader>ca` Code actions | `<leader>ld` Ir a definición |
| `yi"` Copiar entre comillas | `gr` Ir a referencias | `Shift + ↑↑` Ventana inferior | `<leader>rn` Renombrar variable | `<leader>lr` Mostrar referencias |
| `ci"` Cambiar entre comillas | `gi` Ir a implementación | `Shift + ←←` Ventana izquierda | | `<leader>li` Mostrar info |
| `di"` Eliminar entre comillas | `K` Documentación flotante | `Shift + →→` Ventana derecha | | `F5` Start / Continue debug |
| | `<leader>ft` Terminal flotante | `<S-Left>` Buffer anterior | | `F10` Step over |
| | | `<S-Right>` Buffer siguiente | | |
| | | `<C-w>s` Split horizontal | | |
| | | `<C-w>v` Split vertical | | |
| | | `<C-w>c` Cerrar ventana | | |


## OpenCode.nvim

Plugin de IA basado en [opencode.ai](https://opencode.ai) con prompts personalizados en español.

### keymaps de Ventana

| Keymap | Modo | Acción |
|--------|------|--------|
| `<leader>aa` | Normal | Alternar ventana de OpenCode |
| `<leader>av` | Normal | Abrir ventana en **bottom** (inferior) |
| `<leader>ah` | Normal | Abrir ventana en **right** (derecha) |

### keymaps de Trabajo con el Agente

| Keymap | Modo | Acción |
|--------|------|--------|
| `<leader>as` | Normal / Visual | Seleccionar código y enviar |
| `<leader>ai` | Normal / Visual | Pregunta libre |
| `<leader>aI` | Normal / Visual | Pregunta con contexto (`@this`) |
| `<leader>ab` | Normal / Visual | Preguntar sobre el archivo (`@file`) |
| `<leader>ap` | Normal / Visual | Prompt con contexto actual |

### keymaps de Funciones Especializadas

| Keymap | Modo | Acción | Descripción |
|--------|------|--------|-------------|
| `<leader>ape` | Normal / Visual | Explicar código | Explica qué hace el código de forma técnica |
| `<leader>apf` | Normal / Visual | Arreglar código | Corrige errores, tipado y malas prácticas |
| `<leader>apd` | Normal / Visual | Diagnosticar problemas | Identifica issues de producción (race conditions, memory leaks, etc.) |
| `<leader>apr` | Normal / Visual | Code review | Revisión profesional con calificación 1-10 |
| `<leader>apt` | Normal / Visual | Generar tests | Crea pruebas unitarias completas |
| `<leader>apo` | Normal / Visual | Optimizar código | Mejora rendimiento y legibilidad |

> **Nota:** Todos los prompts están configurados para responder en español.


## csvview.nvim

| Tipo | Atajo / Comando | Modo | Acción |
|-----|-----------------|------|-------|
| Text object | `if` | Operador / Visual | Seleccionar **contenido interno del campo** |
| Text object | `af` | Operador / Visual | Seleccionar **campo completo** |
| Navegación | `<Tab>` | Normal / Visual | Ir al **siguiente campo** (fin del campo) |
| Navegación | `<S-Tab>` | Normal / Visual | Ir al **campo anterior** (fin del campo) |
| Navegación | `<Enter>` | Normal / Visual | Ir a la **siguiente fila** |
| Navegación | `<S-Enter>` | Normal / Visual | Ir a la **fila anterior** |
| Comando | `:CsvViewEnable` | Comando | Habilitar vista CSV |
| Comando | `:CsvViewDisable` | Comando | Deshabilitar vista CSV |
| Comando | `:CsvViewToggle` | Comando | Alternar vista CSV |


## Comandos de uso y utilidades para `.zshrc`

```bash
# -------------------------------------------------------------------
# CONFIGURACIÓN DE NEOVIM (Temas Dinámicos)
# -------------------------------------------------------------------

# Acceso ultra rápido: Abre directamente con el tema Catppuccin
alias nvc='NVIM_THEME=catppuccin nvim'

# Acceso ultra rápido: Abre directamente con el tema Carbonfox (Nightfox)
alias nvx='NVIM_THEME=carbonfox nvim'

# variaciones para el cambio dinamico de tema en Opencode
# Alias para Catppuccin
nvc() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"catppuccin-macchiato\"/" ~/.config/opencode/config.json
  NVIM_THEME=catppuccin nvim "$@"
}

# Alias para Carbonfox
nvx() {
  sed -i "" "s/\"theme\": \".*\"/\"theme\": \"carbonfox\"/" ~/.config/opencode/config.json
  NVIM_THEME=carbonfox nvim "$@"
}

# Función 'nv': El comando maestro para Neovim.
# Uso:
#   'nv'          -> Abre Neovim normal.
#   'nv c [arch]' -> Abre con Catppuccin.
#   'nv x [arch]' -> Abre con Carbonfox.
nv() {
  if [[ "$1" == "c" ]]; then
    shift # Elimina la 'c' de la lista de argumentos para que no se abra como un archivo
    NVIM_THEME=catppuccin nvim "$@"
  elif [[ "$1" == "x" ]]; then
    shift # Elimina la 'x' de la lista de argumentos
    NVIM_THEME=carbonfox nvim "$@"
  else
    # Si no hay prefijo, lanza nvim con los argumentos originales
    nvim "$@"
  fi
}

# -------------------------------------------------------------------
# UTILIDADES DE TERMINAL
# -------------------------------------------------------------------

# 'ot' (Open Terminal): Abre una nueva instancia de iTerm2 en el directorio actual.
# Mantiene la coherencia del tema si la variable NVIM_THEME ya existe.
ot() {
  # Verifica si la variable de entorno NVIM_THEME está definida (no está vacía)
  if [ -n "$NVIM_THEME" ]; then
    # La exporta para que las sesiones dentro de la nueva terminal la hereden
    export NVIM_THEME=$NVIM_THEME
  fi
  # Abre la aplicación iTerm en la ruta actual (.)
  open -a iTerm .
  # open -a WezTerm .
}

#
# 'cls' (clean screen): Limpiar el buffer actual de la terminal
#
alias cls='clear'
```
