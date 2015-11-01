# depo : try to change directory to github repo, with user/repo, from the WORKS_PATH

depo() { eval cd "${WORKS_PATH}/${1}"; }

_depo() {
    local word="$words[2]"
    local base_path="$WORKS_PATH"
    if [[ $word =~ '/' ]] then
        if [[ "${word#${word%?}}" == "/" ]] then
            base_path="$WORKS_PATH/$word"
            compadd -P "$word" "$@" $(eval ls $base_path)
        else
            base_path="$WORKS_PATH/$(dirname $word)"
            compadd -P "$(dirname $word)/" "$@" $(eval ls $base_path)
        fi
    else
        compadd -S / "$@" $(eval ls $base_path)
    fi
}

compdef _depo depo
