-- Window Relocator
aModifiers = { "ctrl", "alt" }
sTrigger = "x"
iTriggerCode = hs.keycodes.map[ sTrigger ]
sInvite = "🤖"
oModalStyles = {
    strokeColor = { alpha = 0 },
    textSize = 144
}
oActions = {
    [ 18 ] = function( oWindow, oFrame ) oWindow:move( { 0, 0, oFrame.w / 3, oFrame.h } ) end, -- & (first tier)
    [ 19 ] = function( oWindow, oFrame ) oWindow:move( { oFrame.w / 3, 0, oFrame.w / 3, oFrame.h } ) end, -- é (second tier)
    [ 20 ] = function( oWindow, oFrame ) oWindow:move( { oFrame.w * 2 / 3, 0, oFrame.w / 3, oFrame.h } ) end, -- " (third tier)
    [ 21 ] = function( oWindow, oFrame ) oWindow:move( { 0, 0, oFrame.w * 2 / 3, oFrame.h } ) end, -- ' (two tiers, left)
    [ 23 ] = function( oWindow, oFrame ) oWindow:move( { oFrame.w / 3, 0, oFrame.w * 2 / 3, oFrame.h } ) end, -- ( (two tiers, left)
    [ 49 ] = function( oWindow ) oWindow:maximize() end, -- space
    [ 53 ] = function() print( "escape!" ) end,
}

oKeyCollector = hs.eventtap.new( { hs.eventtap.event.types.keyDown }, function( oEvent )
    local iCode = oEvent:getKeyCode()
    local fAction = oActions[ iCode ]
    local oWindow = hs.window.focusedWindow()

    oKeyCollector:stop()
    hs.alert.closeAll()

    if fAction and type( fAction ) == "function" then
        fAction( oWindow, oWindow:screen():frame() )
    else
        print( "No action for \"" .. oEvent:getCharacters() .. "\" (keyCode: " .. iCode .. ")" )
    end

    return false
end )

hs.hotkey.bind( aModifiers, sTrigger, function()
    print( "Open Window Relocator" )
    hs.alert.show( sInvite, oModalStyles, hs.screen.mainScreen(), 3600 )
    oKeyCollector:start()
end )

-- Redimension functions
