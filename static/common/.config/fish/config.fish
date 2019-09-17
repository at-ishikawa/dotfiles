set -U FZF_TMUX_HEIGHT "40%"
set -U FZF_DEFAULT_OPTS "--bind ctrl-k:kill-line --height $FZF_TMUX_HEIGHT"

# Golang
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

# gcloud
source $HOME/lib/google-cloud-sdk/path.fish.inc

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH

# iTerm 2
source ~/.iterm2_shell_integration.fish
function iterm2_print_user_vars
  set -l k8s_context (kubectl config current-context)
  set -l gcp_project (cat ~/.config/gcloud/active_config)

  #  set -l gcp_project (gcloud config list --format 'value(core.project)')
  iterm2_set_user_var k8s_context "k8s: $k8s_context"
  iterm2_set_user_var gcp_project "GCP: $gcp_project"
end
