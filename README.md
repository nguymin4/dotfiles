# dotfiles

Use `rsync` to backup and restore platform-specific dotfiles

## Installation
Sync platform-specific dotfiles to a folder (default: `$HOME`)

```bash
bash install.sh --linux

# OR

bash install.sh --linux --target $HOME
```

## Backup
Back up all platform-specific dotfiles

```bash
bash backup.sh --linux
```

## Scanning for hardcoded secrets
**Prerequisite**: Docker

Gitleaks is a SAST tool for detecting hardcoded secrets like passwords, api keys, and tokens in git repos

```bash
bash gitleaks.sh
```
