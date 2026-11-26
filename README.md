<h1 align="center"><img src="assets/banner.svg" alt="🪟 Windows 11 Configuration" width="100%"></h1>

A secure, reproducible Windows 11 setup for development and productivity.

## 🚀 TL;DR

```powershell
winget configure --enable

# Base: languages, runtimes, codecs, and redistributables
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/base.dsc.yaml

# Applications
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/apps.dsc.yaml

# User configs: copies the repo's user\ folder over your profile, overwriting matching files
$z="$env:TEMP\dotfiles.zip"; irm https://github.com/alexander-danilenko/dotfiles-windows/archive/refs/heads/main.zip -OutFile $z; Expand-Archive $z "$env:TEMP\dotfiles" -Force; robocopy "$env:TEMP\dotfiles\dotfiles-windows-main\user" $HOME /E /XF CLAUDE.md
```

---

📖 **Table of contents:**

- [💿 Windows 11 Installation Media](#-windows-11-installation-media)
  - [📥 Download Windows 11 ISO image](#-download-windows-11-iso-image)
  - [💾 Create Bootable USB with Rufus](#-create-bootable-usb-with-rufus)
- [⚡ Quick Setup](#-quick-setup)
  - [🔑 Windows Activation](#-windows-activation)
  - [🔒 PowerShell Security](#-powershell-security)
  - [📦 Package Management (WinGet)](#-package-management-winget)
  - [🛠️ Development Tools](#️-development-tools)
  - [🎨 ArtCraft Apps (Optional)](#-artcraft-apps-optional)
  - [🐧 WSL (Optional)](#-wsl-optional)
- [⚙️ System Configuration](#️-system-configuration)
  - [🔋 Power Management](#-power-management)
  - [⏰ Dual-boot Time Sync](#-dual-boot-time-sync)
- [🔐 Privacy \& Security](#-privacy--security)
  - [🛡️ O\&O ShutUp10++](#️-oo-shutup10)
- [🔧 Troubleshooting](#-troubleshooting)


## 💿 Windows 11 Installation Media

Get your Windows 11 installation ready with clean, bloatware-free media that ensures a smooth setup experience. Using the right installation source prevents unnecessary software and provides a solid foundation for your system. Download the ISO and create a bootable USB drive following the simple steps below.

### 📥 Download Windows 11 ISO image

**Download Windows 11 ISO** file from one of two sources:
- https://massgrave.dev/windows_11_links
- https://www.microsoft.com/software-download/windows11

> [!TIP]
> [massgrave.dev](https://massgrave.dev/windows_11_links) download source contains **Windows 11 Business edition**, which is recommended to use as it doesn't include consumer bloatware, Microsoft Store ads, or preinstalled games like Candy Crush.

### 💾 Create Bootable USB with Rufus

- Download and install [Rufus](https://rufus.ie/)
- Insert USB drive (8GB+ recommended)
- Run Rufus app
- Click "SELECT" and choose the downloaded Windows 11 ISO
- Keep default settings (GPT partition scheme, UEFI target system)
- Click "START" and wait for completion

## ⚡ Quick Setup

Set up your Windows 11 system for development and productivity with these essential post-installation steps. These configurations establish the security policies, package management, and development tools that will serve as your system's foundation. Work through these steps in order to avoid common setup issues and get everything running smoothly.

### 🔑 Windows Activation

Activate your Windows 11 installation to unlock all features and ensure you're running a legitimate copy. While legitimate license keys are preferred, community activation tools provide an alternative when needed. 

> [!IMPORTANT]
> Always prioritize official licensing methods and use community solutions responsibly as the last resort!

- https://github.com/massgravel/Microsoft-Activation-Scripts

### 🔒 PowerShell Security

Configure PowerShell to run setup scripts safely while maintaining security for downloaded content. This policy allows locally created scripts to run while requiring digital signatures for scripts from the internet. Run this command to enable the configuration scripts in this guide:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```


### 📦 Package Management (WinGet)

Set up WinGet to automatically install all your essential applications from two configuration files: system components first, then apps. This approach ensures consistent software installation across different systems and saves time during setup.

- Install the [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from Microsoft Store
- Apply WinGet config by running:

  ```powershell
  winget configure --enable
  # Base: languages, runtimes, codecs, and redistributables
  winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/base.dsc.yaml
  # Applications
  winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/apps.dsc.yaml
  ```

> [!NOTE]
> These commands use the files on the `main` branch, so you don't need to clone the repo first. To apply local changes that you haven't pushed, pass the local path instead, such as `wingetpps.dsc.yaml`.

### 🛠️ Development Tools

Install essential development tools and VS Code extensions to create a productive coding environment. All development applications are included in the WinGet configuration, while VS Code extensions are managed separately for better control. Run the extension script to set up your preferred development tools.

Install VS Code extensions:
```powershell
irm https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/files/vscode-extensions.ps1 | iex
```

### 🎨 ArtCraft Apps (Optional)

[ArtCraft](https://getartcraft.com/) makes open-source alternatives to Adobe, Microsoft Office, and other professional apps:

| App | Alternative to |
|-----|----------------|
| <img src="https://getartcraft.com/images/apps/photocraft/icon.webp" width="16" height="16" alt="" /> [PhotoCraft](https://getartcraft.com/apps/photocraft) | Adobe Photoshop |
| <img src="https://getartcraft.com/images/apps/lightcraft/icon.webp" width="16" height="16" alt="" /> [LightCraft](https://getartcraft.com/apps/lightcraft) | Adobe Lightroom |
| <img src="https://getartcraft.com/images/apps/vectorcraft/icon.webp" width="16" height="16" alt="" /> [VectorCraft](https://getartcraft.com/apps/vectorcraft) | Adobe Illustrator |
| <img src="https://getartcraft.com/images/apps/designcraft/icon.webp" width="16" height="16" alt="" /> [DesignCraft](https://getartcraft.com/apps/designcraft) | Adobe InDesign |
| <img src="https://getartcraft.com/images/apps/figcraft/icon.webp" width="16" height="16" alt="" /> [FigCraft](https://getartcraft.com/apps/figcraft) | Figma |
| <img src="https://getartcraft.com/images/apps/filmcraft/icon.webp" width="16" height="16" alt="" /> [FilmCraft](https://getartcraft.com/apps/filmcraft) | Adobe Premiere Pro |
| <img src="https://getartcraft.com/images/apps/effectcraft/icon.webp" width="16" height="16" alt="" /> [EffectCraft](https://getartcraft.com/apps/effectcraft) | Adobe After Effects |
| <img src="https://getartcraft.com/images/apps/anicraft/icon.webp" width="16" height="16" alt="" /> [AniCraft](https://getartcraft.com/apps/anicraft) | Adobe Animate |
| <img src="https://getartcraft.com/images/apps/pdfcraft/icon.webp" width="16" height="16" alt="" /> [PdfCraft](https://getartcraft.com/apps/pdfcraft) | Adobe Acrobat |
| <img src="https://getartcraft.com/images/apps/wordcraft/icon.webp" width="16" height="16" alt="" /> [WordCraft](https://getartcraft.com/apps/wordcraft) | Microsoft Word |
| <img src="https://getartcraft.com/images/apps/gridcraft/icon.webp" width="16" height="16" alt="" /> [GridCraft](https://getartcraft.com/apps/gridcraft) | Microsoft Excel |
| <img src="https://getartcraft.com/images/apps/deckcraft/icon.webp" width="16" height="16" alt="" /> [DeckCraft](https://getartcraft.com/apps/deckcraft) | Microsoft PowerPoint |
| <img src="https://getartcraft.com/images/apps/soundcraft/icon.webp" width="16" height="16" alt="" /> [SoundCraft](https://getartcraft.com/apps/soundcraft) | Avid Pro Tools |
| <img src="https://getartcraft.com/images/apps/cadcraft/icon.webp" width="16" height="16" alt="" /> [CADCraft](https://getartcraft.com/apps/cadcraft) | Autodesk AutoCAD |
| <img src="https://getartcraft.com/images/apps/materialcraft/icon.webp" width="16" height="16" alt="" /> [MaterialCraft](https://getartcraft.com/apps/materialcraft) | Node-based procedural material designers |
| <img src="https://getartcraft.com/images/apps/texturecraft/icon.webp" width="16" height="16" alt="" /> [TextureCraft](https://getartcraft.com/apps/texturecraft) | 3D texture painting tools |
| <img src="https://getartcraft.com/images/apps/craft-anything/icon.webp" width="16" height="16" alt="" /> [Craft Anything](https://getartcraft.com/apps/craft-anything) | Rebuilding a website, app, or game with AI |

The ArtCraft Launcher installs the apps you choose and keeps them up to date. The launcher isn't in WinGet, so install it manually.

### 🐧 WSL (Optional)

Add Linux compatibility to your Windows system for cross-platform development and testing. WSL provides a lightweight Linux environment that integrates seamlessly with Windows while maintaining excellent performance. Install Debian as your default distribution and configure WSL 2 for the best experience.

```powershell
wsl --install --distribution Debian
wsl --set-default-version 2
# Reboot required
```

## ⚙️ System Configuration

Fine-tune your Windows 11 system with these advanced optimizations that boost performance and resolve common issues. These settings optimize power management, fix time sync problems in dual-boot setups, and improve overall system stability. Apply these configurations after your initial setup to get the most out of your Windows experience.

### 🔋 Power Management

Optimize your system's power consumption and prevent unwanted wake-ups that can drain battery or cause system instability. These settings disable hibernation and prevent devices from waking your computer unexpectedly.

```powershell
# Disable hibernation
powercfg.exe /hibernate off

# Disable wake devices
powercfg -devicequery wake_armed | Where-Object { $_.Trim() -ne 'NONE' } | ForEach-Object { powercfg /devicedisablewake "$($_.Trim())" }
```

### ⏰ Dual-boot Time Sync

Fix time synchronization issues when running Windows alongside Linux in a dual-boot setup. This configuration makes Windows use UTC time instead of local time, preventing clock drift between operating systems.

```powershell
# Set Windows to use UTC (revert with value 0)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
```

## 🔐 Privacy & Security

Take control of your Windows 11 privacy and security with these essential configurations that protect your data and system integrity. These settings reduce unnecessary telemetry and data collection while keeping your system functional and secure.

### 🛡️ O&O ShutUp10++

Install [O&O ShutUp10++](https://www.oo-software.com/en/shutup10) for privacy settings:
```powershell
winget install OO-Software.ShutUp10
```

Run in powershell as administrator:

```powershell
shutup10.exe
```

> [!WARNING]
> Create a system restore point before applying any privacy changes.

> [!TIP]
> Use the `🟢 Only recommended settings` preset. 
> 
> Apply changes responsibly - make sure you read and understand what each setting does before applying it.


## 🔧 Troubleshooting

Find quick solutions to common Windows 11 issues that might pop up during setup or daily use. These troubleshooting steps cover frequent problems like application freezes, network issues, and authentication prompts. Keep this section handy when problems arise to get your system back on track quickly.

| Issue | Solution |
|-------|----------|
| Firefox video freeze | Set `widget.windows.window_occlusion_tracking.enabled` to `false` in `about:config` |
| Network issues | `ipconfig /flushdns; netsh winsock reset` |
| Password prompts | Run `netplwiz` |
