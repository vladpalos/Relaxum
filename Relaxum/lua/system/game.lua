--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

local M = {}
-- Actions -------------

----------------------------------------------------------------------------------------------------
-- CONSTANTS
----------------------------------------------------------------------------------------------------

local NOIMAGE				= "noimage.png"

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local actionRoot = nil

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------

-- Initialization ----------------------------------------------------------------------------------
function M.go()
	player.loadData()
	map.load( "assets/maps/level1" )
	level.load()

	level.init()
	map.init()
	player.init()
	hud.init()

	level.go()

    --[[ DEBUG ]]--
	if DEBUG > 1 then
		player.getLayer():setBox2DWorld(display.getWorld())
	end
end

function M.unloadLevel()
end


-- Main control functions --------------------------------------------------------------------------

function M.pause()
	actionRoot = MOAIActionMgr.getRoot()
	MOAIActionMgr.setRoot()
end

function M.resume()
	if actionRoot then MOAIActionMgr.setRoot( actionRoot ) end
	actionRoot = nil

	input.setCB( onTouchEvent )
end

function M.gameOver()
	addMainText( "You lose!" )
	player.destroy()
end

-- Background --------------------------------------------------------------------------------------

function M.setBackground( r, g, b, a )

	local layer = display.newLayer( CAMERA_MOVING , -101 )
--	display.clearBackground( r, g, b, a )

---[[
  local colors = { {0.666666667, 0.690196078, 1.0},
                   {0.666666667, 0.690196078, 1.0},
                   {0.152941176, 0.235294118, 0.631372549},
                   {0.152941176, 0.235294118, 0.631372549} }
--]]
--[[
    local colors = { {0, 0, 0},
                     {0, 0, 0},
                     {0.022941176, 0.115294118, 0.511372549},
                     {0.022941176, 0.115294118, 0.511372549} }
--]]
	local HW, HH = map.getDims()
	HW, HH = HW / 2, HH / 2

    display.newLinearGradientRect( layer, -HW, -HH, HW, HH, colors )

	resources.loadSpriteSheet('assets/sheets/objects_sheet_1')

--[[
    local prop = resources.newSprite( 'moon', layer, 350, 200 )
]]--
	effects.addCloud( layer, 'cloud_1', 100, 200, 40 )
	effects.addCloud( layer, 'cloud_4', -300, 100, 80 )
	effects.addCloud( layer, 'cloud_3', 0, 0, 70 )
	effects.addCloud( layer, 'cloud_2', 100, -200, 20 )


end


-- Actions -----------------------------------------------------------------------------------------

-- Deprecated, Not used
function M.attackRect( x1, y1, x2, y2 ) -- Not sure
	local propList = { GAME_LAYER_PARTITION:propListForRect( x1, y1, x2, y2 ) }

	if propList == nil or #propList == 0 then return end
	for _, prop in ipairs( propList ) do
		if prop.ob and prop.ob.exists then
			objects.destroyObject( prop.ob )
		end
	end
end


-- Events ------------------------------------------------------------------------------------------

local anim = nil
function M.onTouchEvent( eventType, idx, x, y, tap )
	x, y = player.getLayer():wndToWorld( x, y )

	if eventType == INPUT_DOWN then
		local guiProp = hud.getPartition()
		if guiProp and guiProp._type == "button" then
			if type( guiProp.onPress ) == "function" then guiProp:onPress( x, y ) end
		else
			player.aim( x, y )
		end
	elseif eventType == INPUT_UP then
		player.moveAnimated( x, y )
		-- player.move( x, y )
	else
		player.aim( x, y )
	end

end

----------------------------------------------------------------------------------------------------
return M

