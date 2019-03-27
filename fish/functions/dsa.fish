function dsa --description 'alias for docker stop (all)'
    docker stop (docker ps -aq)
end
