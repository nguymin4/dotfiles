Set-PSReadlineOption -EditMode vi
Set-PSReadlineKeyHandler -Chord ctrl+n -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord ctrl+p -Function HistorySearchForward
Set-PSReadlineKeyHandler -Chord ctrl+w -ViMode Insert -Function BackwardDeleteWord
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Chord Shift+Tab -Function TabCompletePrevious
Set-PSReadlineKeyHandler -Chord Ctrl+Tab -Function TabCompleteNext
Set-Alias -Name vi -Value nvim
Invoke-Expression (&starship init powershell)
fnm env --use-on-cd | Out-String | Invoke-Expression

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME\scoop\apps\mambaforge\current\Scripts\conda.exe") {
    (& "$HOME\apps\mambaforge\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion

