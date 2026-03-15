# Configurations only for Linux
set --universal GOOGLE_CLOUD_SDK_ROOT $HOME/local/google-cloud-sdk
set --universal --export --append PATH $GOOGLE_CLOUD_SDK_ROOT/bin

set --universal GOROOT /usr/local/go
set --universal --export --append PATH $GOROOT/bin
