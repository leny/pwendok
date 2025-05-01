function tinit -d "init a tmux session for given project"
    set session $argv[1]

    if tmux has-session -t $session 2>/dev/null
        echo "Session $session already exists"
        return 1
    end

    # Calling fish at the end to ensure the window will still stay open if we quit nvim
    tmux new-session -s $session -d -n editors "cd $WORKS_PATH/$session ; nvim . ; fish"

    set window 2
    tmux new-window -d -t $session:$window -n operations "cd $WORKS_PATH/$session ; nvm use || true ; git pull || true ; clear ; fish"
    set window operations
    tmux split-window -d -t $session:$window -l 75% -h "cd $WORKS_PATH/$session ; nvm use || true ; clear ; fish"
end

function __tinit
    for orga in (ls $WORKS_PATH)
        for repo in (ls $WORKS_PATH/$orga)
            echo "$orga/$repo"
        end
    end
end

complete -x -c tinit -a "(__tinit)"
