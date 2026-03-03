#!/bin/bash
# Loop through all USB controllers and restart them
for i in /sys/bus/pci/drivers/xhci_hcd/*:*; do
    [ -e "$i" ] || continue
    echo "${i##*/}" > "${i%/*}/unbind"
    sleep 1
    echo "${i##*/}" > "${i%/*}/bind"
done
