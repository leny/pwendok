# -- Functions

# Create a new directory and enter it
mkd() { mkdir -p "$@" && cd "$@"; }

# Checks whether a website is down for you, or everybody
down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'; }

# gclone : clone a github repo by passing the user/repo tuple
gclone() { git clone https://github.com/$1 $2; }
