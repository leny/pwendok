function tinit -d "init a tmux session for given project"
    set session $argv[1]

    tmux new -s $session -d

    set window 1
    tmux rename-window -t $session:$window editors
    set window editors
    tmux send-keys -t $session:$window "cd $WORKS_PATH/$session" Enter
    tmux send-keys -t $session:$window "nvim ." Enter

    set window 2
    tmux new-window -t $session:$window -n operations
    set window operations
    tmux send-keys -t $session:$window "cd $WORKS_PATH/$session" Enter
    tmux send-keys -t $session:$window "clear" Enter
    tmux split-window -t $session:$window -h
    tmux resize-pane -t $session:$window -L 60
    tmux send-keys -t $session:$window.right "cd $WORKS_PATH/$session" Enter
    tmux send-keys -t $session:$window.right "clear" Enter
end

function __tinit
    for orga in (ls $WORKS_PATH)
        for repo in (ls $WORKS_PATH/$orga)
            echo "$orga/$repo"
        end
    end
end

complete -x -c tinit -a "(__tinit)"
