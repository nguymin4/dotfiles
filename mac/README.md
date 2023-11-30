## Set-up checklist for MacOS

- [ ] `xcode-select --install`
- [ ] Run installation scripts
- [ ] Change keyboard modifiers: `System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys`
    - MacBook internal keyboard: CapsLock -> Esc, Fn -> Ctrl
    - PC external keyboard: CapsLock -> Esc, Options -> Cmd, Cmd -> Options
- [ ] Disable font smoothing: `defaults -currentHost write -g AppleFontSmoothing -int 0`
- [ ] Allow key repeating by holding: `defaults write -g ApplePressAndHoldEnabled -bool false`
