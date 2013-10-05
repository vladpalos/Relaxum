--=================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local curScene = nil
local oldScene = nil

local sceneStack = {}

---------------------------------------------------------------------------------------------------
-- Global functions
---------------------------------------------------------------------------------------------------

function M.push( filename )	
	-- Clears Input
	input.setCB()

	-- Load the new scene
	curScene = require( filename )
	curScene._filename = filename

	table.insert( sceneStack, curScene )

	if type( curScene.onLoad ) == "function" then 
		curScene:onLoad()
	end	
end

function M.pop()
	table.remove( sceneStack, #sceneStack - 1 )
end

function M.swap( filename ) 
	pop()
	push( filename )
end


---------------------------------------------------------------------------------------------------
-- Getters 
---------------------------------------------------------------------------------------------------

function M.getSceneStack( )
	
	return sceneStack
end
	
---------------------------------------------------------------------------------------------------
return M