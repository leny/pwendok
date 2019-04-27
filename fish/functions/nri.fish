function nri --description 'clean node_modules & reinstall dependencies'
	rm -rf ./node_modules
    npm install $argv
end
