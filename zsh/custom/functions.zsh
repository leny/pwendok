# -- Functions

# Create a new directory and enter it
mkd() { mkdir -p "$@" && cd "$@"; }

# Jump to a directory and list its content
cdl() { cd "$@" && l; }

# Checks whether a website is down for you, or everybody
down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'; }

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
