--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

local M = {}

M.layer = nil

---------------------------------------------------------------------------------------------------
-- Local variables
----------------------------------------------------------------------------------------------------

local actionRoot = nil

---------------------------------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------------------------------

local levels = {}

levels[1] = {

    goal        = 5,
    timeLimit   = 0,

    map         = "assets/maps/level1",
}


----------------------------------------------------------------------------------------------------
-- Basic functions
----------------------------------------------------------------------------------------------------

function M.onLoad()

	game.go()

    M.layer = display.newLayer( CAMERA_FIXED, 99999 )

    local prop = display.newDrawing( M.layer, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT,
                     function ( index, xOff, yOff, xFlip, yFlip )

                        --MOAIGfxDevice.setPenColor ( 0, 0, 0, 1 )
                        MOAIDraw.fillRect ( -MAX_X, -MAX_Y, MAX_X, MAX_Y )

                     end )

    prop:setColor( 0, 0, 0, 1 )
    prop:seekColor( 0, 0, 0, 0, 2 )
    utils.setTimeout( function()
        M.layer:clear()
        display.removeLayer( M.layer )
        M.layer = nil
    end, 2 )
	--collectgarbage( "stop" )
end

M.onTouchEvent = game.onTouchEvent

function M.onDelete()

	player.deinit()
end

---------------------------------------------------------------------------------------------------
return M
