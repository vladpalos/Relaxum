--=================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------
local DOWN = false
local MX = 0
local MY = 0
local CB = nil

local PARTITIONS = {}	-- Check for prop events on these

---------------------------------------------------------------------------------------------------
-- Private functions
---------------------------------------------------------------------------------------------------

local function _defaultTouchCB( eventType, idx, x, y, tap )
	
	if not PARTITIONS then return end

	x = x - (SCREEN_WIDTH * 0.5)
	y = - y + (SCREEN_HEIGHT * 0.5)
	
	local prop = nil
	for _, partition in ipairs( PARTITIONS ) do
	
		prop = partition:propForPoint( x, y, 0, MOAILayer.SORT_PRIORITY_DESCENDING ) 	 	
		
		if not prop then return end
		
		if eventType == INPUT_MOVE or eventType == INPUT_DOWN then 		
			if type( prop.onPress ) == "function" then prop:onPress( x, y ) end	
			if prop.type == "button" then prop:setButtonOn() end

		elseif eventType == INPUT_UP then 
			if prop.type == "button" then prop:setButtonOff() end
			if type( prop.onRelease ) == "function" then prop:onRelease( x, y ) end
		end
	end
end

local function _mouseLeft( down )

	DOWN = false
	if down then 
		DOWN = true
		CB(INPUT_DOWN, nil, MX, MY)
	else 
		CB(INPUT_UP, nil, MX, MY)
	end
end

local function _mousePointer( x, y )

	MX = x
	MY = y

	if DOWN then 		
		CB( INPUT_MOVE, nil, x, y )
	end	
end

---------------------------------------------------------------------------------------------------
-- Global functions
---------------------------------------------------------------------------------------------------

function M.setCB( func )

	CB = func
	if CB then 
		if MOAIInputMgr.device.pointer then				
			MOAIInputMgr.device.mouseLeft:setCallback( _mouseLeft )
			MOAIInputMgr.device.pointer:setCallback( _mousePointer )
			return 
		end		
		MOAIInputMgr.device.touch:setCallback( CB )
	else
		if MOAIInputMgr.device.pointer then				
			MOAIInputMgr.device.mouseLeft:setCallback( nil )
			MOAIInputMgr.device.pointer:setCallback( nil )
			return 
		end		
		MOAIInputMgr.device.touch:setCallback( nil )
	end
end


-- If no layers are given then all layers are checked!
function M.setDefaultCB( layerTable ) 	

	-- Clear
	for k,_ in ipairs( PARTITIONS ) do
		PARTITIONS[k] = nil
	end

	local layers = layerTable or display.LAYERS

	-- Set
	for _, l in ipairs( layers ) do
		table.insert( PARTITIONS, l:getPartition() )
	end

	setCB( _defaultTouchCB )	
end

----------------------------------------------------------------------------------------------------
return M