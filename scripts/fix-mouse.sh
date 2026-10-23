#!/usr/bin/env bash

sudo rmmod i2c_hid_acpi i2c_hid 2>/dev/null

echo "Reloaded ic2"

sleep 0.5

sudo modprobe i2c_hid_acpi i2c_hid 2>/dev/null

echo "Successful"

exit 0
