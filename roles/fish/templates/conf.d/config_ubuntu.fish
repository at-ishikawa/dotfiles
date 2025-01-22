# Configurations only for Linux
set -g GOOGLE_CLOUD_SDK_ROOT $HOME/local/google-cloud-sdk
set -g PATH $PATH $GOOGLE_CLOUD_SDK_ROOT/bin

set -g GOROOT /usr/local/go
set -a PATH $GOROOT/bin
