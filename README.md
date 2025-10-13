<img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Windows_10x_Icon.png" width="35%" align="right" />

<h1>Windows 11 Configuration</h1>

A comprehensive guide for configuring and optimizing Windows 11 for development, productivity, and security.

**📖 Table of contents:**
- [System Configuration](#system-configuration)
  - [Windows Activation](#windows-activation)
  - [Power Management](#power-management)
    - [Disable Hibernation](#disable-hibernation)
    - [Manage Sleep Mode Wake-ups](#manage-sleep-mode-wake-ups)
  - [Time Settings](#time-settings)
- [Package Management](#package-management)
  - [WinGet Usage](#winget-usage)
    - [Basic Commands](#basic-commands)
  - [Applications Config](#applications-config)
- [Development Environment](#development-environment)
  - [Visual Studio Code](#visual-studio-code)
    - [Configuration](#configuration)
    - [VSCode Extensions](#vscode-extensions)
  - [GitHub Copilot](#github-copilot)
    - [Installation](#installation)
    - [Usage Example](#usage-example)
  - [Node.js Setup](#nodejs-setup)
    - [Installation](#installation-1)
    - [Global Packages](#global-packages)
  - [Windows Subsystem for Linux](#windows-subsystem-for-linux)
    - [Installation](#installation-2)
    - [Management Commands](#management-commands)
    - [File System Access](#file-system-access)
- [Network Configuration](#network-configuration)
  - [Network Credentials](#network-credentials)
  - [Hosts File Management](#hosts-file-management)
- [Privacy \& Security](#privacy--security)
  - [O\&O ShutUp10++](#oo-shutup10)
  - [PowerShell Security](#powershell-security)
- [Troubleshooting](#troubleshooting)
  - [Firefox Video Freeze](#firefox-video-freeze)
  - [Common Commands](#common-commands)
- [Environment Variables](#environment-variables)

---

## System Configuration

### Windows Activation

> [!CAUTION]
> Always review activation scripts before running them. Never execute scripts blindly from the internet.

> [!TIP]
> Consider purchasing OEM license keys online for legitimate activation at reduced prices.

Use the [massgrave repository](https://github.com/massgravel/Microsoft-Activation-Scripts) for reliable and secure Windows activation:
* https://massgrave.dev/

### Power Management

#### Disable Hibernation

Free up disk space and improve system performance:
```powershell
powercfg.exe /hibernate off
```

#### Manage Sleep Mode Wake-ups
List devices that can wake the system:
```powershell
powercfg -devicequery wake_armed
```

Disable wake for specific device:
```powershell
powercfg /devicedisablewake "Device Name"
```

### Time Settings

Configure time synchronization for dual-boot setups:

Enable universal time:
```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
```

Disable universal time:
```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 0
```

<img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Windows_Package_Manager_logo.png" align="right" width="25%">

## Package Management

### WinGet Usage

> [!IMPORTANT]
> Install [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) from Microsoft Store first.

#### Basic Commands
```powershell
# Search packages
winget search <appName>

# List installed apps
winget list

# Update all apps
winget upgrade --all
```

### Applications Config

- Review [`./files/config.dsc.yaml`](./files/config.dsc.yaml) file and modify if needed.
- Run in [`./files`](./files/) directory:
  ```
  winget configure --enable; winget configure --accept-configuration-agreements -f .\config.dsc.yaml
  ```

## Development Environment

<img src="https://cdn.svgporn.com/logos/visual-studio-code.svg" align="right" width="25%">

### Visual Studio Code


#### Configuration
Import settings from dotfiles:
```powershell
Invoke-WebRequest https://raw.githubusercontent.com/alexander-danilenko/dotfiles-macos/refs/heads/main/files/Library/Application%20Support/Code/User/settings.json -OutFile "${env:APPDATA}\Code\User\settings.json"
```

#### VSCode Extensions

Run [`./files/vscode-extensions.ps1`](./files/vscode-extensions.ps1) script.


<img src="https://cdn.svgporn.com/logos/github-copilot.svg" align="right" width="25%">

### GitHub Copilot

#### Installation
```powershell
# Install GitHub CLI
winget install --id GitHub.cli

# Authenticate
gh auth login

# Install Copilot extension
gh extension install github/gh-copilot
```

#### Usage Example
```powershell
gh copilot suggest How to disable hibernation using powershell?
```

<img src="https://cdn.svgporn.com/logos/nodejs-icon.svg" align="right" width="25%">
### Node.js Setup

#### Installation
```powershell
winget install --id OpenJS.NodeJS.LTS
```

#### Global Packages
```powershell
npm install --global tldr
```

> [!IMPORTANT]
> Restart terminal after Node.js installation before installing npm packages.

### Windows Subsystem for Linux
<img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Windows_Subsystem_for_Linux_logo.png" align="right" width="25%">

#### Installation
```powershell
wsl --install --distribution Debian
wsl --set-default-version 2
```

> [!IMPORTANT]
> Reboot after WSL installation for proper kernel integration.

#### Management Commands
```powershell
# List available distros
wsl --list --online

# Install specific distros
wsl --install --distribution Debian
wsl --install --distribution Ubuntu-24.04

# List installed versions
wsl --list --verbose

# Get distro IP
wsl --distribution Debian --exec ip route list default
```

#### File System Access
- WSL → Windows: Access via `\\wsl$\<distro-name>`
- Windows → WSL: Access via `/mnt/c/`, `/mnt/d/`, etc.

> [!NOTE]
> WSL filesystem is case-sensitive. Windows drives in WSL have `777` permissions by default.

## Network Configuration

### Network Credentials
```powershell
$SmbAddresses = @("192.168.50.123", "NetworkStorage")
$cred = Get-Credential -Message "Enter credentials for NAS SMB access"
foreach ($address in $SmbAddresses) {
    $cmdkeyTarget = $address -replace "^\\\\+", ""
    cmdkey.exe /delete:$cmdkeyTarget | Out-Null
    cmdkey.exe /add:$cmdkeyTarget /user:$($cred.UserName) /pass:$($cred.GetNetworkCredential().Password)
}
```

### Hosts File Management
```powershell
code %SystemRoot%\System32\drivers\etc\hosts
```

## Privacy & Security

### O&O ShutUp10++
<img src="https://www.oo-software.com/oocontent/uploads/tour/oosu10-de/pack-tb.png" align="right" width="25%">

Download [O&O ShutUp10++](https://www.oo-software.com/en/shutup10) to manage Windows privacy settings.

> [!WARNING]
> Create a system restore point before applying changes.

### PowerShell Security
```powershell
# Allow local scripts
Set-ExecutionPolicy RemoteSigned

# Update help files
Update-Help -ErrorAction Ignore
```

## Troubleshooting

### Firefox Video Freeze
1. Open `about:config`
2. Set `widget.windows.window_occlusion_tracking.enabled` to `false`

### Common Commands
| Action | Command |
| ------ | ------- |
| Disable password prompt | `netplwiz` |
| Reset network stack | `ipconfig /flushdns; netsh winsock reset` |

## Environment Variables

| Variable | Volatile | Default Value (C: drive) |
|----------|:--------:|--------------------------|
| `ALLUSERSPROFILE` | | C:\ProgramData |
| `APPDATA` | | C:\Users\{username}\AppData\Roaming |
| `LOCALAPPDATA` | | C:\Users\{username}\AppData\Local |
| `PATH` | User/System | C:\Windows\System32\;C:\Windows\;... |
| `ProgramFiles` | | C:\Program Files |
| `ProgramFiles(x86)` | | C:\Program Files (x86) |
| `SYSTEMROOT` | | C:\Windows |
| `TEMP`/`TMP` | User | C:\Users\{Username}\AppData\Local\Temp |
| `USERPROFILE` | | C:\Users\{username} |
