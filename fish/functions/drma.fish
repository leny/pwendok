function drma --description 'alias for docker remove (all)'
    docker rm (docker ps -aq)
end
