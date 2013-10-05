--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--==================================================================================================

module(..., package.seeall)

-- This table is sent to MOAIRenderManager 
layerTable = {}

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function onLoad()

	mainLayer = display.newLayer()
	local background = display.newImage("assets/images/menu/mm_background.png", mainLayer, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	table.insert(layerTable, mainLayer)
end

function onFocus()
	input.setInputLayer(mainLayer)
end

function onBlur()
end

function onDelete()	
end

---------------------------------------------------------------------------------------------------
return M
