set -U FZF_COMPLETE 2
set -U FZF_TMUX 1
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
if test "$TERM_PROGRAM" = "iTerm.app"
    source ~/.iterm2_shell_integration.fish
    function iterm2_print_user_vars
        set -l k8s_context (kubectl config current-context)
        set -l gcp_project (cat ~/.config/gcloud/active_config)

        #  set -l gcp_project (gcloud config list --format 'value(core.project)')
        iterm2_set_user_var k8s_context "k8s: $k8s_context"
        iterm2_set_user_var gcp_project "GCP: $gcp_project"
    end
end

### git fzf commands
set -g git_command (which git)
set -g git_options --color
# TODO ctrl-alt-V should be used for preview-page-up, but can't use it currently
set -g __fzf_git_preview_key_bindings ctrl-alt-n:preview-down,ctrl-alt-p:preview-up,ctrl-alt-v:preview-page-down

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


# # Current version of fzf_complete: https://github.com/junegunn/fzf/issues/868#issuecomment-425592957
# # Other version: https://github.com/junegunn/fzf/wiki/Examples-(fish)#completion
# function fzf_complete
#     set -l cmdline (commandline)
#     # HACK: Color descriptions manually.
#     complete -C | string replace -r \t'(.*)$' \t(set_color $fish_pager_color_description)'$1'(set_color normal) \
#     | fzf -d \t -1 -0 --ansi --header="$cmdline" --height="80%" --tabstop=4 \
#     | read -l token
#     # Remove description
#     set token (string replace -r \t'.*' '' -- $token)
#     commandline -rt "$token"
# end

# # @todo: bind-key should be ctrl-space and it's gonna be merged into fish 3.1.
# # https://github.com/fish-shell/fish-shell/issues/3189
# bind \cx 'fzf_complete; commandline -f repaint'
