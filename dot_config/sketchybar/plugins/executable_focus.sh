#!/bin/sh

# Check Focus mode using JXA (requires Full Disk Access for Terminal/sketchybar)
FOCUS_STATUS=$(osascript -l JavaScript -e '
const app = Application.currentApplication()
app.includeStandardAdditions = true

function getJSON(path) {
  const fullPath = path.replace(/^~/, app.pathTo("home folder"))
  try {
    const contents = app.read(fullPath)
    return JSON.parse(contents)
  } catch(e) {
    return null
  }
}

const assertFile = getJSON("~/Library/DoNotDisturb/DB/Assertions.json")
if (assertFile && assertFile.data && assertFile.data[0]) {
  const assert = assertFile.data[0].storeAssertionRecords
  if (assert && assert.length > 0) {
    "on"
  } else {
    "off"
  }
} else {
  "off"
}
' 2>/dev/null)

if [ "$FOCUS_STATUS" = "on" ]; then
  sketchybar --set "$NAME" icon="󰍶" icon.color=0xffcba6f7
else
  sketchybar --set "$NAME" icon="󰍷" icon.color=0xff6c7086
fi
