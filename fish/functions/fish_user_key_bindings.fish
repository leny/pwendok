function fish_user_key_bindings
    # cf. http://lkdjiin.github.io/blog/2017/02/28/fish-completion-puis-execution-en-
	# Ctrl+g (Go!). Like Ctrl+f Enter in one go.
    bind \cg accept-autosuggestion execute

    # cf. https://github.com/fish-shell/fish-shell/issues/5030
    # Ctrl+e - edit current command in editor
    bind \ce edit_command_buffer
end

# fzf_key_bindings
