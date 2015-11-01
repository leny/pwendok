# -- aliases

alias c="clear"
alias q="exit"

# --- navigation
alias ...="cd ~-"

# --- utils
alias cleansvn="find ./ -name '.svn' | xargs rm -Rf"
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"

# --- vagrant
alias vup="vagrant up"
alias vdestroy="vagrant destroy --force"
alias vssh="vagrant ssh"
alias vdeploy="vagrant destroy --force && vagrant up && vagrant ssh"
alias vreload="vagrant up && vagrant ssh"
alias vhalt="vagrant halt"
alias vgstatus="vagrant global-status"
alias vstatus="vagrant status"

# --- npm
# european mirror
alias enpm="npm --registry registry.npmjs.eu"
alias ni="npm install"
alias npmi="npm install"
alias nri="rm -rf ./node_modules && npm install"
alias npmri="rm -rf ./node_modules && npm install"
alias nis="npm install --save"
alias npmis="npm install --save"
alias nisd="npm install --save-dev"
alias npmisd="npm install --save-dev"
alias nig="npm install -g"
alias npmig="npm install -g"
alias npmo="npm outdated --depth=0"

# --- tower
alias tower="gittower ."

# --- docker & Boot2Docker
alias dcompose="docker-compose"
alias dmachine="docker-machine"
alias dockup="docker-machine env dev && eval '\$(docker-machine env dev)'"
