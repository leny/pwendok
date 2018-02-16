function fish_prompt
    set -g fish_prompt_pwd_dir_length 2
    set -l lastStatus $status

    set -l resetColor (set_color normal)
    set -l nWhite (set_color white)
    set -l nBlue (set_color blue)
    set -l bRed (set_color -o red)
    set -l nCyan (set_color cyan)
    set -l bCyan (set_color --bold cyan)
    set -l nYellow (set_color yellow)
    set -l nMagenta (set_color magenta)

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
    if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\/([^\/]+)\/(.+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor" "$nYellow" ":" "$nCyan" "$match[4]"
    else if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\/([^\/]+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor"
    else if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$resetColor"
    else if test (pwd) = "$HOME/.pwendok"
        echo -sn "$bRed" "pwendok" "$nWhite"
    else
        echo -sn "$nCyan" (prompt_pwd) "$nWhite"
    end

    # invite
    echo -s "$resetColor"
    if test "$lastStatus" -eq 0
        if test (id -u "$USER") -eq 0
            echo -sn "$bRed»"
        else
            echo -sn "$nBlue›"
        end
    else
        echo -sn "$bRed⌦"
    end

    echo -s "$resetColor "
end
