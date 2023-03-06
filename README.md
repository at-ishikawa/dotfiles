# Getting Started
1. Run `make prepare`. This will fail on the step to download a fisher on ansible currently
1. Run `make install`. This will fail to clone anyenv repository
1. Create a private key and public key for GitHub. And upload the public key on GitHub.
1. Add a password of the private key into ssh agent
1. Run `make install` again


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


## List of Mac Apps
See homebrew_cask_packages in `package_mac.yml`.
