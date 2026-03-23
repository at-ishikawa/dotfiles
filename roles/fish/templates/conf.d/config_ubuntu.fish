# Configurations only for Linux
set --global GOOGLE_CLOUD_SDK_ROOT $HOME/local/google-cloud-sdk
fish_add_path --append $GOOGLE_CLOUD_SDK_ROOT/bin

set --global GOROOT /usr/local/go
fish_add_path --append $GOROOT/bin
