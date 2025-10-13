# Windows Dotfiles | AI Agent Rules

## PROJECT OVERVIEW
This repository manages Windows dotfiles, featuring WinGet DSC automation, VS Code configuration, and PowerShell setup.

## GENERAL GUIDELINES
- **Windows Expertise**: AI agents should possess strong knowledge of Windows systems and configurations.
- **Best Practices**: Always recommend solutions that align with native Windows design and best practices.
- **Prevent Misconfigurations**: Guide users, especially those new to Windows, away from actions that contradict Windows design principles or lead to suboptimal configurations.

## WINGET DSC CONFIGURATION

### Management & Organization
- **Install**: Use `winget configure -f config.dsc.yaml` to install packages.
- **Structure**: Categories include AI tools, Development, Internet, Media, System, Utilities, and Gaming.
- **Guidelines**: Maintain existing categorization, use descriptive comments, and group related packages.
- **Dependencies**: Note any packages requiring additional setup.

### AI Agent Instructions
- **Understand Structure**: Recognize WinGet DSC syntax and category-based organization in `config.dsc.yaml`.
- **Respect Organization**: Preserve existing categories and commenting when adding new packages.
- **Follow Naming**: Use descriptive comments and group related packages.
- **Proper Syntax**: Adhere to WinGet DSC syntax for various package types.

### Syntax Reference
```yaml
# WinGet packages (applications)
- resource: Microsoft.WinGet.DSC/WinGetPackage
  id: package-name
  settings: { id: Publisher.PackageName }

# Microsoft Store apps (using numeric ID)
- resource: Microsoft.WinGet.DSC/WinGetPackage
  id: store-app
  settings: { id: 9NT1R1C2HH7J }

# WinGet packages with version specification
- resource: Microsoft.WinGet.DSC/WinGetPackage
  id: specific-version
  settings: { id: Publisher.PackageName, version: "1.0.0" }
```

### Microsoft Store App Integration
- **Extraction**: Extract numeric app IDs from Microsoft Store URLs (e.g., `9NT1R1C2HH7J` from `https://apps.microsoft.com/detail/9NT1R1C2HH7J`).
- **DSC Entry**: Add using `{ id: 9NT1R1C2HH7J }` in the appropriate category.

## VS CODE CONFIGURATION
- **Extensions**: Managed via `vscode-extensions.ps1` PowerShell script.

## POWERSHELL CONFIGURATION
- **Execution Policy**: `RemoteSigned` for local scripts.
- **Scripts**: Automation scripts for system configuration.

## PATTERNS
- **DSC**: Group by category with clear headers.
- **VS Code**: Extensions installed via PowerShell script.
- **Shell**: PowerShell with custom profile and modules.
- **Git**: Rebase-based workflow with custom aliases.

## SECURITY
- Standard dotfiles patterns; no sensitive data.
- Git configuration uses safe defaults.
- VS Code settings follow standard security practices.
- PowerShell execution policy is configured for security.

## GIT CONVENTIONS
### Commit Format
- Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
- **Structure**: `<type>[optional scope]: <description>`.
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`.
- **Breaking Changes**: Use `!` after type/scope or `BREAKING CHANGE:` footer.
- **Examples**: `feat: add new VS Code extension`, `fix(brewfile): correct package name`.

### Workflow
- **Rebase-based**: (`p` alias pulls with rebase).
- **Aliases**: Custom aliases for common operations.

## GITHUB FLAVORED MARKDOWN (GFM)
### Documentation Guidelines
- All markdown files use [GitHub Flavored Markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).
- All documentation (including `README.md` and code comments) in the repository must follow Microsoft Documentation Guidelines.
- **Mermaid Diagrams**: Supported for flowcharts, sequence diagrams, etc.
- **Alert Blocks**: Use GitHub's alert syntax (e.g., `> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`).
- **Reference**: [GitHub Alerts Documentation](https://github.com/orgs/community/discussions/16925#discussion-4085374).

### Mermaid Diagram Guidelines
- **Syntax**: Use fenced code blocks with ````mermaid`.
- **Renderability**: All diagrams must render on GitHub.
- **Testing**: Test diagrams on GitHub before finalizing.
- **Supported Types**: Flowcharts, Sequence, Gantt, Class, State, ER, Pie, Requirement, Journey, GitGraph, Mindmap, Timeline.

### Mermaid Limitations
- No Markdown lists within node definitions.
- Not supported in GitHub Wikis.
- Security sandboxing limits interactive functionality.
- Complex diagrams may have inconsistent rendering.
- Rendering may vary across platforms.

### Mermaid Best Practices
- Test diagrams on GitHub.
- Avoid Markdown lists in nodes; use simple text.
- Reference [Mermaid Documentation](https://github.com/mermaid-js/mermaid`).
