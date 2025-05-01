# Start Kodi and wait for it to exit
Start-Process -FilePath "C:\Program Files\Kodi\kodi.exe" -Wait

# After Kodi exits, start CEC-Tray
Start-Process -FilePath "C:\Program Files\Pulse-Eight\USB-CEC Adapter\netfx\cec-tray.exe"
