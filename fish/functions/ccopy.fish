function ccopy --description 'copy the content of the file in the clipboard'
    /usr/local/opt/coreutils/libexec/gnubin/cat $argv > /usr/bin/pbcopy
end
