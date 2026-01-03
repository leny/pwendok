function inclaude --description 'Inline claude in tmux popup'
    tmux popup -E -w 65% -h 65% -T "Inline claude" -d '#{pane_current_path}' 'claude'
end
