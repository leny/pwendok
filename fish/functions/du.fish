function du --wraps ncdu --description 'Alias for ncdu, which wraps du to provide extra functionality to cat.'
    ncdu --color dark -rr --exclude .git --exclude node_modules $argv
end

