--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Local variables
----------------------------------------------------------------------------------------------------

M.layer = nil

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function M.onLoad()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    M.layer = display.newLayer( CAMERA_FIXED )
    local background = resources.newSprite("lamp_1", M.layer, 0, 0 )

end

function M.onDelete()
end

function M.onTouchEvent( eventType, idx, x, y, tap )

    print(eventType, idx, x, y, tap, "fine, I'm out" )
    if (eventType == 0 ) then
        M.layer:moveLoc( -400, 0, 1, EASE_IN )
        director.pop( "fade", 1, EASE_IN )
    end
end


---------------------------------------------------------------------------------------------------
return M
