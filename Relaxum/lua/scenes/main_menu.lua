--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
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
	local background = resources.newSprite("diamond", M.layer, 0, 0 )

end

function M.onDelete()

end

function M.onTouchEvent( eventType, idx, x, y, tap )

    if (eventType == 2) then
        --director.push("scenes/main_menu_pop", "fade", 0.5 )
        director.swap("scenes/worlds", "fade", "fade", 0.5, 0.5 )
    end
end


---------------------------------------------------------------------------------------------------
return M
