function fix-mouse --description 'Resets the Intel I2C HID touchpad driver to fix a disappearing cursor'
    if not sudo -v
        echo "Error: This function requires administrative privileges."
        return 1
    end

    echo "Reloading touchpad kernel modules..."

    sudo rmmod i2c_hid_acpi i2c_hid 2>/dev/null

    sleep 0.5

    sudo modprobe i2c_hid_acpi i2c_hid 2>/dev/null

    echo "Touchpad successfully reset!"
end
