#!/bin/bash

# Get signal strength from system_profiler
SIGNAL=$(system_profiler SPAirPortDataType 2>/dev/null | grep "Signal / Noise" | head -1 | sed 's/.*: //' | awk '{print $1}' | sed 's/-//' | sed 's/ *dBm//')

if [ -n "$SIGNAL" ] && [ "$SIGNAL" -gt 0 ] 2>/dev/null; then
  # Convert dBm to percentage (typically -30 = 100%, -90 = 0%)
  if [ "$SIGNAL" -le 30 ]; then
    STRENGTH=100
  elif [ "$SIGNAL" -ge 90 ]; then
    STRENGTH=0
  else
    STRENGTH=$(( (90 - SIGNAL) * 100 / 60 ))
  fi

  sketchybar --set "$NAME" icon="󰖩" label="${STRENGTH}%"
else
  sketchybar --set "$NAME" icon="󰖪" label="Off"
fi
