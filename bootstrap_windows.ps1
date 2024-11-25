# Install WSL: https://learn.microsoft.com/en-us/windows/wsl/install
# The list of available distributions by wsl --list --online
wsl --install -d Ubuntu-24.04

# Improve a WSL networking speed
# See https://github.com/microsoft/WSL/issues/8171#issuecomment-1378665636
$adapter = Get-NetAdapter -Name "*vEthernet (WSL*" -IncludeHidden
if ($adapter) {
    Disable-NetAdapterLso -IncludeHidden -Name $adapter.Name
}

# Search packages by winget search $keyword
$packages = @(
    "Google Drive",
    "1Password",
    "powertoys",
    "Auto Dark Mode", #https://github.com/AutoDarkMode/Windows-Auto-Night-Mode
    "google.japaneseime",

    # "canonical.ubuntu.2204",
    "vscode",
    "git.git",
    "Grammarly.Grammarly"

    # Some applications are managed by Steam
    # 1. WallPaper Engine
    "Steam"
)
foreach ($package in $packages) {
    echo "Package: $package"
    winget install $package --source winget
}

# todo: install Rancher Desktop
