wsl --set-default-version 2
wsl --install -d Ubuntu-22.04

# Plugins:
# - usbipd-win
# - vscode wsl 2 plugin

# If we want to customize location
function Change-WSL-Location {
  mkdir -p D:\wsl\Ubuntu-2204

  # Find the default location of vhdx
  # Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\ | ForEach-Object { (Get-ItemProperty $_.PSPATH) | Select-Object DistributionName,BasePath }

  wsl --import Ubuntu-2204 D:\wsl\Ubuntu-2204 "C:\Users\son_nguyen\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx" --vhd
  wsl --set-default Ubuntu-2204
  wsl --unregister Ubuntu-22.04
}
