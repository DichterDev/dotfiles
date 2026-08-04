#!/usr/bin/env bash

# Resets the Intel I2C HID touchpad driver to fix a disappearing cursor

echo "Reloading touchpad kernel modules..."

rmmod i2c_hid_acpi i2c_hid 2>/dev/null

sleep 0.5

modprobe i2c_hid_acpi i2c_hid 2>/dev/null

echo "Touchpad successfully reset!"
