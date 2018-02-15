function nrgy --description 'clean node_modules and yarn lockfile, then yarn install'
	rm -rf ./node_modules
rm ./yarn.lock
yarn install $argv
end
