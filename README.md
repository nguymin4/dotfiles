# dotfiles

## Installation
Sync all files in `dotfiles` folder to a target folder

```bash
bash install.sh $HOME
```

## Backup
Sync all files specified in `rsync-dotfiles` file in `$HOME` to a target folder (*default*: current directory `dotfiles` folder)
```bash
bash backup.sh dotfiles
```

## Scanning for hardcoded secrets
**Prerequisite**: Docker

Gitleaks is a SAST tool for detecting hardcoded secrets like passwords, api keys, and tokens in git repos

```bash
bash gitleaks.sh
```

**Note**: There are false positives. For example, `gitleaks` insists that there are leaks in font files which can be explained by the fact that the fonts contain some sensitive word like: `credit`, `visa` etc.
