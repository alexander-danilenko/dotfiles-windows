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
| `winget/base.dsc.yaml` | WinGet DSC: system components, languages, runtimes, codecs, redistributables |
| `winget/apps.dsc.yaml` | WinGet DSC: all other apps |
| `files/vscode-extensions.ps1` | VS Code extension installer |
| `user/` | Mirror of `%USERPROFILE%`. See `user/CLAUDE.md` for the path and cleanup rules |
| `user/.gitconfig` | Git config (aliases, rebase-based pulls, `autocrlf = input`). Identity and machine-specific values go in `~/.gitconfig.local`, which isn't in the repo |
| `README.md` | Setup guide for a fresh Windows install |
| `assets/banner.svg` | Animated README banner |

## WinGet DSC (`winget/*.dsc.yaml`)

- Put libraries, redistributables, codecs, programming languages, and runtimes in `base.dsc.yaml` (headers: Languages, Codecs, Runtimes). Put everything else in `apps.dsc.yaml` (headers: AI, Development, Internet, Media, System, Utilities, Gaming). The base file is applied first, so apps can rely on its runtimes.
- Add packages under the matching `# --- Category ---` header.
- Entry format, with a short lowercase `id`:

  ```yaml
  - resource: Microsoft.WinGet.DSC/WinGetPackage
    id: vscode
    settings: { id: Microsoft.VisualStudioCode }
  ```

- Use the `winget` source ID, such as `Mozilla.Firefox`, even when the same app is in the Microsoft Store. Classic installers update themselves, and browser extensions like 1Password's need native messaging, which works less reliably with Store (MSIX) builds. Use a Store ID, such as `9PM860492SZD` from `apps.microsoft.com/detail/9PM860492SZD`, only when `winget search <name> --source winget` finds no package, or when the winget package can't install unattended (it needs admin, or downloads from an unversioned URL whose hash goes stale). Leave a one-line comment on that entry saying why, so it isn't switched back.
- Don't add `securityContext: elevated` to a `WinGetPackage` unit. In winget 1.30 the elevated helper can't reach the WinGet COM server and fails with `0x800706BA` (RPC server unavailable). `Microsoft.VisualStudio.DSC/VSComponents` still needs it.
- Verify a package ID with `winget show --id <Id>` before adding it, because a wrong ID breaks the whole `winget configure` run.
- To disable a package, comment it out rather than deleting it. The owner keeps disabled entries for reference.

## Changes to the live system

This repo describes the system. It doesn't apply itself. Ask before you overwrite a file in the live profile, change the registry, or install packages. Editing files inside the repo is fine.

## Documentation

- Write in GitHub Flavored Markdown, following the Microsoft Writing Style Guide.
- Use GitHub alerts (`> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`) for callouts. Put them at the root level with no indentation, never inside a list or nested block, because GitHub renders nested alerts as plain blockquotes.
- Mermaid diagrams must render on GitHub, so don't put Markdown lists inside nodes.
- When a change affects setup steps, update `README.md` in the same commit.
- When you add, rename, move, or remove a `##` or `###` heading in `README.md`, update its table of contents in the same edit, in document order. GitHub drops emoji from anchors but keeps the variation selector, so `### 🐧 WSL (Optional)` becomes `#-wsl-optional` and `### 🛠️ Development Tools` becomes `#️-development-tools`. TL;DR sits above the table of contents and stays out of it.

## Git

Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) with the changed file or area as the scope. For example: `feat(apps.dsc.yaml): add uv package manager` or `feat(user): add qBittorrent config`. The summary states the outcome in the imperative, not the files touched, so `git log --oneline` alone tells commits apart.

### Types

Pick the type from what the change does, not from the files it touches.

| Type | The change |
|------|------------|
| `feat` | Adds or changes what a fresh install gets: a package, an app config, a setup step |
| `fix` | Corrects a config or step that was wrong or broken |
| `refactor` | Restructures files with the same end result, such as splitting a DSC file |
| `docs` | `README.md`, `CLAUDE.md` files, or comments only |
| `style` | Formatting only |
| `chore` | Repo housekeeping, such as removing an unused file |

Add `!` after the scope for a breaking change, such as a moved file the README links to.

### Commit body

Write a body when the diff can't say why: the root cause of a `fix`, or an option you rejected that a reader might otherwise restore. Use up to three short prose paragraphs, wrapped at 72 characters, and leave out references a later reader can't open, such as chat or "as discussed". Skip the body when the subject says it all.

### Atomic commits

Each commit has one type and one scope, and the repo stays usable for a fresh install at every commit, so any commit can be reviewed or reverted on its own.

- Split mixed work: a refactor that a fix needs lands as `refactor`, then `fix`.
- Group by intent, not by file. Two unrelated packages in one file can be two commits.
- Land a rename or move together with every reference to it, such as `README.md` links.
- Name the paths in `git add` and `git commit -- <paths>` so unrelated edits stay out.
- `git add -p` is interactive and doesn't work here. To split one file, write the hunks as a patch, run `git apply --cached <patch>`, check `git diff --cached`, then run `git commit` without paths, because `git commit -- <path>` takes the whole file and undoes the split.
