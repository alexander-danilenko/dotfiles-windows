<img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Windows_10x_Icon.png" width="35%" align="right" />

<h1>Windows 11 Configuration</h1>

This repository documents a recommended, secure, and reproducible Windows 11 setup for development and productivity.

> [!IMPORTANT]
> These instructions assume a recent Windows 11 installation with access to the Microsoft Store. Follow each section in order — package management (WinGet) is required before installing developer tooling such as Node.js or VS Code.

---

**Contents**
- Package Management (WinGet)
- [Configuration File (config.dsc.yaml)](#configuration-file-configdscyaml)
- Development tools (Node.js, Visual Studio Code, GitHub Copilot)
- Windows Subsystem for Linux (WSL)
- System configuration (Power, Time, Activation)
- Network configuration
- Privacy & Security
- Troubleshooting
- Environment variables

---


## Windows activation

> [!IMPORTANT]
> **Piracy is illegal and harmful.** Always activate Windows using a legitimate license key or digital entitlement when possible. Only consider community activation helpers as an absolute last resort if you have no other legal option — and be aware these tools are untrusted, may break system updates, and carry security risks.

> [!CAUTION]
> Never run activation or other system-level scripts from unknown sources without inspecting them first.

Use the community-maintained activation helper with caution:
- https://massgrave.dev/

## PowerShell security
Allow local script execution for dotfiles automation:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
Update-Help -ErrorAction Ignore
```

---

<img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Windows_Package_Manager_logo.png" align="right" width="25%">

## Package Management

Use [WinGet](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) to install system packages and apps reliably.

> [!IMPORTANT]
> Install [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from the Microsoft Store before using any WinGet commands.

Quick WinGet commands:
```powershell
# Search for a package
winget search <package-name>

# List installed apps
winget list

# Upgrade all upgradable apps
winget upgrade --all
```

### Applications configuration


## Configuration File (config.dsc.yaml)

The [`config.dsc.yaml`](./files/config.dsc.yaml) file contains a curated list of applications and packages organized by category. This configuration uses WinGet DSC (Desired State Configuration) to automate the installation of essential software.

### Installation Instructions

1. Clone the repository
2. Review the [`config.dsc.yaml`](./files/config.dsc.yaml) file to adjust the curated package list according to your needs
3. In the [`files`](./files) directory, run:
   ```powershell
   winget configure --enable; winget configure --accept-configuration-agreements -f .\config.dsc.yaml
   ```

> [!NOTE]
> WinGet can install both classic installers and Microsoft Store packages (store apps use numeric IDs in DSC).

---

## Development tools

This section assumes WinGet is available and configured.

<img src="https://cdn.svgporn.com/logos/nodejs-icon.svg" align="right" width="25%">

### Node.js

This app is configured for installation via the [`config.dsc.yaml`](#configuration-file-configdscyaml).

Alternatively, install it directly:

```powershell
winget install OpenJS.NodeJS.LTS
```

After installation, restart your terminal and verify:
```powershell
node --version
npm --version
```

Install a minimal set of global tools:
```powershell
npm install --global tldr
```

---

<img src="https://cdn.svgporn.com/logos/visual-studio-code.svg" align="right" width="25%">

### Visual Studio Code

This app is configured for installation via the [`config.dsc.yaml`](#configuration-file-configdscyaml). 

Alternatively, install it directly:

```powershell
winget install Microsoft.VisualStudioCode
```

Import recommended settings (example):
```powershell
Invoke-WebRequest https://raw.githubusercontent.com/alexander-danilenko/dotfiles-macos/refs/heads/main/files/Library/Application%20Support/Code/User/settings.json -OutFile "${env:APPDATA}\Code\User\settings.json"
```

Install extensions using the [`vscode-extensions.ps1` script](./files/vscode-extensions.ps1)

---

<img src="https://cdn.svgporn.com/logos/github-copilot.svg" align="right" width="25%">

### GitHub Copilot

Install GitHub CLI and enable Copilot tooling:
```powershell
winget install --id GitHub.cli
gh auth login
gh extension install github/gh-copilot
```

This app is configured for installation via the [`config.dsc.yaml`](#configuration-file-configdscyaml). 

Alternatively, install it directly:

```powershell
winget install GitHub.cli
```

Usage example:
```powershell
gh copilot suggest "How to disable hibernation using powershell?"
```

---

## Windows Subsystem for Linux (WSL)

<img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Windows_Subsystem_for_Linux_logo.png" align="right" width="25%">

Install WSL (recommended for development):
```powershell
wsl --install --distribution Debian
wsl --set-default-version 2
```

After installation, reboot to complete kernel integration.

Management commands:
```powershell
# List available distros
wsl --list --online

# Install a specific distro
wsl --install --distribution Ubuntu-24.04

# List installed distros with version
wsl --list --verbose

# Run a command inside a distro
wsl --distribution Debian --exec ip route list default
```

File access:
- From Windows to WSL: use `/mnt/c/`
- From WSL to Windows: use `\\wsl$\<distro-name>`

Note: WSL filesystem is case-sensitive; Windows mounts appear with permissive permissions.

---

## System configuration

### Power management

Disable hibernation to reclaim disk space:
```powershell
powercfg.exe /hibernate off
```

Manage devices that wake the PC:
```powershell
powercfg -devicequery wake_armed
powercfg /devicedisablewake "Device Name"
```

To disable all devices that can wake the PC:
```powershell
powercfg -devicequery wake_armed | Where-Object { $_.Trim() -ne 'NONE' } | ForEach-Object { powercfg /devicedisablewake "$($_.Trim())" }
```

### Time settings (dual-boot with Linux)

Set Windows to treat hardware clock as UTC:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
```

To revert, set value to `0`.

---

## Privacy & Security

### O&O ShutUp10++
<img src="https://www.oo-software.com/oocontent/uploads/tour/oosu10-de/pack-tb.png" align="right" width="25%">

> [!WARNING]
> Create a system restore point before applying privacy/privacy-related changes.

This app is configured for installation via the [`config.dsc.yaml`](#configuration-file-configdscyaml). 

Alternatively, install it directly:

```powershell
winget install OO-Software.ShutUp10
```

---

## Troubleshooting

### Firefox video freeze
1. Open `about:config` in Firefox
2. Set `widget.windows.window_occlusion_tracking.enabled` to `false`

### Common commands
| Action | Command |
| ------ | ------- |
| Disable password prompt | `netplwiz` |
| Reset network stack | `ipconfig /flushdns; netsh winsock reset` |

---

## Environment variables

| Variable | Volatile | Default Value (C: drive) |
|----------|:--------:|--------------------------|
| `ALLUSERSPROFILE` | | C:\ProgramData |
| `APPDATA` | | C:\Users\\{Username}\AppData\Roaming |
| `LOCALAPPDATA` | | C:\Users\\{Username}\AppData\Local |
| `PATH` | User/System | C:\Windows\System32\;C:\Windows\;... |
| `ProgramFiles` | | C:\Program Files |
| `ProgramFiles(x86)` | | C:\Program Files (x86) |
| `SYSTEMROOT` | | C:\Windows |
| `TEMP`/`TMP` | User | C:\Users\\{Username}\AppData\Local\Temp |
| `USERPROFILE` | | C:\Users\\{Username} |
