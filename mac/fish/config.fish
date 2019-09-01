function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent
export NVM_DIR="$HOME/.nvm"

set -g fish_user_paths /Users/johannes/.pyenv/plugins/pyenv-virtualenv/shims /Users/johannes/.pyenv/shims /Users/johannes/.pyenv/bin $fish_user_paths

export PYENV_ROOT=/Users/johannes/.pyenv
export PYENV_SHELL=fish
export PYENV_VIRTUALENV_INIT=1
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
pyenv init - | source
pyenv virtualenv-init - | source

alias vim=nvim
alias vi=nvim
