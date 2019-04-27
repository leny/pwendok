function nrgi --description 'clean node_modules and npm lockfile, then npm install'
	rm -rf ./node_modules
    rm ./package-lock.json
    npm install $argv
end
