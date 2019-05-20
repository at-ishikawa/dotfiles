set -U FZF_TMUX_HEIGHT "40%"
set -U FZF_DEFAULT_OPTS "--bind ctrl-k:kill-line --height $FZF_TMUX_HEIGHT"

# Golang
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
