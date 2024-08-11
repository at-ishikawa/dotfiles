# Install WSL: https://learn.microsoft.com/en-us/windows/wsl/install
# The list of available distributions by wsl --list --online
wsl --install -d Ubuntu-24.04

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
    "Docker",

    # Some applications are managed by Steam
    # 1. WallPaper Engine
    "Steam"
)
foreach ($package in $packages) {
    echo "Package: $package"
    winget install $package --source winget
}
