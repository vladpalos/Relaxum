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

local levelLogic, layer, timeLine, timeCurve

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------


function M.init()
	layer = display.newLayer( CAMERA_MOVING )

	timeLine = MOAITimer.new()
    timeLine:setMode( MOAITimer.NORMAL )
 	timeCurve = MOAIAnimCurve.new()
end

function M.load()
	levelLogic = dofile( 'levels/level' .. player.getLevel() .. '.lua' )
	levelLogic.init()
end

function M.go()
	levelLogic.go()
end

-- Loads a single object or a list of objects.
function M.loadObjects( objType )

	if type( objType ) == 'string' then
		if objectsType[objType] == nil then
			objectsType[objType] = dofile( 'objects/' .. objType .. '.lua' )
			objectsType[objType].load()
		end

	elseif type( objType ) == 'table' then
		for _, objType in ipairs( objType ) do
			if objectsType[objType] == nil then
				objectsType[objType] = dofile( 'objects/' .. objType .. '.lua' )
				objectsType[objType].load()
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

function M.addTimedRandomObjects( count, list, low, high )
	timeCurve:reserveKeys( count )

	if not low and not high then
	    for i = 1, count do
	    	M.addRandomObject( list )
	    end
	else
		local t = 0
	    for i = 1, count do
	        t = t + math.random()
	        timeCurve:setKey( i, t, 0, MOAIEaseType.FLAT )
	    end

	    timeLine:setCurve( timeCurve )
	    timeLine:setListener( MOAITimer.EVENT_TIMER_KEYFRAME,
	    	function ( timeLine, keyframe, executed, keytime, value )
	            M.addRandomObject( list )
	        end )

	    timeLine:setSpan( timeCurve:getLength() + 0.1 )
	    timeLine:start()

		while timeLine:isBusy() do coroutine:yield() end
	end

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

function M.waitAll()
	while M.getLiveObjects() do coroutine:yield() end
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
