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

### git fzf commands
set -g git_command (which git)
set -g git_options --color
# TODO ctrl-alt-V should be used for preview-page-up, but can't use it currently
set -g __fzf_git_preview_key_bindings ctrl-k:kill-line,ctrl-alt-n:preview-down,ctrl-alt-p:preview-up,ctrl-alt-v:preview-page-down

function __fzf_git_branch
    $git_command branch -vv $git_options | fzf --ansi | cut -d ' ' -f 2-3 | string trim
end

function __fzf_git_log
    $git_command log --oneline --color -n 100 | fzf --ansi --preview="git show $git_options {1}" --bind $__fzf_git_preview_key_bindings | awk '{ print $1 }'
end

function __fzf_git_diff
    $git_command diff --color --name-only | fzf --ansi --preview='git diff $git_options {1}' --bind $__fzf_git_preview_key_bindings
end

function __fzf_git
    set -l command $git_command
    set -l arguments
    for arg in $argv
        if echo $arg | string match -r '^\-+' -q -v
            set -a command $arg
        else
            set -a arguments $arg
        end
    end

    # For debug
    # echo $command $arguments

    if [ -z "$arguments" ]
        switch "$command"
            case "$git_command branch"
                __fzf_git_branch
            case "$git_command log"
                __fzf_git_log
            case "$git_command diff"
                __fzf_git_diff
            case '*'
                $command $arguments
        end
    else
        $git_command $argv
    end
end

alias git="__fzf_git"
