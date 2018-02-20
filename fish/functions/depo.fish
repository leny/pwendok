function depo -d "try to change directory to github repo, with user/repo, from the WORKS_PATH"
    cd $WORKS_PATH/$argv[1]
end

function __depo
    for orga in (ls $WORKS_PATH)
        for repo in (ls $WORKS_PATH/$orga)
            echo "$orga/$repo"
        end
    end
end

complete -x -c depo -a "(__depo)"
