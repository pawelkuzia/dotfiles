#!/bin/bash

# Utworzenie katalogu "backup", jeśli nie istnieje
mkdir -p ~/backup/wallpapers

# Przejście do folderu z nowymi tapetami
cd ~/Downloads/wallpapers || exit

# Przechodzenie przez wszystkie pliki w folderze
for file in *; do
    # Sprawdzenie czy plik jest plikiem regularnym
    if [ -f "$file" ]; then
        # Przekonwertowanie pliku do formatu PNG o wysokości 2160px z zachowaniem proporcji
        convert "$file" -resize x2160 -filter Lanczos -quality 90 "$HOME/.wallpapers/${file%.*}.png"
    fi
done

# Przeniesienie wszystkich plików do katalogu backupowego
mv * ~/backup/wallpapers/
