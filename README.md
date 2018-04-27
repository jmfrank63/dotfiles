# Repo for my dotfiles
Contains dotfiles for:
vim
bash
tern
git

To install the repo clone it to a repository of your choice.
I personally prefer .dotfiles

### vim
Assumed the directory is ~/.dotfiles and you are located in your home directory:
For vundle with (almost) no external dependencies:
ln -s ~/.dotfiles/vim/.vimrc_nodep .vimrc

For vundle with external dependencies:
ln -s ~/.dotfiles/vim/.vimrc_dep .vimrc

To initialize for vim do:
cd .dotfiles
git submodule init
git submodule update
cd ~

Start vim:
vim
From within vim issue:
:PluginInstall

### bash
The files for bash are in ~/.dotfiles/bash
You can source them directly or include them in your .bashrc or .profile
Their names should tell you what they are for :-)

### tern
A preconfigured project file for the javascript code completion

### git
Sometime some configfiles for git are always the same. You will find them here

