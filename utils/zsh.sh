#
# Acesso rapido a neovim con un estilo
# predeterminado: principal
#
openNvim() {
  NVIM_THEME=carbonfox nvim
}

#
# Acesso rapido a neovim con un estilo
# predeterminado: secundario
#
1OpenNvim() {
  NVIM_THEME=catppuccin nvim
}

#
# Acesso rapido a neovim con un estilo
# predeterminado: terciario
#
2OpenNvim() {
  NVIM_THEME=onedark nvim
}

#
# Utilidad para acceder a una terminal extra
#
sameTerm() {
  open -a iterm .
}

#
# Utilidad para acceder a Harlequin con
# la config de SAP HANA
#
hqHana() {
  local env_file="$HOME/.hana_envs"

  if [[ ! -f "$env_file" ]]; then
    echo "Error: No existe el archivo $env_file"
    return 1
  fi

  local choice=$(cat "$env_file" | fzf \
    --delimiter='\|' \
    --with-nth=1 \
    --nth=1 \
    --prompt="Seleccionar Entorno HANA > " \
    --height=15% \
    --layout=reverse \
    --border=rounded \
    --info=hidden \
    --header="Selecciona entorno")

  [[ -z "$choice" ]] && return

  local name=$(echo "$choice" | awk -F'|' '{print $1}')
  local host=$(echo "$choice" | awk -F'|' '{print $2}')
  local user=$(echo "$choice" | awk -F'|' '{print $3}')
  local pass=$(echo "$choice" | awk -F'|' '{print $4}')

  clear

  harlequin -a odbc \
    --theme flexoki \
    "DRIVER={HDBODBC};SERVERNODE=$host;UID=$user;PWD=$pass"
}
