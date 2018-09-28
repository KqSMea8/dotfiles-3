#!/usr/bin/env bash

set -e

e_header()   { echo -e "\n\033[1m$@\033[0m"; }
e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

DOTHOME="$(dirname "$(cd "$(dirname "$0")" && pwd -P)")"

install() {
    link_dotfiles
    link_karabinar
}

link_dotfiles() {
    e_header "Linking files into home directory..."

    for file in `find . -name '.*' -type f`; do
        local base="$(basename $file)"
        local dest="$HOME/$base"
        ln -sf "$DOTHOME/$base" $dest
        e_success $dest
    done
}

link_karabinar() {
    mkdir -p ~/.config/
    ln -sf "$DOTHOME/karabiner" ~/.config/
    e_success "$HOME/.config/karabiner"
    # https://pqrs.org/osx/karabiner/document.html#configuration-file-path
    launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
}

install