function pnri --description 'clean node_modules & reinstall dependencies'
	rm -rf ./node_modules
    pnpm install $argv
end
