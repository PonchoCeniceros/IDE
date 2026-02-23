<h1 align="left">
  <img src="https://github.com/PonchoCeniceros/IDE/blob/ide/utils/imgs/main.svg" width="90" align="absmiddle">
  &nbsp;
  IDE
</h1>

Mi configuración personal de [LazyVim](https://github.com/LazyVim/LazyVim).

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
# tema principal - Tonos negro/gris profesionales
NVIM_THEME=carbonfox nvim

# tema secundario - colores con menos contraste
NVIM_THEME=catppuccin nvim

# tercera opción - útil para distinguir entre terminales abiertas
NVIM_THEME=onedark nvim
```

Usa el script `theme-selector.sh` para gestionar temas fácilmente:

```bash
# ver tema actual
./theme-selector.sh

# cambiar tema predeterminado
./theme-selector.sh carbonfox
./theme-selector.sh onedark
./theme-selector.sh catppuccin
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

| Keymap | Modo | Acción |
|------|------|-------|
| `<leader>aa` | Normal | Toggle OpenCode |
| `<leader>as` | Normal / Visual | Seleccionar código y enviar |
| `<leader>ai` | Normal / Visual | Pregunta libre |
| `<leader>aI` | Normal / Visual | Pregunta con contexto (`@this`) |
| `<leader>ab` | Normal / Visual | Preguntar sobre el archivo (`@file`) |
| `<leader>ap` | Normal / Visual | Prompt con contexto actual |
| `<leader>ape` | Normal / Visual | Explicar código |
| `<leader>apf` | Normal / Visual | Arreglar código |
| `<leader>apd` | Normal / Visual | Diagnosticar problemas |
| `<leader>apr` | Normal / Visual | Code review |
| `<leader>apt` | Normal / Visual | Generar tests |
| `<leader>apo` | Normal / Visual | Optimizar código |


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
