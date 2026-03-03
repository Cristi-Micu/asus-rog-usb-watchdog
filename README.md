# ASUS ROG USB Crash Watchdog (Linux)
A lightweight, automated systemd watchdog service to prevent permanent keyboard and USB dropouts on ASUS ROG laptops during heavy gaming sessions.

## The Problem
On certain ASUS ROG laptops (specifically tested on the ROG Strix G513QY / All-AMD Advantage Edition), heavy CPU loads in games like Europa Universalis 5 or Deadlock cause massive transient power spikes. These spikes result in a momentary voltage drop across the motherboard.

Because the internal keyboard, Bluetooth, and Left-Side USB ports all share the same fragile internal USB Root Hub, this voltage drop causes the hub to "brown-out" and crash. When this happens:

 - The keyboard become completely unresponsive.
 - The left-side USB ports die.
 - The Linux kernel throws the following error: usb 1-2: timeout

Normally, this creates a Catch-22 that requires a hard reboot (holding the physical power button) because you cannot type your sudo password to reset the USB drivers.

## The Solution
This project provides a fully automatic, background systemd Watchdog service.

It silently monitors the live kernel logs (dmesg / journalctl) for the exact URB timeout error. The exact millisecond the USB hub crashes, the Watchdog automatically:

 - Unbinds the xhci_hcd drivers. 
 - Cycles the power to the internal hub.
 - Rebinds the drivers.

## Result
Your keyboard and USB ports are fully revived in less than 2 seconds—without requiring a reboot, a password, or even an Alt+Tab.

## Installation

**1. Clone the repository:**

    gh repo clone Cristi-Micu/asus-rog-usb-watchdog
    cd asus-rog-usb-watchdog

**2. Copy the scripts to the standard local binary folder and make them executable:**

    sudo cp usb_watchdog.sh rescue_keyboard.sh /usr/local/bin/
    sudo chmod +x /usr/local/bin/usb_watchdog.sh
    sudo chmod +x /usr/local/bin/rescue_keyboard.sh

**3. Move the systemd service to the correct folder:**

    sudo cp usb-rescue.service /etc/systemd/system/

**4. Enable and start the Watchdog service:**

    sudo systemctl enable usb-rescue.service
    sudo systemctl start usb-rescue.service
