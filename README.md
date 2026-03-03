# asus-rog-usb-watchdog
This is a quick and dirty solution for a weird problem I had with my ROG laptop. Because the internal keyboard, Bluetooth, and Left-Side USB ports all share the same fragile internal USB Root Hub, this voltage drop causes the hub to "brown-out" and crash. The keyboard become unresponsive, and the Linux kernel throws a usb 1-2: timeout error.
