# 🪟 Windows 11 Configuration

A secure, reproducible Windows 11 setup for development and productivity.

> [!IMPORTANT]
> Requires Windows 11 with Microsoft Store access. Install WinGet first, then follow sections in order.

## 💿 Windows 11 Installation Media

### 📥 Download Windows 11 ISO & Create Bootable USB

1. **Download Windows 11 ISO** file from one of two sources:
   - https://massgrave.dev/windows_11_links
   - https://www.microsoft.com/software-download/windows11
2. **Create Bootable USB with Rufus**:
   - Download and install [Rufus](https://rufus.ie/)
   - Insert USB drive (8GB+ recommended)
   - Run Rufus app
   - Click "SELECT" and choose the downloaded Windows 11 ISO
   - Keep default settings (GPT partition scheme, UEFI target system)
   - Click "START" and wait for completion

> [!TIP]
> [massgrave.dev](https://massgrave.dev/windows_11_links) download source contains **Windows 11 Business edition**, which is recommended to use as it doesn't include consumer bloatware, Microsoft Store ads, or preinstalled games like Candy Crush.

## ⚡ Quick Setup

### 🔑 Windows Activation

> [!CAUTION]
>
> Use legitimate license keys! 
> 
> Community activation helpers are last resort only: https://massgrave.dev/

### 🔒 PowerShell Security
```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### 📦 Package Management (WinGet)
- Install [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from Microsoft Store
- Apply WinGet config by:

  ```powershell
  # Install all packages from config
  cd <repo>/files
  winget configure --enable; winget configure --accept-configuration-agreements -f .\config.dsc.yaml
  ```

### 🛠️ Development Tools

All tools are included in WinGet [`config.dsc.yaml`](./files/config.dsc.yaml) config file.

Install VS Code extensions:
```powershell
.\files\vscode-extensions.ps1
```

### 🐧 WSL (Optional)
```powershell
wsl --install --distribution Debian
wsl --set-default-version 2
# Reboot required
```

## ⚙️ System Configuration

### 🔋 Power Management
```powershell
# Disable hibernation
powercfg.exe /hibernate off

# Disable wake devices
powercfg -devicequery wake_armed | Where-Object { $_.Trim() -ne 'NONE' } | ForEach-Object { powercfg /devicedisablewake "$($_.Trim())" }
```

### ⏰ Dual-boot Time Sync
```powershell
# Set Windows to use UTC (revert with value 0)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
```

## 🔐 Privacy & Security

Install O&O ShutUp10++ for privacy settings:
```powershell
winget install OO-Software.ShutUp10
```

> [!WARNING]
> Create a system restore point before applying privacy changes.

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Firefox video freeze | Set `widget.windows.window_occlusion_tracking.enabled` to `false` in `about:config` |
| Network issues | `ipconfig /flushdns; netsh winsock reset` |
| Password prompts | Run `netplwiz` |
