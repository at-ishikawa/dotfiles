# Stop showing a welcome message
set fish_greeting

set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --bind ctrl-k:kill-line,ctrl-alt-t:toggle-preview,ctrl-alt-n:preview-down,ctrl-alt-p:preview-up,ctrl-alt-v:preview-page-down"

# fish_prompt
set --global __fish_git_prompt_color_branch green --bold

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin

# krew
fish_add_path --append $HOME/.krew/bin

# https://github.com/at-ishikawa/fish-completion-interceptor
set -U FISH_COMPLETION_INTERCEPTOR_ENABLED true
function fish_completion_interceptor_fallback
    __fzf_complete
end

# 1Password CLI shell integration
# In some environment like WSL, it doesn't work
# See https://github.com/1Password/shell-plugins/issues/402
# [ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
