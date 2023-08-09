#### Copy between WSL and Windows via neovim
```bash
sudo ln -s "/mnt/c/Users/son_nguyen/scoop/apps/neovim/current/bin/win32yank.exe" "/usr/local/bin/win32yank.exe"
```
Notes: we can use clip.exe also

#### Setup locales for wsl
```bash
sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales
```

#### Autostart apps and scripts
Create shortcuts in `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`

e.g `GlazeVM`, `default.ahk`

#### Config location
Some configs are stored in `%APPDATA%` instead of `$HOME\.config`
- Alacritty
- NeoVim
