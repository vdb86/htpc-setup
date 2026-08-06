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

- **[Launcher](https://github.com/vdb86/Launcher)**  
  I created a launcher with many options and animated backgrounds.
  Main idea behind it was to provide a xmb launcher experience.
  It also has a screensaver functionality built in.

- **CEC support with Pulse-Eight adapter**  
  I installed a [Pulse-Eight USB CEC adapter](https://github.com/Pulse-Eight/libcec/releases/tag/libcec-7.0.0) and updated its drivers.
  I then realized there's missing functionality so I created my own program CECHelper.
  I still haven't gotten to getting it ready for GitHub

- **YouTube**  
  I created [Cathode](https://github.com/vdb86/Cathode) which allows you to access YouTube the same way SmartTube does on Android.
  It's fully developed to work on Windows and to allow users to use it via remote control/controller.
  I also wrote an android companion app - [Cathode remote](https://github.com/vdb86/Cathode-remote)
  
- **SMB transfer fix**  
  I noticed transfer speeds to my Synology NAS were slow (~16 MB/s).  
  After researching, I found the issue was caused by Windows 11 and fixed it by disabling security signature enforcement.  
  Source: [Winaero](https://winaero.com/windows-11-24h2-significantly-slows-down-smb-data-transfer-speed/)

  Run this in an elevated command prompt:

  ```cmd
  reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f
  ```
  Then reboot. Transfer speeds will go back to normal.
