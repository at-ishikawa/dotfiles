set -U FZF_COMPLETE 2
set -U FZF_TMUX_HEIGHT "40%"
set -U FZF_DEFAULT_OPTS "--bind ctrl-k:kill-line --height $FZF_TMUX_HEIGHT"

# fish_prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
# set -g __fish_git_prompt_color -b grey
# set -g __fish_git_prompt_color_branch -b grey yellow
set __fish_git_prompt_color_upstream_ahead -b grey green
set __fish_git_prompt_color_upstream_behind -b grey red
set __fish_git_prompt_show_informative_status 'yes'

# Golang
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

# gcloud
source $HOME/lib/google-cloud-sdk/path.fish.inc

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
set -x PATH $HOME/.anyenv/envs/nodenv/bin $PATH

# krew
set -gx PATH $PATH $HOME/.krew/bin

# iTerm 2
if test "$TERM_PROGRAM" = "iTerm.app"
    # function fish_title
    #     echo 'Custom title'
    # end
    source ~/.iterm2_shell_integration.fish
end
