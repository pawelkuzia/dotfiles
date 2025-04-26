#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Pobiera aktualny czas w formacie YYYY-MM-DD_HH-MM-SS
timestamp() {
  date +"%Y-%m-%d_%H-%M-%S"
}

# Wysyła powiadomienie z opcjami otwarcia folderu, edycji i usunięcia
send_notification() {
  local file="$1"
  local mode="$2"

  if [[ -f "$file" ]]; then
    local ACTION=$(notify-send "Zrzut ekranu ($mode) zapisany!" \
      "Plik: $(basename "$file")" \
      -A "open=📂 Otwórz folder" \
      -A "edit=✏️ Edytuj" \
      -A "delete=🗑️ Usuń" \
      -i "$file" \
      -u normal)

    case "$ACTION" in
    open) xdg-open "$SCREENSHOT_DIR" & ;;
    edit) swappy -f "$file" & ;;
    delete)
      rm "$file"
      notify-send "🗑️ Screenshot usunięty" "Plik $(basename "$file") został usunięty."
      ;;
    esac
  fi
}

# Wybór monitora za pomocą slurp w trybie output
select_monitor() {
  slurp -o # Uruchamiamy slurp w trybie wyboru monitora
}

# Zrzut ekranu wybranego obszaru
screenshot_area() {
  local file="$SCREENSHOT_DIR/screenshot_$(timestamp)_area.png"
  grimblast --freeze copysave area "$file"
  send_notification "$file" "Obszar"
}

# Zrzut całego ekranu
screenshot_fullscreen() {
  local file="$SCREENSHOT_DIR/screenshot_$(timestamp)_fullscreen.png"
  grimblast --freeze copysave screen "$file"
  send_notification "$file" "Pełny ekran"
}

# Zrzut wybranego monitora
screenshot_monitor() {
  # Uruchamiamy slurp, użytkownik wybiera monitor
  select_monitor
  local file="$SCREENSHOT_DIR/screenshot_$(timestamp)_monitor.png"
  grimblast --freeze copysave output "$file"
  send_notification "$file" "Monitor"
}

# Zrzut wszystkich ekranów bez zapisu
screenshot_fullscreen_clipboard() {
  grimblast --freeze copy screen
  notify-send "Zrzut ekranu" "Pełny ekran skopiowany do schowka."
}

# Obsługa argumentów
while [[ "$#" -gt 0 ]]; do
  case "$1" in
  area)
    screenshot_area
    exit 0
    ;;
  fullscreen)
    screenshot_fullscreen
    exit 0
    ;;
  monitor)
    screenshot_monitor
    exit 0
    ;;
  fullscreen_clipboard)
    screenshot_fullscreen_clipboard
    exit 0
    ;;
  *)
    echo "Użycie: $0 {area|fullscreen|monitor|fullscreen_clipboard}"
    exit 1
    ;;
  esac
done

echo "Brak argumentów. Użycie: $0 {area|fullscreen|monitor|fullscreen_clipboard}"
exit 1
