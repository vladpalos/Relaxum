--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--==================================================================================================

module(..., package.seeall)

----------------------------------------------------------------------------------------------------
-- Global variables
----------------------------------------------------------------------------------------------------

-- This table is sent to MOAIRenderManager 
layerTable = {}

----------------------------------------------------------------------------------------------------
-- Local variables
----------------------------------------------------------------------------------------------------
local menuLayer	

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function onLoad()
	-- Create Layers
	menuLayer = display.newLayer()

	local temp = display.newImage("assets/images/shape6.png", menuLayer, 0, 0, 200, 200)

	table.insert(layerTable, menuLayer)
end


function onFocus()	
end

function onBlur()
end

function onDelete()	
end


----------------------------------------------------------------------------------------------------
-- Event functions
----------------------------------------------------------------------------------------------------

__DOWN = false
__MOUSEX = 0
__MOUSEY = 0

function onTouchEvent(eventType, idx, x, y, tap)
	if eventType == _EV_DOWN then director.pop("slideLeft") end
end


function onMouseLeftEvent(down)
	
	__DOWN = false
	if down then 
		__DOWN = true
		onTouchEvent(_EV_DOWN, nil, __MOUSEX, __MOUSEY)
	else 
		onTouchEvent(_EV_UP, nil, __MOUSEX, __MOUSEY)
	end
end

function onPointerEvent(x, y)

	__MOUSEX = x
	__MOUSEY = y

	if __DOWN then 		
		onTouchEvent(_EV_MOVE, nil, x, y)
	end
end

---------------------------------------------------------------------------------------------------
return M
