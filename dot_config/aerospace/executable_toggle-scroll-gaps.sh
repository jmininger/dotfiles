#!/usr/bin/env bash

# Toggle natural scrolling
current=$(defaults read NSGlobalDomain com.apple.swipescrolldirection)
if [ "$current" = "1" ]; then
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
else
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
fi

# Force macOS to apply the scroll direction change immediately
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Toggle aerospace outer.top gap (47 for sketchybar vs 10 without)
config="$HOME/.config/aerospace/aerospace.toml"
if grep -q '^[[:space:]]*outer\.top =.*47' "$config"; then
    sed -i '' 's/^\([[:space:]]*outer\.top =\).*/\1        10/' "$config"
else
    sed -i '' 's/^\([[:space:]]*outer\.top =\).*/\1        47 # 37 (bar height) + 10 (gap)/' "$config"
fi

aerospace reload-config
