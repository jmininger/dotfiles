#!/bin/sh

DISK=$(df -H / | awk 'NR==2 {print $5}' | tr -d '%')

sketchybar --set "$NAME" label="${DISK}%"
