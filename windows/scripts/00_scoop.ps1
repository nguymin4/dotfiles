Invoke-RestMethod get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop bucket add versions

# CLI
scoop install git neovim starship wget fnm fd bat pwsh refreshenv msys2

# UI
scoop install vscode alacritty glazewm flow-launcher autohotkey

# Fonts
scoop bucket add nerd-fonts
scoop install nerd-fonts/Ubuntu-NF nerd-fonts/UbuntuMono-NF-Mono
