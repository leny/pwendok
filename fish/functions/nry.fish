function nry --description 'clean node_modules and yarn install'
	rm -rf ./node_modules
yarn install $argv
end
