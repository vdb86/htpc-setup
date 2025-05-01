# HTPC Setup

Experience and tweaks for my HTPC

I bought a **GB-BTIP-N250** to build an HTPC to replace my Raspberry Pi 4 (with LibreELEC and Docker), which started occasionally freezing after 4+ years of running 24/7.

The initial idea was to run **Linux Mint**, but after 2 weeks of trying to get everything working, I was forced to give up — the drivers for the Intel N250 just aren't there yet. Maybe in 6 months or a year everything will work well.

I switched to **Windows 11 Pro**, and even though it uses a bit more resources than Linux Mint, *everything works perfectly*.

---

## What I Set Up (and Why This Repo Exists)

- **Autologin with a local account**  
  In case the HTPC reboots, it will fully boot up and start all necessary programs automatically.

- **Fan control and CPU frequency**  
  The fans on this mini PC can get quite annoying — there's no BIOS control for TDP, and the CPU gets hot fast, ramping up RPM aggressively.  
  I limited the CPU to **3.4GHz** and installed [Fan Control](https://getfancontrol.com/) — this app is worth gold.  
  Huge thanks to Rémi Mercier: [https://github.com/Rem0o](https://github.com/Rem0o)

- **[Flex Launcher](https://github.com/complexlogic/flex-launcher)**  
  An excellent HTPC launcher with great configuration documentation.  
  Big thanks to: [https://github.com/complexlogic](https://github.com/complexlogic)

- **Focus script for Flex Launcher**  
  Sometimes other apps would steal focus from Flex Launcher. I wrote a script (`Flex.ps1`) that runs in the background (low priority), checks every 30 seconds if Flex Launcher is running and focused, and restores focus if needed.  
  Some apps launched from Flex are whitelisted to take focus.
  The script is included in the files folder.

  I converted the script to an `.exe`, so it starts automatically on boot.  
  If you want to use it:
  1. Edit `Flex.ps1` to fit your setup.
  2. Run it as-is or convert it to an `.exe`.  
     See `Convert to exe.txt` for instructions (in the files folder).

- **CEC support with Pulse-Eight adapter**  
  I installed a [Pulse-Eight USB CEC adapter](https://github.com/Pulse-Eight/libcec/releases/tag/libcec-7.0.0) and updated its drivers.  
  If Kodi crashes on launch after this, just reinstall it — you won’t lose any data.

- **CEC Tray behavior**  
  After launching Kodi, `CEC-Tray` disappears from the taskbar — this is expected.  
  Kodi uses the `libCEC` library exclusively, and only one application can access the adapter at a time.

  I wrote a script (`StartKodi.ps1`) that:
  - Launches Kodi
  - Starts `CEC-Tray` after Kodi exits

  You usually don’t need to change the script, but **check file paths** to make sure they match your setup.
  The script is included in the files folder.
  You can run it as-is or convert it to an `.exe`.  
     See `Convert to exe.txt` for instructions (in the files folder).

- **KDE Connect**  
  Installed [KDE Connect](https://kdeconnect.kde.org/) so I can send web pages from my phone to the HTPC. They open in the default browser (**Firefox** with **uBlock**).

- **YouTube TV via browser**  
  Installed this Firefox extension:  
  [YouTube for TV](https://addons.mozilla.org/en-US/firefox/addon/youtube-for-tv/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

  Then installed [Violentmonkey](https://addons.mozilla.org/en-US/firefox/addon/violentmonkey/) and added two user scripts (I've included them in the files folder):
  - Autologin
  - Redirect

  Now, when I send a YouTube video to the HTPC, it opens in `youtube.com/tv`.

- **SMB transfer fix**  
  I noticed transfer speeds to my Synology NAS were slow (~16 MB/s).  
  After researching, I found the issue was caused by Windows 11 and fixed it by disabling security signature enforcement.  
  Source: [Winaero](https://winaero.com/windows-11-24h2-significantly-slows-down-smb-data-transfer-speed/)

  Run this in an elevated command prompt:

  ```cmd
  reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f
