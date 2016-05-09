# -- Functions

# Create a new directory and enter it
mkd() { mkdir -p "$@" && cd "$@"; }

# Jump to a directory and list its content
cdl() { cd "$@" && l; }

# gclone : clone a github repo by passing the user/repo tuple
gclone() { git clone https://github.com/$1 $2; }

man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

cat() {
    local out colored
    out=$(/bin/cat $@)
    colored=$(echo $out | pygmentize -f console -g 2>/dev/null)
    [[ -n $colored ]] && echo "$colored" || echo "$out"
}

task() {
    case "$1" in
        "-w"|"--which")
            [[ -e gulpfile.js ]] && echo "gulp"
            [[ -e gulpfile.coffee ]] && echo "gulp"
            [[ -e gruntfile.js ]] && echo "grunt"
            [[ -e gruntfile.coffee ]] && echo "grunt"
            return;
            ;;
    esac

    [[ -e gulpfile.js ]] && gulp $@
    [[ -e gulpfile.coffee ]] && gulp $@
    [[ -e gruntfile.js ]] && grunt $@
    [[ -e gruntfile.coffee ]] && grunt $@
}

dockup() {
    docker-machine env $1
    eval $(docker-machine env $1)
}
