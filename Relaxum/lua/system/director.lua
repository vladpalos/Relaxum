--=================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local busy 		= false

local sceneStack = {}

---------------------------------------------------------------------------------------------------
-- Global functions
---------------------------------------------------------------------------------------------------

function M.push( filename, anim, duration, ease )

	if busy == true then
		return
	else
		busy = true
	end

	-- Load the new scene
	local curScene = require( filename )
	curScene._filename = filename

	table.insert( sceneStack, curScene )

	if type( curScene.onLoad ) == "function" then
		curScene:onLoad()
	end

	-- Animations ----------------------------------------------------------------------------------
	if anim and curScene.layer then
		if anim == "fade" then
			curScene.layer:setColor( 0, 0, 0, 0 )
			curScene.layer:seekColor( 1, 1, 1, 1, duration, ease )
		end
	end

	-- Clear ---------------------------------------------------------------------------------------
	if anim and duration then
		-- Restores Input CB
		utils.setTimeout( function()
			input.setCB( curScene.onTouchEvent )
			busy = false
		end, duration )
	else
		input.setCB( curScene.onTouchEvent )
		busy = false
	end

end

function M.pop( anim, duration, ease )

	if busy == true then
		return
	else
		busy = true
	end

	curScene = sceneStack[#sceneStack]

	if type( curScene.onDelete ) == "function" then
		curScene:onDelete()
	end

	table.remove( sceneStack, #sceneStack )

	-- Animations ----------------------------------------------------------------------------------
	if anim and curScene.layer then
		if anim == "fade" then
			curScene.layer:setColor( 1, 1, 1, 1 )
			curScene.layer:seekColor( 0, 0, 0, 0, duration, ease )
		end
	end

	-- Clear ---------------------------------------------------------------------------------------
	if anim and duration then
		-- Restores Input CB
		utils.setTimeout( function()
			if #sceneStack > 0 then
				local c = sceneStack[#sceneStack] and sceneStack[#sceneStack].onTouchEvent
				input.setCB( c )
			end

			curScene.layer:clear()

			display.removeLayer( curScene.layer )
			utils.unrequire( curScene._filename )
			busy = false
		end, duration + 0.1 )
	else
		if #sceneStack > 0 then
			local c = sceneStack[#sceneStack] and sceneStack[#sceneStack].onTouchEvent
			input.setCB( c )
		end
		curScene.layer:clear()
		display.removeLayer( curScene.layer )
		utils.unrequire( curScene._filename )
		MOAISim.forceGarbageCollection()
		busy = false
	end
end

function M.swap( filename, animPop, animPush, durationPop, durationPush)
	if busy then
		return
	end

	M.pop( animPop, durationPop )

	if animPop then -- Let the first animation finish
		utils.setTimeout( function()
			busy = false
			M.push( filename, animPush, durationPush)
		end, durationPop )
	end
end


---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getSceneStack( )

	return sceneStack
end

---------------------------------------------------------------------------------------------------
return M