# Windows Dotfiles | AI Agent Rules

## PROJECT OVERVIEW
Windows dotfiles repository with WinGet DSC automation, VS Code configuration, and PowerShell setup.

## WINGET DSC MANAGEMENT
- **Install**: `winget configure -f config.dsc.yaml` (installs all packages from DSC configuration)
- **Structure**: Organized sections (AI tools, Development, Internet, Media, System, Utilities, Gaming)
- **Organization**: Maintain existing categorization, use descriptive comments, group related packages

### AI Instructions for WinGet DSC Configuration
When working with this project's DSC configuration, AI agents should:
1. **Understand the structure**: The config.dsc.yaml uses WinGet DSC syntax with organized sections for different application categories
2. **Respect the organization**: Maintain the existing categorization and commenting structure when adding new packages
3. **Follow naming conventions**: Use descriptive comments and group related packages together
4. **Consider dependencies**: Some packages require additional setup steps (noted in comments)
5. **Use proper syntax**: Follow WinGet DSC syntax for different package types

### WinGet DSC Syntax Reference
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

### Microsoft Store Dependencies
When adding Microsoft Store apps to the DSC configuration:
1. **Extract app information from Microsoft Store URLs**:
   - URL format: `https://apps.microsoft.com/detail/{app-id}`
   - Extract numeric app ID from URL (e.g., `9NT1R1C2HH7J` from `/detail/9NT1R1C2HH7J`)
2. **Add to DSC config using WinGet syntax**: `{ id: 9NT1R1C2HH7J }`
3. **Example transformation**:
   - Input URL: `https://apps.microsoft.com/detail/9NT1R1C2HH7J`
   - DSC entry: `{ id: 9NT1R1C2HH7J }`
4. **Placement**: Add Microsoft Store apps in the appropriate section based on category

## VS CODE CONFIGURATION
- **Extensions**: Managed via PowerShell script (vscode-extensions.ps1)

## POWERSHELL CONFIGURATION
- **Execution Policy**: RemoteSigned for local scripts
- **Scripts**: Automation scripts for system configuration

## PATTERNS
- **DSC Configuration**: Group by category with clear section headers
- **VS Code**: Extensions installed via PowerShell script
- **Shell**: PowerShell with custom profile and modules
- **Git**: Rebase-based workflow with custom aliases

## SECURITY
- Standard dotfiles patterns (no sensitive data)
- Git configuration includes safe defaults
- VS Code settings use standard security practices
- PowerShell execution policy configured for security

## GIT CONVENTIONS
- **Commit Format**: Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification
- **Structure**: `<type>[optional scope]: <description>`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`
- **Breaking Changes**: Use `!` after type/scope or `BREAKING CHANGE:` footer
- **Examples**: 
  - `feat: add new VS Code extension`
  - `fix(brewfile): correct package name`
  - `docs: update installation instructions`
  - `feat!: remove deprecated configuration`
- **Workflow**: Rebase-based (`p` alias pulls with rebase)
- **Aliases**: Custom aliases for common operations
