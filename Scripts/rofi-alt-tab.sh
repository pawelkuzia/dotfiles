#!/bin/bash
rofi -show window -theme-str 'window {width: 50%;} listview {lines: 15;}' -kb-accept-entry "!Alt-Tab,!Alt+Alt_L" -kb-row-down "Alt+Tab" -selected-row 1 -steal-focus'
