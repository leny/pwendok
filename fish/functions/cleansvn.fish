function cleansvn --description 'clean .svn folders'
	find ./ -name '.svn' | xargs rm -Rf
end
