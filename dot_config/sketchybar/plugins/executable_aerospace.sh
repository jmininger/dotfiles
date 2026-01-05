#!/bin/bash

# Catppuccin Mocha colors
MAUVE=0xffcba6f7
SURFACE1=0xff45475a
TEXT=0xffcdd6f4
SUBTEXT=0xffa6adc8

# Get focused workspace from aerospace
FOCUSED=$(aerospace list-workspaces --focused)

# Extract workspace number from item name (space.1 -> 1)
WORKSPACE=${NAME#space.}

# Check if workspace has windows
WINDOWS=$(aerospace list-windows --workspace "$WORKSPACE" 2>/dev/null | wc -l | tr -d ' ')

if [ "$FOCUSED" = "$WORKSPACE" ]; then
  # Active workspace - mauve background with dark text
  sketchybar --set $NAME background.drawing=on \
                         icon.color=0xff1e1e2e \
                         background.color=$MAUVE
elif [ "$WINDOWS" -gt 0 ]; then
  # Has windows - subtle highlight
  sketchybar --set $NAME background.drawing=on \
                         icon.color=$TEXT \
                         background.color=$SURFACE1
else
  # Empty workspace - dim text, no inner background
  sketchybar --set $NAME background.drawing=off \
                         icon.color=$SUBTEXT
fi
