PS1="$(tput setaf 2)\u@\h$(tput setaf 15):$(tput setaf 4)~$(tput setaf 15)$ "

alias scr="scrot"
alias ls="exa -1l"

run () {
    nix run nixpkgs#"$1"
}
