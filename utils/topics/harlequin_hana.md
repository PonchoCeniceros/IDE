# Setup de Harlequin + SAP HANA en macOS (Apple Silicon)

Esta configuración permite gestionar bases de datos SAP HANA desde la terminal con una interfaz tipo IDE (TUI), integrada visualmente con la estética de LazyVim / Carbonfox.

## 1. Instalación del Motor de Paquetes (uv)

En lugar de usar pip global, utilizamos uv (escrito en Rust) por su velocidad y para evitar conflictos con el entorno de Python de macOS.

```bash
brew install uv
```

## 2. Instalación del SAP HANA Client (Nativo)

Harlequin (vía ODBC) requiere los drivers nativos de SAP, no los de Java que usa DBeaver.

1. Descargar `hanaclient-latest-macos-arm64.dmg` desde [SAP Development Center](https://developers.sap.com/)
2. Instalar el paquete. La ruta por defecto será: `/Applications/sap/hdbclient`
3. Verificar que el archivo del driver existe:

```bash
ls /Applications/sap/hdbclient/libodbcHDB.dylib
```

## 3. Configuración del Gestor ODBC del Sistema

Instalamos unixODBC para que actúe como puente entre Harlequin y el driver de SAP.

```bash
# Instalar el gestor
brew install unixodbc
```

Registrar el driver de SAP en unixODBC:

```ini
# /opt/homebrew/etc/odbcinst.ini

[HDBODBC]
Description = SAP HANA Driver
Driver = /Applications/sap/hdbclient/libodbcHDB.dylib
```

## 4. Instalación Limpia de Harlequin

Instalamos Harlequin de forma aislada, incluyendo el adaptador necesario para ODBC.

```bash
# Borrar cualquier binario previo "huérfano" si existía
rm $(which harlequin) 

# Instalación limpia con soporte ODBC
uv tool install 'harlequin[odbc]' --force
```

## 5. Verificación de la Instalación

Para verificar que todo está correctamente configurado, ejecuta:

```bash
harlequin --help
```

Deberías ver información sobre el adaptador ODBC en la salida.

## 6. Comandos de uso y utilidades

### Creación del archivo de credenciales `.hana_envs`

```bash
label_1|host:port|user|pswd
label_2|host:port|user|pswd
```

### función para `.zshrc`
```bash
# -------------------------------------------------------------------
# ACCESO A BASES DE DATOS (HANA + Harlequin)
# -------------------------------------------------------------------

# hda: Hana Database Access
# Usa fzf para seleccionar credenciales y abre el cliente SQL Harlequin
hda() {
  # Ruta del archivo que contiene las credenciales (formato: Nombre|Host|User|Pass)
  local env_file="$HOME/.hana_envs"

  # Validación: Si el archivo no existe, detiene la función
  if [[ ! -f "$env_file" ]]; then
    echo "Error: No existe el archivo de entornos en $env_file"
    return 1
  fi

  # Interfaz interactiva con fzf:
  # --with-nth=1: Solo muestra el nombre del entorno en la lista
  # --height=15%: No ocupa toda la pantalla, solo una pequeña franja
  local choice=$(cat "$env_file" | fzf \
    --delimiter='\|' \
    --with-nth=1 \
    --nth=1 \
    --prompt="󱏒 Seleccionar Entorno HANA > " \
    --height=15% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Selecciona la instancia de base de datos")

  # Si presionas ESC o no seleccionas nada, sale de la función sin errores
  [[ -z "$choice" ]] && return

  # Parsing: Extrae cada valor usando el delimitador pipe (|)
  local name=$(echo "$choice" | awk -F'|' '{print $1}')
  local host=$(echo "$choice" | awk -F'|' '{print $2}')
  local user=$(echo "$choice" | awk -F'|' '{print $3}')
  local pass=$(echo "$choice" | awk -F'|' '{print $4}')

  # Limpia la terminal antes de entrar a la interfaz de Harlequin
  clear

  # Ejecuta Harlequin con el driver ODBC de HANA y el tema Flexoki
  # Nota: Se inyectan las variables host, user y pass en la cadena de conexión
  harlequin -a odbc \
    --theme catppuccin-mocha \
    "DRIVER={HDBODBC};SERVERNODE=$host;UID=$user;PWD=$pass"
}
```
