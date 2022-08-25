function pnci --description 'pnpm ci'
	rm -rf node_modules && pnpm i --frozen-lockfile $argv
end
