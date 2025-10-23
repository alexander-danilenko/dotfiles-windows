<h1 align="center">🪟 Windows 11 Configuration</h1>

A secure, reproducible Windows 11 setup for development and productivity.

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

Set up WinGet to automatically install all your essential applications from a single configuration file. This approach ensures consistent software installation across different systems and saves time during setup.

- Install the [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from Microsoft Store
- Apply WinGet config by running:

  ```powershell
  # Install all packages from config
  cd <repo>
  winget configure --enable; winget configure --accept-configuration-agreements -f files\config.dsc.yaml
  ```

### 🛠️ Development Tools

Install essential development tools and VS Code extensions to create a productive coding environment. All development applications are included in the WinGet configuration, while VS Code extensions are managed separately for better control. Run the extension script to set up your preferred development tools.

Install VS Code extensions:
```powershell
.\files\vscode-extensions.ps1
```

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
