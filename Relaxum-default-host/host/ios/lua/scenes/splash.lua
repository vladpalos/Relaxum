--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--==================================================================================================

local M = {}

-- This table is sent to MOAIRenderManager 
local layerTable = {}

----------------------------------------------------------------------------------------------------
-- Base functions
----------------------------------------------------------------------------------------------------

function M.onLoad()

	mainLayer = display.newLayer()
	table.insert(layerTable, mainLayer)	

	local logo = display.newImage("assets/images/logo.png", mainLayer, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
	logo.onPress = function (self, x, y) 
		director.swap('scenes/MainMenu')
	end

end

function M.onFocus()
	input.setInputLayer(mainLayer)
end

function M.onBlur()	
end

function M.onDelete()	
	--graphicsMgr.releaseAll()
end

---------------------------------------------------------------------------------------------------
return M


