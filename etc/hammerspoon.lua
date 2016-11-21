-- Hammerspoon init script

-- Reload config when changes
function reloadConfig( files )
    for _, file in pairs( files ) do
        if file:sub( -4 ) == ".lua" then
            hs.reload()
            return
        end
    end
end
hs.pathwatcher.new( os.getenv( "HOME" ) .. "/.pwendok/etc/", reloadConfig ):start()

