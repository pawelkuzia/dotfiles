#!/bin/bash

hyprctl --batch "\
  keyword animations:enabled 0;\
  keyword decoration:drop_shadow 0;\
  keyword decoration:blur:enabled 0;\
  keyword decoration:inactive_opacity 1;\
  keyword decoration:rounding 0"
