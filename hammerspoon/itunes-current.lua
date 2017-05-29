-- iTunes current track

aModifiers = { "ctrl", "alt" }
sTrigger = "i"
oModalStyles = {
    strokeColor = { alpha = 0 },
    textSize = 32
}
iTimeout = 1

hs.hotkey.bind( aModifiers, sTrigger, function()
    if ( hs.itunes.isRunning() and hs.itunes.isPlaying() ) then
        sCurrentTrack = "🎵 " .. hs.itunes.getCurrentArtist() .. " - " .. hs.itunes.getCurrentTrack() .. "\n" .. hs.itunes.getCurrentAlbum()
    else
        sCurrentTrack = "🎵 No track is playing!"
    end
    hs.alert.show( sCurrentTrack, oModalStyles, hs.screen.mainScreen(), iTimeout )
end )
