function invim --description 'Inline vim editor in tmux popup'
    tmux popup -E -w 45% -h 65% -T "Inline nvim: $argv" -d '#{pane_current_path}' "nvim $argv"
end
