function nversion --description 'npm version --no-git-tag-version'
	npm version --no-git-tag-version -m "Bump %s" $argv
end
