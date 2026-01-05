#!/bin/sh

MEMORY=$(top -l 1 -n 0 | grep PhysMem | awk '{
  used = $2
  unused = $8
  gsub(/G/, "", used); gsub(/M/, "", used)
  gsub(/G/, "", unused); gsub(/M/, "", unused)
  if ($2 ~ /M/) used = used / 1024
  if ($8 ~ /M/) unused = unused / 1024
  total = used + unused
  printf "%d", (used / total) * 100
}')

sketchybar --set "$NAME" label="${MEMORY}%"
