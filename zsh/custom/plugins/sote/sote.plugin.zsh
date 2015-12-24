# Adapted for zsh from krkn/sote

SOTE_STORE="$HOME/.sote-store"

sote() {

    local version=0.2
    local store="$SOTE_STORE"

    # reset colors

    local NONE=$reset_color

    # regular colors

    local K="$fg_no_bold[black]"
    local R="$fg_no_bold[red]"
    local G="$fg_no_bold[green]"
    local Y="$fg_no_bold[yellow]"
    local B="$fg_no_bold[blue]"
    local M="$fg_no_bold[magenta]"
    local C="$fg_no_bold[cyan]"
    local W="$fg_no_bold[white]"

    # emphasized (bolded) colors

    local EMK="$fg_bold[black]"
    local EMR="$fg_bold[red]"
    local EMG="$fg_bold[green]"
    local EMY="$fg_bold[yellow]"
    local EMB="$fg_bold[blue]"
    local EMM="$fg_bold[magenta]"
    local EMC="$fg_bold[cyan]"
    local EMW="$fg_bold[white]"

    # usage text

    local usage="
    ${EMY}Usage: ${W}sote ${G}[options] ${C}<name>

        ${W}Jumps to the path corresponding to the given name.

    ${EMG}Options:

        ${G}-h, --help                   ${W}Output usage information
        ${G}-v, --version                ${W}Output the version number
        ${G}-l, --list                   ${W}Lists the paths stored by sote.
        ${G}-s, --show ${B}<name>            ${W}Shows the path corresponding to the given name.
        ${G}-a, --add ${B}<name> ${Y}[path]      ${W}Add the path to the store with the given name. If no path is given, use current path.
        ${G}-r, --remove ${B}<name>          ${W}Remove the path stored by sote at the given name.
        ${G}-c, --clear                  ${W}Clear all the paths stored by sote. Ask for confirmation before acting.
    "

    # check for store file

    if [[ ! -f $store ]] then
        echo "" > $store
    fi

    # show help if no args

    if [[ $# == 0 ]] then
        echo "$usage${NONE}"
        return;
    fi

    # commands

    action=$1
    name=$2
    dest_path=$3

    case "$action" in
        "-v"|"--version")
            echo -e "${Y}sote ${W}v$version${NONE}"
            return;
            ;;
        "-h"|"--help")
            echo -e "$usage${NONE}"
            return;
            ;;
        "--completion-keys")
            for i in $(git config --file $store --list) ; do
                i=${i//store./}
                i=${i//=*/}

                echo "$i"
            done
            return;
            ;;
        "--completion-options-short")
            echo "v"
            echo "h"
            echo "l"
            echo "s"
            echo "a"
            echo "r"
            echo "c"
            return;
            ;;
        "--completion-options-long")
            echo "version"
            echo "help"
            echo "list"
            echo "show"
            echo "add"
            echo "remove"
            echo "clear"
            return;
            ;;
        "-l"|"--list")
            for i in $(git config --file $store --list) ; do
                i=${i//store./$C}
                i=${i//=/ ${Y}› ${NONE}}

                echo -e "$i"
            done
            return;
            ;;
        "-s"|"--show")
            dest_path=$( git config --file $store --get "store.$name" )
            if [[ "$dest_path" != "" ]] then
                echo -e "${C}$name ${Y}› ${NONE}$dest_path${NONE}"
            else
                echo -e "${EMR}error: ${NONE}no entry for ${C}$name${NONE}"
            fi
            return;
            ;;
        "-a"|"--add")
            if [[ ! $dest_path ]] then
                dest_path=$PWD
            else
                dest_path=$(cd $dest_path; pwd)
            fi
            git config --file $store --replace-all "store.$name" $dest_path
            echo -e "${EMY}added: ${C}$name ${Y}› ${NONE}$dest_path${NONE}"
            return;
            ;;
        "-r"|"--remove")
            git config --file $store --unset-all "store.$name"
            echo -e "${EMY}removed: ${C}$name${NONE}"
            return;
            ;;
        "-c"|"--clear")
            read -k 1 "CONFIRM?Are you sure you want clear all your SOTE entries [Yn] ? "
            if [[ $CONFIRM =~ '^[Yy]$' ]] then
                echo "" > $store
                echo -e "\n${EMY}cleared${NONE}"
            fi
            return;
            ;;
        *)
            dest_path=$( git config --file $store --get "store.$action" )
            if [ "$dest_path" != "" ]
            then
                cd $dest_path
            else
                echo -e "${EMR}error: ${NONE}no entry for ${C}$action${NONE}"
            fi
            return;
            ;;
    esac

}

_sote_complete() {
    local word="$words[2]"

    if [[ $CURRENT -eq 2 ]] then
        if [[ "${word:0:1}" == "-" ]] then
            if [[ "${word:0:2}" == "--" ]] then
                compadd -P "--" "$@" $(sote --completion-options-long)
            else
                compadd -P "-" "$@" $(sote --completion-options-short)
            fi
        else
            compadd "$@" $(sote --completion-keys)
        fi
    else
        local action="$words[2]"
        if [[ $CURRENT -eq 3 ]] then
            case "$action" in
                "-s"|"--show"|"-r"|"--remove"|"-a"|"--add")
                    compadd "$@" $(sote --completion-keys)
                    ;;
            esac
        fi
    fi
}

compdef _sote_complete sote
