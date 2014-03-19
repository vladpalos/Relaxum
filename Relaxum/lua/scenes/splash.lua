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

local timer

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function M.onLoad()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    M.layer = display.newLayer( CAMERA_FIXED )
    local logo = resources.newSprite("moon", M.layer, 0, 0 )

    timer = utils.setTimeout( function ()
        director.swap("scenes/main_menu", "fade", "fade", 1, 1)
    end, 3 )

end

function M.onDelete()
    --resources.unloadSpriteSheet( "assets/sheets/tiles_background" )
    -- REMOVE IT AFTERWARDS
end

function M.onTouchEvent( eventType, idx, x, y, tap )

    if (eventType == 2) then
        timer:stop()
        --director.push("scenes/main_menu_pop", "fade", 0.5 )
        director.swap("scenes/main_menu", "fade", "fade", 1, 1)
    end
end


---------------------------------------------------------------------------------------------------
return M
