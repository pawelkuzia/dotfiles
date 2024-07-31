#!/usr/bin/env bash

# Pobieranie listy plików z folderu ~/Scripts/toolbox
scripts_folder=~/.scripts

# Ustawienie separatora pól (IFS) na nową linię
IFS=$'\n'

# Pobieranie listy plików w jednym pliku na linię
scripts_list=$(ls -1 "$scripts_folder")

# Iteracja przez listę plików
for script_file in $scripts_list; do
  # Sprawdzenie czy plik jest wykonywalny
  if [ -x "$scripts_folder/$script_file" ]; then
    # Wyciągnięcie nazwy skryptu bez ścieżki
    script_name=$(basename "$script_file")
    # Wyświetlenie nazwy skryptu
    echo "$script_name"
  fi
done

# Funkcja wykonująca odpowiedni skrypt na podstawie nazwy pliku
run_script() {
  script_path="$scripts_folder/$1"
  # Sprawdzenie czy plik istnieje i jest wykonywalny
  if [ -x "$script_path" ]; then
    # Uruchomienie skryptu
    nohup "$script_path" &
    sleep 0.1
  else
    # Wyświetlenie komunikatu o błędzie gdy plik nie istnieje lub nie jest wykonywalny
    echo "Błąd: Nieznany skrypt lub brak uprawnień do wykonania"
  fi
}

# Sprawdzenie czy podano argument do skryptu
if [ $# -eq 1 ]; then
  run_script "$1"
fi
