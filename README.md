# at-ishikawa's dotfiles

## Getting Started

### Mac OS / Linux

1. Run `make prepare`. This will fail on the step to download a fisher on ansible currently
1. Run `make install`. This will fail to clone anyenv repository
    - For WSL, pass host_user parameter like `HOST_USER=username make install`

After install, some configurations are required to be set manually

#### 1Password CLI

At first, sign in by CLI by a hand

```shell
op account add --signin --address my.1password.com
```

Then need to install (gh plugin)[https://developer.1password.com/docs/cli/shell-plugins/github/] by hand.

[!WARNING]
This Shell plugin hasn't worked in WSL until [this issue](https://github.com/1Password/shell-plugins/issues/402) is solved.

```shell
op plugin init gh
```

Lastly, set up a [SSH agent](https://developer.1password.com/docs/ssh/agent/) for 1Password CLI.


### Windows Operating System

1. Install [App Installer](https://apps.microsoft.com/detail/9nblggh4nns1?rtc=1&hl=en-us&gl=US#activetab=pivot:overviewtab) for winget CLI
1. Run bootstrap_windows.ps1 to install some packages and WSL
1. Run steps for non windows operating system.


## Development

In order to run `ansible-test`, checkout this repository under ansible_collection path such as `~/.ansible/collections/ansible_collections/$NAMESPACE/$COLLECTION`.
