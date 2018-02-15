function cleands --description 'Clean .DS_Store files'
	find . -type f -name '*.DS_Store' -ls -delete
end
