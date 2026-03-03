ASUS ROG USB Crash Watchdog (Linux)
The Problem
On certain ASUS ROG laptops (specifically tested on the ROG Strix G513QY / All-AMD Advantage Edition), heavy CPU loads in games like Europa Universalis 5 or Deadlock cause massive transient power spikes. These spikes cause a momentary voltage drop across the motherboard.

Because the internal keyboard, Bluetooth, and Left-Side USB ports all share the same fragile internal USB Root Hub, this voltage drop causes the hub to "brown-out" and crash. The keyboard backlight turns off, the keys become unresponsive, and the Linux kernel throws a usb 1-2: timeout error.

Normally, this requires a hard reboot (holding the power button) because you cannot type your password to reset the drivers.

The Solution
This project provides a fully automatic, background systemd Watchdog service. It silently monitors the live kernel logs (dmesg / journalctl) for the exact URB timeout error. The millisecond the USB hub crashes, the Watchdog automatically unbinds and rebinds the xhci_hcd drivers, cycling power to the hub and reviving the keyboard in less than 2 seconds—without requiring a reboot or a password.
