# Configurations only for Linux
set --universal GOOGLE_CLOUD_SDK_ROOT $HOME/local/google-cloud-sdk
fish_add_path --append $GOOGLE_CLOUD_SDK_ROOT/bin

set --universal GOROOT /usr/local/go
fish_add_path --append $GOROOT/bin
