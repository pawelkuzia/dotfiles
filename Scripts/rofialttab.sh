#!/usr/bin/env bash
rofi -show window -theme-str "window {width: 30%;} listview {lines: 15; dynamic: true;}" -kb-accept-entry "!Alt-Tab,!Alt+Alt_L" -kb-row-down "Alt+Tab" -selected-row 1 -steal-focus
