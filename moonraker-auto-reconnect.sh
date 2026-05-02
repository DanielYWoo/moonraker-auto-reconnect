#!/bin/bash

# Configuration
MCU_PATH="/dev/serial/by-id/usb-Klipper_stm32f103xe_xxxxxxxxxxxxxxxxxx"
MOONRAKER_URL="http://127.0.0.1:7125"

# 1. Dependency Check
if ! command -v jq &> /dev/null; then
    echo "ERROR: 'jq' is not installed. Please run: sudo apt install jq" >&2
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "ERROR: 'curl' is not installed." >&2
    exit 1
fi

# 2. Query State
RESPONSE=$(curl -s "$MOONRAKER_URL/printer/objects/query?webhooks")
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to connect to Moonraker at $MOONRAKER_URL" >&2
    exit 1
fi

STATE=$(echo "$RESPONSE" | jq -r '.result.status.webhooks.state' 2>/dev/null)

# 3. Action Logic
if [[ "$STATE" == "error" || "$STATE" == "shutdown" ]]; then
    if [ -e "$MCU_PATH" ]; then
        echo "Klipper is $STATE, MCU detected. Triggering restart."
        curl -s -X POST "$MOONRAKER_URL/printer/firmware_restart"
    else
        echo "Klipper is $STATE, but MCU path not found."
    fi
fi
