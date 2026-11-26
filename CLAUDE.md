# Windows 11 dotfiles

A reproducible Windows 11 setup: WinGet DSC packages, VS Code extensions, Git config, and per-app user configs. The owner reinstalls Windows from this repo, so every file must work on a fresh machine with a different username and drive layout.

## Instruction files

These instructions target **Claude Opus 5.5**. Before you write or change any `CLAUDE.md` in this repo, fetch the current Anthropic guidance as Markdown and follow it over older habits:

- https://code.claude.com/docs/en/memory.md: CLAUDE.md structure, size (under 200 lines), and nested loading
- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5.md: Opus 5.5 specifics
- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices.md: techniques for all current models

Keep these files short and concrete. State the reason behind a rule instead of using capitals or emphasis, and leave out anything Claude can learn by reading the repo.

## Layout

| Path | Contents |
|------|----------|
| `files/winget.system.dsc.yaml` | WinGet DSC: system components, languages, runtimes, codecs, redistributables |
| `files/winget.apps.dsc.yaml` | WinGet DSC: all other apps |
| `files/vscode-extensions.ps1` | VS Code extension installer |
| `user/` | Mirror of `%USERPROFILE%`. See `user/CLAUDE.md` for the path and cleanup rules |
| `user/.gitconfig` | Git config (aliases, rebase-based pulls, `autocrlf = input`). Identity and machine-specific values go in `~/.gitconfig.local`, which isn't in the repo |
| `README.md` | Setup guide for a fresh Windows install |
| `assets/banner.svg` | Animated README banner |

## WinGet DSC (`files/winget.*.dsc.yaml`)

- Put libraries, redistributables, codecs, programming languages, and runtimes in `winget.system.dsc.yaml` (headers: Languages, Codecs, Runtimes). Put everything else in `winget.apps.dsc.yaml` (headers: AI, Development, Internet, Media, System, Utilities, Gaming). The system file is applied first, so apps can rely on its runtimes.
- Add packages under the matching `# --- Category ---` header.
- Entry format, with a short lowercase `id`:

  ```yaml
  - resource: Microsoft.WinGet.DSC/WinGetPackage
    id: vscode
    settings: { id: Microsoft.VisualStudioCode }
  ```

- For Microsoft Store apps, use the numeric ID from the store URL, such as `9NT1R1C2HH7J` from `apps.microsoft.com/detail/9NT1R1C2HH7J`.
- Verify a package ID with `winget show --id <Id>` before adding it, because a wrong ID breaks the whole `winget configure` run.
- To disable a package, comment it out rather than deleting it. The owner keeps disabled entries for reference.

## Changes to the live system

This repo describes the system. It doesn't apply itself. Ask before you overwrite a file in the live profile, change the registry, or install packages. Editing files inside the repo is fine.

## Documentation

- Write in GitHub Flavored Markdown, following the Microsoft Writing Style Guide.
- Use GitHub alerts (`> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`) for callouts. Put them at the root level with no indentation, never inside a list or nested block, because GitHub renders nested alerts as plain blockquotes.
- Mermaid diagrams must render on GitHub, so don't put Markdown lists inside nodes.
- When a change affects setup steps, update `README.md` in the same commit.

## Commits

Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) with the changed file or area as the scope. For example: `feat(winget.apps.dsc.yaml): add uv package manager` or `feat(user): add qBittorrent config`.
