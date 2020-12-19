#!/usr/bin/env bash

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cargo install ripgrep broot lsd hunter dust fd-find bat bottom hyperfine sd tokei viu
