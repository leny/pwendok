function incodex --description 'Inline codex in tmux popup'
    tmux popup -E -w 65% -h 65% -T "Inline codex" -d '#{pane_current_path}' 'codex'
end
