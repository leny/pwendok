# -- reload
alias dotreload="source ~/.zshrc"

# -- aliases
alias c="clear"
alias q="exit"
alias cdc="cd && clear"
alias l="k -hA --si"
alias ll="ls -lAFh"
alias week='date +%V'

# --- navigation
alias ...="cd -"

# --- redo last command with sudo
alias fuck="sudo \$(fc -ln -1)"

# --- utils
alias cleansvn="find ./ -name '.svn' | xargs rm -Rf"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"

# --- ps
alias psa="ps aux"
alias psg="ps aux | grep "

# --- dutils
alias df='df -h'
alias du='du -h -d 2'

# --- python
alias python="python3"
alias pip="pip3"

# --- miscs
alias ydl="youtube-dl"
alias ydlp="youtube-dl --yes-playlist -f '(mp4)[height>=720]'"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

# --- parallelized zip libs
alias gzip="pigz"
alias bzip2="pbzip2"
alias lzip="plzip"

# --- npm
alias ni="npm install"
alias nid="npm install --only=dev"
alias nip="npm install --only=prod"
alias nri="rm -rf ./node_modules && npm install"
alias nis="npm install --save"
alias nisd="npm install --save-dev"
alias nig="npm install -g"
alias npmo="npm outdated --depth=0"
alias nity="npm init -y"
alias nit="npm init"
alias ncc="npm cache clear"
# ----- yarn
alias ny="yarn install"
alias nya="yarn add"
alias nys="yarn add"
alias nyad="yarn add --dev"
alias nysd="yarn add --dev"
alias nyp="yarn install --production"
alias nry="rm -rf ./node_modules && yarn install"
alias nyt="yarn init"
alias nyty="yarn init"

# --- tower
alias tower="gittower ."

# --- vagrant
alias vup="vagrant up"
alias vdestroy="vagrant destroy --force"
alias vssh="vagrant ssh"
alias vdeploy="vagrant destroy --force && vagrant up && vagrant ssh"
alias vreload="vagrant up && vagrant ssh"
alias vhalt="vagrant halt"
alias vgstatus="vagrant global-status"
alias vstatus="vagrant status"

# --- docker & Boot2Docker
alias dcompose="docker-compose"
alias dmachine="docker-machine"
alias dstop="docker stop \$(docker ps -q)"
alias dclean="docker stop \$(docker ps -a -q) && docker rm \$(docker ps -a -q)"
alias dcb="docker-compose build"
alias dcu="docker-compose up -d"
alias dcl="docker-compose logs -f"
alias dcs="docker-compose stop"
alias dcr="docker-compose run"
alias dcrm="docker-compose rm -f"
alias dvl="docker volume ls"
alias dvrm="docker volume rm"

# --- git (overrides from oh-my-zsh/git - )
alias gcm="git commit -m"
alias gs="git status -sb"
alias gitinit="git init"
alias gi="git init"
alias gap="git add -p"
alias gds="git diff --staged"
alias cdg="cd \$(git rev-parse --show-toplevel)"

# --- brew
alias burp="brew update && brew upgrade && brew cleanup"
alias cask="brew cask"

# --- Transmission
alias transmission="transmission-remote"

# --- IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# --- OSX GUI Restart (sometime my OS graphics freeze, this helps)
alias gfxreload="sudo killall SystemUIServer"

# --- OSX Sleep
alias goodnight="pmset displaysleepnow && pmset sleepnow"

# --- Gource
alias pyebwa="gource --hide dirnames,progress,filenames -r 60 --seconds-per-day 0.25 --auto-skip-seconds 1 -1600x1000 -multi-sampling --title"

# --- vim
alias o="mvim ."
