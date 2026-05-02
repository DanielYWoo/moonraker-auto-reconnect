# moonraker-auto-reconnect
This is a super simple script for you to forget RESTART and RESTART_FIRMWARE forever in klipper

# Install
Login as `pi` (not root)
Find the MCU device id by `ls /dev/serial/by-id/usb-Klipper_*` and `chmod +x` with the user `pi`
Copy it and replace MCU_PATH in this script, e.g, 
`MCU_PATH="/dev/serial/by-id/usb-Klipper_stm32f103xe_xxxxxxxxxxxxxx-xxxx"`

Put the shell script to `~/moonraker-auto-reconnect.sh` then enable it with the root user (sudo)
```bash
pi@voron-bedslinger:~ $ sudo vim /etc/systemd/system/moonraker_auto_reconnect.service
pi@voron-bedslinger:~ $ sudo systemctl daemon-reload
pi@voron-bedslinger:~ $ sudo systemctl enable moonraker_auto_reconnect
Created symlink /etc/systemd/system/multi-user.target.wants/moonraker_auto_reconnect.service → /etc/systemd/system/moonraker_auto_reconnect.service.
pi@voron-bedslinger:~ $ sudo systemctl start moonraker_auto_reconnect
```

Now, if you shut down the printer, mainsail UI will auto reconnect it in 10 seconds.
