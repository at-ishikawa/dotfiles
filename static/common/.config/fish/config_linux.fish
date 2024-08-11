# Configurations only for Linux
set -g GOOGLE_CLOUD_SDK_ROOT $HOME/local/google-cloud-sdk
set -g PATH $PATH $GOOGLE_CLOUD_SDK_ROOT/bin

set -g GOROOT /usr/local/go
set -g PATH $PATH $GOROOT/bin

# Configure docker CLI from docker desktop
# https://github.com/docker/for-win/issues/13088#issuecomment-1536365076
set -g PATH $PATH /mnt/wsl/docker-desktop/cli-tools/usr/bin/
