#!/bin/bash

# Colors (Catppuccin Mocha)
RED=0xfff38ba8      # mentions / DMs
BLUE=0xff89b4fa     # channel messages
DIM=0xff6c7086      # no notifications

# Get badge count from Slack
COUNT=$(lsappinfo info -only StatusLabel "Slack" 2>/dev/null | sed -nr 's/\"StatusLabel\"=\{ \"label\"=\"(.+)\" \}$/\1/p')

if [[ -z "$COUNT" || "$COUNT" == "0" ]]; then
  sketchybar --set "$NAME" icon=":slack:" icon.color=$DIM label="" drawing=on
  exit 0
fi

# Check notification database for Slack notification types
# Requires Full Disk Access for terminal app
NOTIF_DB="$HOME/Library/Group Containers/group.com.apple.usernoted/db2/db"

HAS_MENTION_OR_DM=false

if [[ -r "$NOTIF_DB" ]]; then
  # Query recent Slack notifications (last 24 hours)
  # Look for patterns indicating mentions or DMs
  RECENT_NOTIFS=$(sqlite3 "$NOTIF_DB" "
    SELECT hex(data) FROM record
    WHERE app = 'com.tinyspeck.slackmacgap'
    AND delivered_date > (strftime('%s', 'now') - 86400 - 978307200)
    ORDER BY delivered_date DESC
    LIMIT 20
  " 2>/dev/null)

  if [[ -n "$RECENT_NOTIFS" ]]; then
    # Convert hex to text and check for mention/DM patterns
    # Check ALL notifications - red (mention/DM) takes priority over blue (channel)
    for hex_data in $RECENT_NOTIFS; do
      # Decode hex and look for patterns
      decoded=$(echo "$hex_data" | xxd -r -p 2>/dev/null | strings 2>/dev/null)

      # Check for DM patterns (direct message indicators)
      if echo "$decoded" | grep -qiE "(direct message|sent you a message|messaged you|slackbot)"; then
        HAS_MENTION_OR_DM=true
      fi

      # Check for mention patterns (@ mentions)
      if echo "$decoded" | grep -qE "@[a-zA-Z]|mentioned you|replied to|thread"; then
        HAS_MENTION_OR_DM=true
      fi
    done
  fi
fi

# Set color based on notification type
if [[ "$HAS_MENTION_OR_DM" == "true" ]]; then
  COLOR=$RED
else
  COLOR=$BLUE
fi

sketchybar --set "$NAME" icon=":slack:" icon.color=$COLOR label="$COUNT" drawing=on
