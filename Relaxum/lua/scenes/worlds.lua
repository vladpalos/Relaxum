--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

----------------------------------------------------------------------------------------------------
-- Local variables
----------------------------------------------------------------------------------------------------

M.layer = nil

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function M.onLoad()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    M.layer = display.newLayer( CAMERA_FIXED )
    local left = resources.newSprite("box1", M.layer, -200, 0 )
    local right = resources.newSprite("box1", M.layer, 100, 0 )

end

function M.onDelete()

end

function M.onTouchEvent( eventType, idx, x, y, tap )

    print(eventType, idx, x, y, tap)
    if (eventType == 2) then
        --director.push("scenes/main_menu_pop", "fade", 0.5 )
        director.swap("scenes/game_scene", "fade", "nothing", 0.5, 1)
    end
end


---------------------------------------------------------------------------------------------------
return M
