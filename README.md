# dotfiles

## Installation
Sync all files in `dotfiles` folder to a target folder

```bash
bash install.sh --src dotfiles --target $HOME
```

## Backup
Sync all files specified in `rsync-dotfiles` file in `$HOME` to a target folder (*default*: current directory `dotfiles` folder)
```bash
bash backup.sh --config rsync-dotfiles --target dotfiles
```

## Scanning for hardcoded secrets
**Prerequisite**: Docker

Gitleaks is a SAST tool for detecting hardcoded secrets like passwords, api keys, and tokens in git repos

```bash
bash gitleaks.sh
```
