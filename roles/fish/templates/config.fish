# Stop showing a welcome message
set fish_greeting

set -gx EDITOR emacs

set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --bind ctrl-k:kill-line,ctrl-alt-t:toggle-preview,ctrl-alt-n:preview-down,ctrl-alt-p:preview-up,ctrl-alt-v:preview-page-down"

# fish_prompt
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate yes
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showupstream yes
# set -g __fish_git_prompt_color -b grey
# set -g __fish_git_prompt_color_branch -b grey yellow
set __fish_git_prompt_color_upstream_ahead -b grey green
set __fish_git_prompt_color_upstream_behind -b grey red
set __fish_git_prompt_show_informative_status yes

# Golang
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

## nodenv under anyenv
### nodenv also needs a plugin node-build for an install command
set NODE_ENV_ROOT $HOME/.anyenv/envs/nodenv
set -x PATH $NODE_ENV_ROOT/bin $NODE_ENV_ROOT/plugins/node-build/bin $PATH
if type -q nodenv
    status --is-interactive; and nodenv init - fish | source
end

# krew
set -gx PATH $PATH $HOME/.krew/bin

set -x PATH $HOME/bin $PATH

set -Ux USE_GKE_GCLOUD_AUTH_PLUGIN True

# https://github.com/at-ishikawa/fish-completion-interceptor
set -U FISH_COMPLETION_INTERCEPTOR_ENABLED true
function fish_completion_interceptor_fallback
    __fzf_complete
end

# 1Password CLI shell integration
# In some environment like WSL, it doesn't work
# See https://github.com/1Password/shell-plugins/issues/402
# [ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
