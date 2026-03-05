#!/bin/bash
# Follow the kernel log live and look for either crash phrase
journalctl -k -f | grep --line-buffered -E "usb 1-2: timeout|couldn't find an input interrupt endpoint" | while read line ; do
    # Fire the rescue script to cycle the power
    /usr/local/bin/rescue_keyboard.sh
    # Sleep for 10 seconds so it doesn't trigger multiple times in a row
    sleep 10
done
