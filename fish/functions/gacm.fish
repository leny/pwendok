function gacm --description 'git add --all & commit with message'
	git add --all
	git commit -m $argv
end
