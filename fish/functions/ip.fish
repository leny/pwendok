function ip --description 'Get current IP'
	dig +short myip.opendns.com @resolver1.opendns.com
end
