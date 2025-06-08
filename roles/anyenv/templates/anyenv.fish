# anyenv
set -a PATH $HOME/.anyenv/bin
if type -q anyenv
    # Use anyenv init - fish: https://github.com/anyenv/anyenv/issues/69
    status --is-interactive; and source (anyenv init - fish|psub)
end

## nodenv under anyenv
### nodenv also needs a plugin node-build for an install command
set NODE_ENV_ROOT $HOME/.anyenv/envs/nodenv
set -a PATH $NODE_ENV_ROOT/bin
set -a PATH $NODE_ENV_ROOT/plugins/node-build/bin
if type -q nodenv
    status --is-interactive; and nodenv init - fish | source
end

## rbenv under anyenv
### rbenv also needs a plugin ruby-build for an install command
set RBENV_ROOT $HOME/.anyenv/envs/rbenv
set -a PATH $RBENV_ROOT/bin
set -a PATH $RBENV_ROOT/plugins/ruby-build/bin
if type -q rbenv
    status --is-interactive; and rbenv init - --no-rehash fish | source
end

## tfenv under anyenv
set -a PATH $HOME/.anyenv/envs/tfenv/bin
if type -q tfenv
    status --is-interactive; and source (tfenv init -|psub)
end
