set -U FZF_COMPLETE 2
set -U FZF_TMUX_HEIGHT "40%"
set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --bind ctrl-k:kill-line,ctrl-alt-t:toggle-preview,ctrl-alt-n:preview-down,ctrl-alt-p:preview-up,ctrl-alt-v:preview-page-down"

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

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
# error happens for some reasons
# if type -q anyenv
#     status --is-interactive; and source (anyenv init -|psub)
# end

# nodenv under anyenv
set -x PATH $HOME/.anyenv/envs/nodenv/bin $PATH
if type -q nodenv
    status --is-interactive; and source (nodenv init -|psub)
end

# krew
set -gx PATH $PATH $HOME/.krew/bin

set -x PATH $HOME/bin $PATH

# Sourcegraph
if test -e ~/.sourcegraph/access_token
    set -x SRC_ACCESS_TOKEN (cat ~/.sourcegraph/access_token)
end

# load config files depending on OS
set -l config_root_directory ~/.config/fish
source $config_root_directory/config_(uname | string lower).fish

# Run ssh-agent
if not pgrep -f ssh-agent > /dev/null
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
