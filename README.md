<h1 align="center"><img src="assets/banner.svg" alt="🪟 Windows 11 Configuration" width="100%"></h1>

A reproducible Windows 11 setup for development and daily use.

## 🚀 TL;DR

```powershell
winget configure --enable

# Base: codecs, runtimes, and redistributables
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/base.dsc.yaml

# Applications
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/apps.dsc.yaml

# Development: languages, tools, and VS Code extensions
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/dev.dsc.yaml

# User configs: copies the repo's user\ folder over your profile, overwriting matching files
$z="$env:TEMP\dotfiles.zip"; irm https://github.com/alexander-danilenko/dotfiles-windows/archive/refs/heads/main.zip -OutFile $z; Expand-Archive $z "$env:TEMP\dotfiles" -Force; robocopy "$env:TEMP\dotfiles\dotfiles-windows-main\user" $HOME /E /XF CLAUDE.md
```

---

## 💿 Windows 11 Installation Media

### 📥 Download Windows 11 ISO image

Download the ISO from one of these sources:

- https://massgrave.dev/windows_11_links
- https://www.microsoft.com/software-download/windows11

> [!TIP]
> Use the **Windows 11 Business** edition from massgrave.dev. It does not include consumer bloatware, Microsoft Store ads, or preinstalled games.

### 💾 Create Bootable USB with Rufus

1. Install [Rufus](https://rufus.ie/).
2. Connect a USB drive of 8 GB or more.
3. Run Rufus, click **SELECT**, and select the ISO.
4. Keep the default settings (GPT, UEFI).
5. Click **START**.

## ⚡ Quick Setup

Do these steps in this order after you install Windows.

### 🔑 Windows Activation

Activate Windows with a license key. If you do not have a key, use [Microsoft Activation Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts) as the last option.

### 🔒 PowerShell Security

Let local scripts run, and require a signature for scripts from the internet:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### 📦 Package Management (WinGet)

1. Install [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from the Microsoft Store.
2. Apply the base config first, then the apps config:

   ```powershell
   winget configure --enable
   # Base: codecs, runtimes, and redistributables
   winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/base.dsc.yaml
   # Applications
   winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/apps.dsc.yaml
   ```

> [!NOTE]
> The commands use the files on the `main` branch, so you do not need to clone the repo. To apply local changes that you did not push, use the local path, for example `winget\apps.dsc.yaml`.

### 🛠️ Development Tools

This config installs Node.js, Python, Java, Go, Rust with the MSVC build tools, VS Code with extensions, Git, and GitHub CLI:

```powershell
winget configure --accept-configuration-agreements -f https://raw.githubusercontent.com/alexander-danilenko/dotfiles-windows/main/winget/dev.dsc.yaml
```

### 🎨 ArtCraft Apps (Optional)

[ArtCraft](https://getartcraft.com/) makes open-source alternatives to professional creative and office apps. The ArtCraft Launcher is not in WinGet. Download it from the ArtCraft site, then use it to install and update the apps.

### 🐧 WSL (Optional)

Install WSL 2 with Debian:

```powershell
wsl --install --distribution Debian
wsl --set-default-version 2
# Reboot required
```

## ⚙️ System Configuration

### 🔋 Power Management

Disable hibernation, and stop devices from waking the PC:

```powershell
# Disable hibernation
powercfg.exe /hibernate off

# Disable wake devices
powercfg -devicequery wake_armed | Where-Object { $_.Trim() -ne 'NONE' } | ForEach-Object { powercfg /devicedisablewake "$($_.Trim())" }
```

### ⏰ Dual-boot Time Sync

If you dual-boot with Linux, set Windows to keep the hardware clock in UTC. Linux also uses UTC, so the clock stays correct in both systems.

```powershell
# Set Windows to use UTC (revert with value 0)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
```

## 🔐 Privacy & Security

### 🛡️ O&O ShutUp10++

Install [O&O ShutUp10++](https://www.oo-software.com/en/shutup10):

```powershell
winget install OO-Software.ShutUp10
```

Run it in PowerShell as administrator:

```powershell
shutup10.exe
```

> [!WARNING]
> Create a system restore point before you change privacy settings.

> [!TIP]
> Use the `🟢 Only recommended settings` preset. Read each setting before you apply it.

## 🔧 Troubleshooting

| Problem | Fix |
|---------|-----|
| Firefox video freezes | Set `widget.windows.window_occlusion_tracking.enabled` to `false` in `about:config` |
| Network failure | `ipconfig /flushdns; netsh winsock reset` |
| Password prompt at sign-in | Run `netplwiz` |
