# gcloud
set GCLOUD_SDK_PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
source $GCLOUD_SDK_PATH/path.fish.inc

# iTerm 2
if test "$TERM_PROGRAM" = "iTerm.app"
    source ~/.iterm2_shell_integration.fish
end
