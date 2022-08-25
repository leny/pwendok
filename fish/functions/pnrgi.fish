function pnrgi --description 'clean node_modules and pnpm lockfile, then pnpm install'
	rm -rf ./node_modules
    rm ./pnpm-lock.yaml
    pnpm install $argv
end
