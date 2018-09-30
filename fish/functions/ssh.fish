function ssh --wraps ssh
    env TERM=xterm-256color ssh $argv
end
