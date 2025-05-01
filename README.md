# HTPC-setup
Experience and tweaks for HTPC

I've bought GB-BTIP-N250 in order to build a HTPC which would replace Raspberry Pi 4 (With Libreelec and Docker) that started ocassionally freezing (after 4+ yeas of running 24/7).
The initial idea was to run Linux Mint on it, but after 2 weeks of trying to get everything to work, I was forced to give up on it as drivers for Intel n250 are jsut not there yet, maybe in 6 months or a year everything would work well.
I've switched to Windows 11 PRO, and even though it uses a bit more resources than Linux Mint, everything completely works.
I've then set up quite a few things (the main reason I'm creating this repo and this readme):
- I set up autologin with local account, in case the HTPC reboots, it will compeltely boot up and start all of the programs it should start.
- Flex launcher (https://github.com/complexlogic/flex-launcher) - this is an excellent HTPC launcher with good instructions on how to configure it.
- I've noticed that sometimes some program will steal focus from Flex launcher which will prevent me from actually using it, so I've written a script that runs in the background (with lower priority) and checks every 30 seconds if Flex launcher is running, and if it is does it have focus. I've also configured it so that some apps that get launched from the Flex launcher are permitted to take focus and the script won't interfere. The script is Flex.ps1, but I converted it to an exe - it runs in the background, I just have it start during startup and that's it. If you download Flex.ps1 edit it according to your needs and then either have it run as is or convert it to an exe - insutrctions on how to do this are in a file Convert to exe.txt
- I've bought PulseEight usb cec adapter, installed the latest LibCEC (https://github.com/Pulse-Eight/libcec/releases/tag/libcec-7.0.0) and updated the usb adapter drivers after installation.
- If you launch Kodi after this and it craches, just reinstall it and everything will be ok - you won't lose any data.
- After launching Kodi, I saw that CEC-tray is gone from the taskbar, after debugging and getting in touch with PulseEight support, I learned that this is expected, as Kodi uses libcec library and only one device can use the usb adapter - so CEC-tray exists in order to give way to Kodi.
- I've then written a script which I use to start Kodi, and which will start CEC-tray when Kodi exits - the script is StartKodi.ps1. In general there's no need to change anything, but check file paths as they might be different for you.
- I've installed KDE connect, so now I can easily send web pages to my HTPC and have them open in a default browser (Firefox with ublock).
- I've also installed an addon for Firefox which allows me to use youtube.com/tv (https://addons.mozilla.org/en-US/firefox/addon/youtube-for-tv/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search) and then I've installed Violentmonkey (https://addons.mozilla.org/en-US/firefox/addon/violentmonkey/) and added 2 scripts to it (autologin and redirect) - now when I send any youtube video to my HTPC it will open it in youtube.com/tv.
- At some point I noticed that the transfer speed to my Synology nas is very slow (16MB/s), after reasearch I found out it's just Microsoft with their weird decisions which tend to break things (https://winaero.com/windows-11-24h2-significantly-slows-down-smb-data-transfer-speed/). I just had to run:
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f 
Rebooted the HTPC and it fixed the slow transfer speed.
