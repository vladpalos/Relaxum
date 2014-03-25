--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local layer

-- Main --------------------------------------------------------------------------------------------

function M.init()
    layer = display.newLayer( CAMERA_FIXED, 1000 )
end


-- Text --------------------------------------------------------------------------------------------

-- The style are as follows:
--[[
    For normal-bold use         <b>...</>
    For normal-italic use       <i>...</>
    For normal-bold-italic use  <bi>...</>

    For small-bold use          <sb>...</>
    For small-italic use        <si>...</>
    For small-bold-italic use   <sbi>...</>

    For large-bold use          <lb>...</>
    For large-italic use        <li>...</>
    For large-bold-italic use   <lbi>...</>
--]]

function M.newTextBox( text, x, y, w, h, r, g, b, a, font )

    local textbox = MOAITextBox.new()

    if font == nil then
        font = DEFAULT_FONT
    end

    textbox:setStyle( resources.getFont( font, "medium" ) )
    textbox:setStyle( "b", resources.getFont( font .. "-bold", "medium" ) )
    textbox:setStyle( "i", resources.getFont( font .. "-italic", "medium" ) )
    textbox:setStyle( "bi", resources.getFont( font .. "-bold-italic", "medium" ) )

    textbox:setStyle( "s", resources.getFont( font, "small" ) )
    textbox:setStyle( "sb", resources.getFont( font .. "-bold", "small" ) )
    textbox:setStyle( "si", resources.getFont( font .. "-italic", "small" ) )
    textbox:setStyle( "sbi", resources.getFont( font .. "-bold-italic", "small" ) )

    textbox:setStyle( "l", resources.getFont( font, "large" ) )
    textbox:setStyle( "lb", resources.getFont( font .. "-bold", "large" ) )
    textbox:setStyle( "li", resources.getFont( font .. "-italic", "large" ) )
    textbox:setStyle( "lbi", resources.getFont( font .. "-bold-italic", "large" ) )

    textbox:setString(text)

    local sx, sy = w * .5, h * .5
    textbox:setRect( -sx, -sy, sx, sy )

    textbox:setAlignment( MOAITextBox.LEFT_JUSTIFY,
                          MOAITextBox.LEFT_JUSTIFY )

    if r and g and b and a then textbox:setColor( r, g, b, a ) end

    textbox:setLoc( x, y )
    textbox:setYFlip( true )

    return textbox
end




-- Text addons / effects ---------------------------------------------------------------------------
function M.addShortAnimText( text, x, y, w, h, speed, r, g, b, a, font )

    local animText = M.newTextBox( text, x, y, w, h, r, g, b, a, font)

    animText:setAlignment( MOAITextBox.CENTER_JUSTIFY,
                           MOAITextBox.CENTER_JUSTIFY )

    --animText:moveLoc( 100, 0, speed, MOAIEaseType.EASE_IN )
    animText:moveLoc( 0, 150, speed, MOAIEaseType.LINEAR  )
    animText:moveScl( 0.2, 0.2, speed, MOAIEaseType.LINEAR )
    animText:seekColor( 1, 1, 1, 0, speed * 1.5, MOAIEaseType.EASE_OUT )

    return animText
end
----------------------------------------------------------------------------------------------------
function M.animPopUp ( w, h, r, g, b, a )


    function onDraw ( index, xOff, yOff, xFlip, yFlip )
        MOAIGfxDevice.setPenColor ( r, g, b, a )
        MOAIDraw.fillRect ( -w / 2, -h / 2, w / 2, h / 2 )

        MOAIDraw.fillRect ( -w / 2 + 5, -h / 2 + 5, w / 2 - 5, h / 2 - 5)
    end

    local scriptDeck = MOAIScriptDeck.new ()
    scriptDeck:setRect ( -w / 2, -h / 2, w / 2, h / 2 )
    scriptDeck:setDrawCallback ( onDraw )

    local prop = MOAIProp2D.new ()
    prop:setDeck ( scriptDeck )
    prop:setBlendMode( MOAIProp2D.BLEND_NORMAL )

    layer:insertProp( prop )

    prop:setLoc( 0, -500 )
    prop:seekLoc( 0, 0, 1, EASE_OUT )

    utils.setTimeout( function()
        display.newSpanAnimation( prop, 1, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_Y_LOC,
                              -5, 5, -5) :start()

        display.newSpanAnimation( prop, 1.2, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_X_LOC,
                              -5, 5, -5) :start()

        display.newSpanAnimation( prop, 2, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_Z_ROT,
                              -1, 1, -1) :start()
    end, 1 )

    return prop
end


----------------------------------------------------------------------------------------------------
function M.getLayer()
    return layer
end


----------------------------------------------------------------------------------------------------
return M