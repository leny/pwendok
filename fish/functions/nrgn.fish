function nrgn --description 'regen package-lock.json'
	rm -rf node_modules package-lock.json && npm install
end
