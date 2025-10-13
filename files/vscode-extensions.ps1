$extensions = @(
  "GitHub.copilot",
  "GitHub.vscode-github-actions",
  "acarreiro.calculate",
  "christian-kohler.path-intellisense",
  "christian-kohler.npm-intellisense",
  "dakara.transformer",
  "dbaeumer.vscode-eslint",
  "dotenv.dotenv-vscode",
  "editorconfig.editorconfig",
  "github.github-vscode-theme",
  "golang.go",
  "ms-azuretools.vscode-docker",
  "ms-python.python",
  "ms-vscode-remote.remote-ssh",
  "pkief.material-icon-theme",
  "rokoroku.vscode-theme-darcula",
  "tommasov.hosts",
  "tyriar.lorem-ipsum",
  "yzhang.markdown-all-in-one"
)
foreach ($ext in $extensions) {
  code --install-extension $ext --force
}
