function fish_prompt
    set -g fish_prompt_pwd_dir_length 4
    set -l lastStatus $status

    set -l nWhite (set_color white)
    set -l nBlue (set_color blue)
    set -l bRed (set_color -o red)
    set -l nCyan (set_color cyan)
    set -l nYellow (set_color yellow)

    # new line
	echo -s "$nWhite"

    # user
    if test ! -z "$SSH_CLIENT"
        echo -sn "$nBlue$USER$nCyan@$nWhite" (hostname)
    else
        echo -sn "$nBlue$USER"
    end

    # separator
    echo -sn "$nYellow • $nWhite"

    # current directory
    if test (pwd) = "$HOME/.pwendok"
        echo -sn "$bRed" "pwendok" "$nWhite"
    else
        echo -sn "$nCyan" (prompt_pwd) "$nWhite"
    end

    # invite
    echo -s ""
    if test "$lastStatus" -eq 0
        if test (id -u "$USER") -eq 0
            echo -sn "$bRed»"
        else
            echo -sn "$nBlue›"
        end
    else
        echo -sn "$bRed⌦"
    end

    echo -s "$nWhite "
end
