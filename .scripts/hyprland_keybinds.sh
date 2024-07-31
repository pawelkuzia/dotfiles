#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/config/binds.conf"

# Sprawdzenie istnienia pliku konfiguracyjnego
if [[ ! -f "$HYPR_CONF" ]]; then
  echo "Plik konfiguracyjny $HYPR_CONF nie istnieje!"
  exit 1
fi

# Ekstrakcja bindów z pliku konfiguracyjnego
mapfile -t BINDINGS < <(grep -E '^(bind|binde|bindl|bindr)' "$HYPR_CONF" |
  grep -v '^binds' |
  grep ' # ' |
  sed -e 's/  */ /g' -e 's/\(bind\|binde\|bindl\|bindr\)[ \t]*=[ \t]*//g' -e 's/, /,/g' -e 's/ # /,/' |
  awk -F, -v q="'" '
    {
      cmd="";
      for(i=3;i<NF;i++) cmd=cmd $(i) " ";
      if ($1 == "" || $2 == "") {
        # Jeśli brak pierwszego modyfikatora, wyświetl tylko klawisz
        printf "<b>%s</b>   %s   <i><span color=%sgray%s>(%s)</span></i>\n", $2, $NF, q, q, cmd
      } else {
        # Jeśli obecny modyfikator, wyświetl modyfikator + klawisz
        printf "<b>%s + %s</b>   %s   <i><span color=%sgray%s>%s</span></i>\n", $1, $2, $NF, q, q, cmd
      }
    }')

# Debugowanie: Wyświetl BINDINGS
echo "Znalezione bindy:"
printf '%s\n' "${BINDINGS[@]}"

# Wybór z rofi
CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | rofi -theme-str 'configuration { font: "UbuntuSansMono Nerd Font 11"; } listview { columns: 1; lines: 20; } element { children: [element-text]; } window { width: calc( 90% min 1280px ); }' -dmenu -i -markup-rows -p "Hyprland Keybinds:")

# Debugowanie: Wyświetl wybraną opcję
echo "Wybrana opcja:"
echo "$CHOICE"

# Ekstrakcja CMD z HTML
CMD=$(echo "$CHOICE" | sed -n "s/.*<span color='gray'>\(.*\)<\/span>.*/\1/p")

# Debugowanie: Wyświetl CMD
echo "Polecenie:"
echo "$CMD"

# Wykonanie polecenia
if [[ $CMD == exec* ]]; then
  echo "Wykonanie polecenia: $CMD"
  eval "$CMD"
else
  echo "Wykonanie polecenia hyprctl dispatch: $CMD"
  hyprctl dispatch "$CMD"
fi
