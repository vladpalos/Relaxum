--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

--
--	This is the main level workflow logic.
-- 	From here the correspondent level file is loaded (e.g.: level/level2.lua)
--

local M = {}

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local objectsType = {}
local liveObjects = 0

local levelLogic, layer

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------


function M.init()		
	layer = display.newLayer( CAMERA_MOVING )

end

function M.load()
	levelLogic = dofile( 'levels/level' .. player.getLevel() .. '.lua' )
	levelLogic.init()
end

function M.go()
	levelLogic.go()
end

-- Loads a single object or a list of objects.
function M.loadObjects( name )

	if type( name ) == 'string' then
		if objectsType[name] == nil then
			objectsType[name] = dofile( 'objects/' .. name .. '.lua' )
			objectsType[name].load()
		end

	elseif type( name ) == 'table' then
		for _, name in ipairs( name ) do
			if objectsType[name] == nil then
				objectsType[name] = dofile( 'objects/' .. name .. '.lua' )
				objectsType[name].load()
			end
		end
	end
end

-- Adds a single object
function M.addObject( conf )
	M.checkData( conf )
	objectsType[conf.type].add( conf )
	M.addLiveObject()
end

-- Adds random uniform distributed object from array
function M.addRandomObject( array )
	local index = math.random( #array )
	M.checkData( array[index] )

	local type = array[index].type
	objectsType[type].add( array[index] )
	M.addLiveObject()
end

-- 	 Adds random number with pow distribution.
--   If pow is high and > 1, the FIRST array objects have a better chance to be picked.
-- 	 If pow is LOW AND between 0 and 1, the LAST array objects have a better chance to be picked.
--   If pow is 1 then you have a uniform distribution.
function M.addRandomPowObject( pow, array )
	local index = math.floor( 1 + ( #array - 1 ) * math.random() ^ pow )
	M.checkData( array[index] )
	
	local type = array[index].type
	M[type].add( array[index] )
	M.addLiveObject()
end


-- Checks if object data is ok. It checks only on debug mode
function M.checkData( obj )

	if not DEBUG then
		return
	end

	local hw, hh = map.getHalfDims()

	if not obj.type then
		error("Could not create object. Please set a type first!")
	end

	if objectsType[obj.type] == nil then
		error("There is no " .. obj.type .. " object type loaded. Please load it first!")
	end
end

function M.clean()

end

---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getLayer()
	return layer
end

function M.getLiveObjects()
	return liveObjects
end

function M.addLiveObject( )
	liveObjects = liveObjects + 1
end

function M.removeLiveObject( )
	liveObjects = liveObjects - 1
end

----------------------------------------------------------------------------------------------------
return M
