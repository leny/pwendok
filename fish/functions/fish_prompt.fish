function fish_prompt
    set -g fish_prompt_pwd_dir_length 2
    set -l lastStatus $status

    set -l resetColor (set_color normal)
    set -l nWhite (set_color white)
    set -l nBlue (set_color blue)
    set -l nRed (set_color red)
    set -l bRed (set_color --bold red)
    set -l nCyan (set_color cyan)
    set -l bCyan (set_color --bold cyan)
    set -l nYellow (set_color yellow)
    set -l bYellow (set_color --bold yellow)
    set -l nMagenta (set_color magenta)
    set -l bMagenta (set_color --bold magenta)
    set -l nGreen (set_color green)
    set -l bGreen (set_color --bold green)

    # last command duration
    if test $CMD_DURATION
        set -l timer (math -s0 "$CMD_DURATION / 1000")
        if test $timer -ge 3600
            set -l timerHours (math -s0 "$timer / 3600")
            set -l timerRemain (math -s0 "$timer % 3600")
            set -l timerMinutes (math -s0 "$timerRemain / 60")
            set -l timerSeconds (math -s0 "$timerRemain % 60")
            echo -s "$resetColor" "$nMagenta" "◴ duration: " "$bRed" "$timerHours" "h " "$timerMinutes" "m " "$timerSeconds" "s " "$resetColor"
        else if test $timer -ge 60
            set -l timerMinutes (math -s0 "$timer / 60")
            set -l timerSeconds (math -s0 "$timer % 60")
            echo -s "$resetColor" "$nMagenta" "◴ duration: " "$bYellow" "$timerMinutes" "m " "$timerSeconds" "s " "$resetColor"
        else if test $timer -ge 5
            echo -s "$resetColor" "$nMagenta" "◴ duration: " "$nGreen" "$timer" "s " "$resetColor"
        end
    end

    # new line
	echo -s "$nWhite"

    # user
    set -l userStyle "$nBlue"
    if test (id -u "$USER")
        set -l userStyle "$bRed"
    end
    if test ! -z "$SSH_CLIENT"
        echo -sn "$userStyle$USER$nCyan@$nWhite" (hostname)
    else
        echo -sn "$userStyle$USER"
    end

    # separator
    echo -sn "$nYellow • $nWhite"

    # current directory
    if set -l match (string match -r "^$GOPATH\/src\/github\.com\/([^\/]+)\/([^\/]+)\/(.+)\$" (pwd))
        echo -sn "$bRed" "go" "$nYellow" ":" "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor" "$nYellow" ":" "$nCyan" (string replace "~/Wo/go/sr/gi/"(string sub -l 2 $match[2])"/"(string sub -l 2 $match[3])"/" "" (prompt_pwd))
    else if set -l match (string match -r "^$GOPATH\/src\/github\.com\/([^\/]+)\/(.+)\$" (pwd))
        echo -sn "$bRed" "go" "$nYellow" ":" "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor"
    else if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\/([^\/]+)\/(.+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor" "$nYellow" ":" "$nCyan" (string replace "~/Wo/"(string sub -l 2 $match[2])"/"(string sub -l 2 $match[3])"/" "" (prompt_pwd))
    else if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\/([^\/]+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$nWhite" "/" "$bCyan" "$match[3]" "$resetColor"
    else if set -l match (string match -r "^$HOME\/Works\/([^\/]+)\$" (pwd))
        echo -sn "$nMagenta" "$match[2]" "$resetColor"
    else if test (pwd) = "$HOME/.pwendok"
        echo -sn "$bRed" "pwendok" "$nWhite"
    else
        echo -sn "$nCyan" (prompt_pwd) "$nWhite"
    end

    # git status
    if command git rev-parse --git-dir > /dev/null ^ /dev/null
        echo -sn "$resetColor" "$nYellow" " ԍ " "$bMagenta"

        # git branch / tag
        set -l gitBranch (command git symbolic-ref --short HEAD ^ /dev/null)

        if test -z "$gitBranch"
            set -l gitTag (command git describe --tags --exact-match HEAD ^ /dev/null)

            if test -z "$gitTag"
                command git rev-parse --short HEAD ^ /dev/null
            else
                echo -sn "$gitTag" "$resetColor "
            end
        else
            echo -sn "$gitBranch" "$resetColor "
        end

        # git status
        # - local status
        set -l gitLocalStatus (git status --porcelain ^ /dev/null)
        if test -n "$gitLocalStatus"
            # -- untracked files
            set -l gitLocalQQ (echo "$gitLocalStatus" | grep -E '^\?\? ' ^ /dev/null)
            if test -n "$gitLocalQQ"
                echo -sn "$nWhite" "+ " "$resetColor"
            end
            # -- added files
            set -l gitLocalAE (echo "$gitLocalStatus" | grep -E '^A  ' ^ /dev/null)
            set -l gitLocalME (echo "$gitLocalStatus" | grep -E '^M  ' ^ /dev/null)
            if test -n "$gitLocalAE"
                echo -sn "$nYellow" "* " "$resetColor"
            else if test -n "$gitLocalME"
                echo -sn "$nYellow" "* " "$resetColor"
            end
            # -- modified
            set -l gitLocalEM (echo "$gitLocalStatus" | grep -E '^ M ' ^ /dev/null)
            set -l gitLocalAM (echo "$gitLocalStatus" | grep -E '^AM ' ^ /dev/null)
            set -l gitLocalMM (echo "$gitLocalStatus" | grep -E '^MM ' ^ /dev/null)
            set -l gitLocalET (echo "$gitLocalStatus" | grep -E '^ T ' ^ /dev/null)
            if test -n "$gitLocalEM"
                echo -sn "$nWhite" "* " "$resetColor"
            else if test -n "$gitLocalAM"
                echo -sn "$nWhite" "* " "$resetColor"
            else if test -n "$gitLocalMM"
                echo -sn "$nWhite" "* " "$resetColor"
            else if test -n "$gitLocalET"
                echo -sn "$nWhite" "* " "$resetColor"
            end
            # -- renamed
            set -l gitLocalRE (echo "$gitLocalStatus" | grep -E '^R  ' ^ /dev/null)
            if test -n "$gitLocalRE"
                echo -sn "$nYellow" "r " "$resetColor"
            end
            # -- deleted
            set -l gitLocalED (echo "$gitLocalStatus" | grep -E '^ D ' ^ /dev/null)
            set -l gitLocalDE (echo "$gitLocalStatus" | grep -E '^D  ' ^ /dev/null)
            set -l gitLocalAD (echo "$gitLocalStatus" | grep -E '^AD ' ^ /dev/null)
            if test -n "$gitLocalED"
                echo -sn "$nRed" "- " "$resetColor"
            else if test -n "$gitLocalDE"
                echo -sn "$nRed" "- " "$resetColor"
            else if test -n "$gitLocalAD"
                echo -sn "$nRed" "- " "$resetColor"
            end
        else
            # -- clean
            echo -sn "$bGreen" "✓ " "$resetColor"
        end
        # - remote status
        set -l gitAhead (git status -b ^ /dev/null | grep '^## .*ahead' ^ /dev/null)
        if test -n "$gitAhead"
            echo -sn "$bCyan" "↑ " "$resetColor"
        end
        set -l gitBehind (git status -b ^ /dev/null | grep '^## .*behind' ^ /dev/null)
        if test -n "$gitBehind"
            echo -sn "$bRed" "↓ " "$resetColor"
        end

        echo -sn "$resetColor"
    end

    # invite
    echo -s "$resetColor"
    if test "$lastStatus" -eq 0
        if test (id -u "$USER") -eq 0
            echo -sn "$userStyle»"
        else
            echo -sn "$userStyle›"
        end
    else
        echo -sn "$bRed⌦"
    end

    echo -s "$resetColor "
end
