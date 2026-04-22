function gcsm --description 'git commit (unsigned) with message'
	git commit --no-gpg-sign -m $argv
end
