
#!/bin/bash

# Replace with the actual ID of the notification you want to update

# New body text
NEW_BODY="123123"

# Check if both arguments are provided
if [ -z "$DUNST_ID" ] || [ -z "$NEW_BODY" ]; then
  echo "Usage: $0 <DUNST_ID> <NEW_BODY>"
  exit 1
fi

# Retrieve current notification with the given ID
notification=$(dunstctl history | grep "$DUNST_ID")

if [ -z "$notification" ]; then
  echo "Notification with ID $DUNST_ID not found."
  exit 1
fi

# Extract other components of the notification
# Note: This is an example and may need adjustments based on your dunst version and notification format.
title=$(echo "$notification" | grep -oP '(?<=title: ).*?(?=, body:)' | sed 's/,$//')
icon=$(echo "$notification" | grep -oP '(?<=icon: ).*?(?=, body:)' | sed 's/,$//')

# Update the notification with the new body
#dunstctl close "$DUNST_ID"
dunstify "aboba" "bpba" -r "$DUNST_ID"

