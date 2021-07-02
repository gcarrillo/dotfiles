#!/bin/sh

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Install various dotfiles
$DOTFILES_ROOT/script/bootstrap

# Download git prompt and git completion scripts, and update ~/.bashrc to use them
wget --quiet --no-clobber https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O $HOME/git-prompt.sh
wget --quiet --no-clobber https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $HOME/git-completion.bash

(
cat <<'EOF'

. $HOME/git-completion.bash

. $HOME/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)")\$ '
PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\n$ '
EOF
) >> $HOME/.bashrc
