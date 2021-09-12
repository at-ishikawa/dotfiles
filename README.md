# Getting Started
1. Copy `bash/.env.example` file to `bash/.env` file and edit it.
2. Run make by `make install`

# Configurations
## Common for platforms
### tmux
1. Use C-t for prefix, instead of C-b
2. Enable mouse


### fish
This dotfiles contain fish to
1. prompt configuration for minimumlist, but show k8s or GCP configuration names if they should be shown.

These environment variables can be configured in ~/.config/fish/config.fish
1. FISH_PROMPT_K8S_CONTEXT_NAMES (array): k8s context names that should be shown on prompt
2. FISH_PROMPT_GCP_CONFIG_NAMES (array): GCP config names that should be shown on prompt

### git

### bash
1. Configure PATH for followings
   - Google Cloud SDK
   - Android SDk
   - Anyenv
   - Golang
   - Gem

### emacs


# List of Mac Apps
See homebrew_cask_packages in `package_mac.yml`.
