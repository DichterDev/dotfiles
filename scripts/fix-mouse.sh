#!/usr/bin/env bash

# Resets the Intel I2C HID touchpad driver to fix a disappearing cursor

if ! sudo -v; then
    echo "Error: This function requires administrative privileges." >&2
    exit 1
fi

echo "Reloading touchpad kernel modules..."

sudo rmmod i2c_hid_acpi i2c_hid 2>/dev/null

sleep 0.5

sudo modprobe i2c_hid_acpi i2c_hid 2>/dev/null

echo "Touchpad successfully reset!"
