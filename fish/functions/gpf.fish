function gpf --description 'git push --force-with-lease --force-if-includes'
	git push --follow-tags --force-with-lease --force-if-includes $argv
end
