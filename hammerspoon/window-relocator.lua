-- Window Relocator
aModifiers = { "ctrl", "alt" }
sTrigger = "x"
iTriggerCode = hs.keycodes.map[ sTrigger ]
sInvite = "🍱"
iTimeout = 3
oModalStyles = {
    strokeColor = { alpha = 0 },
    textSize = 144
}
oActions = {
    -- 1/3
    [ 18 ] = function( oWindow ) oWindow:move( { 0, 0, 1 / 3, 1 } ) end, -- &|1 (first 1/3)
    [ 19 ] = function( oWindow ) oWindow:move( { 1 / 3, 0, 1 / 3, 1 } ) end, -- é|2 (second 1/3)
    [ 20 ] = function( oWindow ) oWindow:move( { 2 / 3, 0, 1 / 3, 1 } ) end, -- "|3 (third 1/3)
    -- 2/3
    [ 21 ] = function( oWindow ) oWindow:move( { 0, 0, 2 / 3, 1 } ) end, -- '|4 (2/3, left)
    [ 23 ] = function( oWindow ) oWindow:move( { 1 / 3, 0, 2 / 3, 1 } ) end, -- (|5 (2/3, left)
    -- 5/6
    [ 22 ] = function( oWindow ) oWindow:move( { 0, 0, 5 / 6, 1 } ) end, -- §|6 (5/6, left)
    [ 26 ] = function( oWindow ) oWindow:move( { 1 / 6, 0, 5 / 6, 1 } ) end, -- è|7 (5/6, right)
    -- 1/2
    [ 126 ] = function( oWindow ) oWindow:move( { 0, 0, 1, 0.5 } ) end, -- arrow up
    [ 125 ] = function( oWindow ) oWindow:move( { 0, 0.5, 1, 0.5 } ) end, -- arrow down
    [ 123 ] = function( oWindow ) oWindow:move( { 0, 0, 0.5, 1 } ) end, -- arrow left
    [ 124 ] = function( oWindow ) oWindow:move( { 0.5, 0, 0.5, 1 } ) end, -- arrow right
    -- full screen
    [ 48 ] = function( oWindow, oWindowFrame, oScreen, oScreenFrame ) oWindow:move( { ( oScreenFrame.w - oWindowFrame.w ) / 2, ( oScreenFrame.h - oWindowFrame.h ) / 2, oWindowFrame.w, oWindowFrame.h } ) end, -- tab (move to center)
    [ 49 ] = function( oWindow ) oWindow:maximize() end, -- space
    [ 36 ] = function( oWindow ) oWindow:move( { 1 / 5, 1 / 8, 3 / 5, 6 / 8 } ) end, -- enter
    -- change screen
    [ 33 ] = function( oWindow ) oWindow:moveOneScreenWest() end, -- ^ (move to left screen)
    [ 30 ] = function( oWindow ) oWindow:moveOneScreenEast() end, -- $ (move to right screen)
    -- moving around, using vim keys
    [ 4 ] = function( oWindow, oWindowFrame, oScreen, oScreenFrame ) oWindow:move( { oScreenFrame.x, oWindowFrame.y, oWindowFrame.w, oWindowFrame.h } ) end, -- h (move left)
    [ 37 ] = function( oWindow, oWindowFrame, oScreen, oScreenFrame ) oWindow:move( { oScreenFrame.w - oWindowFrame.w + oScreenFrame.x, oWindowFrame.y, oWindowFrame.w, oWindowFrame.h } ) end, -- l (move right)
    [ 38 ] = function( oWindow, oWindowFrame, oScreen, oScreenFrame ) oWindow:move( { oWindowFrame.x, oScreenFrame.h - oWindowFrame.h, oWindowFrame.w, oWindowFrame.h } ) end, -- j (move down)
    [ 40 ] = function( oWindow, oWindowFrame, oScreen, oScreenFrame ) oWindow:move( { oWindowFrame.x, 0, oWindowFrame.w, oWindowFrame.h } ) end, -- k (move up)
}

oKeyCollector = hs.eventtap.new( { hs.eventtap.event.types.keyDown }, function( oEvent )
    local iCode = oEvent:getKeyCode()
    local fAction = oActions[ iCode ]
    local oWindow = hs.window.focusedWindow()

    oKeyCollector:stop()
    hs.alert.closeAll()

    if fAction and type( fAction ) == "function" then
        fAction( oWindow, oWindow:frame(), oWindow:screen(), oWindow:screen():frame() )
    else
        print( "-- window relocator: no action for \"" .. oEvent:getCharacters() .. "\" (keyCode: " .. iCode .. ")" )
    end

    return true
end )

hs.hotkey.bind( aModifiers, sTrigger, function()
    hs.alert.show( sInvite, oModalStyles, hs.screen.mainScreen(), iTimeout )
    oKeyCollector:start()
    hs.timer.doAfter( iTimeout, function()
        oKeyCollector:stop()
    end )
end )
