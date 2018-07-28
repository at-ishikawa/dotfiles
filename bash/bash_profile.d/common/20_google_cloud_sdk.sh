#! /bin/bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$GCLOUD_SDK_PATH/path.bash.inc" ]; then source "$GCLOUD_SDK_PATH/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$GCLOUD_SDK_PATH/completion.bash.inc" ]; then source "$GCLOUD_SDK_PATH/completion.bash.inc"; fi

command_exists gcloud || return 0

yes yes | gcloud components update 2&>/dev/null &
