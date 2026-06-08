# Completion for: git keep [<folder-path>]
complete -c git -n '__fish_git_needs_command' -a keep -d 'Créer un fichier .gitkeep dans un dossier'
complete -c git -n '__fish_git_using_command keep' -F -d 'Dossier cible'
