--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

local M = {}

-- Text --------------------------------------------------------------------------------------------

-- The size parameter is a list of avalible sizes (ex: {"small", "medium", "large"})
function M.newTextBox( text, font, size, layer, x, y, w, h, r, g, b, a )
    
    local textbox = MOAITextBox.new()

    textbox:setStyle( resources.getFont( font, size ) )
    textbox:setStyle( resources.getFont( font, size ) )

    textbox:setString(text)
    
    local sx, sy = w * .5, h * .5   
    textbox:setRect( -sx, -sy, sx, sy ) 

    textbox:setAlignment( MOAITextBox.LEFT_JUSTIFY,
                          MOAITextBox.LEFT_JUSTIFY )
        
    if r and g and b and a then textbox:setColor( r, g, b, a ) end

    textbox:setLoc( x, y )
    textbox:setYFlip( true )

    layer:insertProp( textbox ) 
    return textbox
end


----------------------------------------------------------------------------------------------------
return M