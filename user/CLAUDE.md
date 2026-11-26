# `user/`: mirror of the user profile

Files here sit at the same path relative to `user/` as they have under `%USERPROFILE%` (`C:\Users\<username>`). For example, `user\AppData\Roaming\qBittorrent\qBittorrent.ini` installs to `%APPDATA%\qBittorrent\qBittorrent.ini`. Keep the exact path and casing, because files are restored by copying `user\` over the profile folder.

## Adding a config

1. Copy the file from the live profile and clean it up before you commit it. The repo is shared and gets restored onto other machines, so a raw copy leaks personal data and breaks on a different drive layout.
2. Only add files that hold preferences. Skip caches, logs, databases, session data, and anything the app generates.
3. If the format allows comments, add a short header that says what the file does, how to install it, and which settings the owner must set by hand on each machine.

## What to remove

- Absolute paths, such as `C:\`, `E:\`, `C:\Users\<username>`, and lists of recent paths.
- Usernames, email addresses, machine names, and hardware IDs.
- Listening ports, IP addresses, and network interface names or IDs.
- Window state: sizes, positions, splitter and column layouts, sort order, last-opened tab, and "already shown" flags.
- Secrets: passwords and their hashes, API keys, tokens, cookies, and license keys.

Keep settings the owner chose on purpose, such as tuning, language, theme, and behavior. Also keep format-version keys like Qt's `[Meta] MigrationVersion`, which stop the app from re-running settings migrations. Drop a removed key completely instead of leaving it empty, so the app falls back to its own default.

## Installing

After you change anything in `user/.claude/`, ask the owner whether to apply it to `%USERPROFILE%\.claude\` too. Claude Code reads only the live folder, so a repo-only change does nothing until it's copied. Before copying, diff the live file against the last commit so that live-only edits aren't lost.

Fully exit the app first. Many apps, qBittorrent included, minimize to the tray when you close the window and overwrite their config when they exit. Back up the existing file before you replace it.

## Format notes

- Files use LF line endings, as set in `.editorconfig`. Qt and JSON configs read LF without issues.
- In Qt INI files, comments start with `;` and backslashes in values are doubled (`G:\\Folder`).
