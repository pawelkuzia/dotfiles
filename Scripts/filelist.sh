#!/bin/bash

# Ścieżka do folderu, którego zawartość chcesz przeczytać
wpdir="/home/pawelkuzia/.wallpapers"

# Tworzenie pustej macierzy
declare -a wps

# Przeglądanie plików w folderze i dodawanie ich ścieżek do macierzy
while IFS= read -r -d $'\0' file; do
    wps+=("$file")
done < <(find "$wpdir" -type f -print0)

# Wyświetlenie zawartości macierzy
echo "Ścieżki plików w folderze $wpdir:"
for path in "${wps[@]}"; do
    echo "$path"
done
