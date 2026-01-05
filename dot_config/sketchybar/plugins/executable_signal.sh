#!/bin/bash

COUNT=$(lsappinfo info -only StatusLabel "Signal" 2>/dev/null | sed -nr 's/\"StatusLabel\"=\{ \"label\"=\"(.+)\" \}$/\1/p')

if [[ -n "$COUNT" && "$COUNT" != "0" ]]; then
  sketchybar --set "$NAME" icon=":signal:" icon.color=0xff3a76f0 label="$COUNT" drawing=on
else
  sketchybar --set "$NAME" icon=":signal:" icon.color=0xff6c7086 label="" drawing=on
fi
