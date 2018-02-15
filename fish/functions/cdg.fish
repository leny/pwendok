function cdg --description 'cd to current git repo root'
	cd (git rev-parse --show-toplevel)
end
