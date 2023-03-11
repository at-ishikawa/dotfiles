# Install WSL: https://learn.microsoft.com/en-us/windows/wsl/install
wsl --install

$packages = @(
   "google.chrome",
   "google.drive",
   "1Password",
   "powertoys",
   "Auto Dark Mode", #https://github.com/AutoDarkMode/Windows-Auto-Night-Mode
   "google.japaneseime",

    "canonical.ubuntu.2204",
    "vscode",
   "git.git"
)
foreach ($package in $packages) {
    echo "Package: $package"
    winget install $package --source winget
}
