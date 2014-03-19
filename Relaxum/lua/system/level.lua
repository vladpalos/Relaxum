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

local objectsType 		= {}
local levelSetup	 	= {}

local liveObjects 		= 0

local levelLogic, layer, timeLine, timeCurve, levelThread



----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------


function M.load()
	levelLogic = dofile( 'levels/level_logic_' .. player.getLevel() .. '.lua' )
end

function M.init()
	layer = display.newLayer( CAMERA_MOVING )

	timeLine = MOAITimer.new()
    timeLine:setMode( MOAITimer.NORMAL )
 	timeCurve = MOAIAnimCurve.new()

	levelSetup = levelLogic.init()
end

function M.go()

	-- Main level thread
    levelThread = MOAICoroutine.new()
    levelThread:run( function()
    	levelLogic.goTimeLine()
    end )

    -- Check status thread

    MOAICoroutine.new():run( function()

 		while not M.checkWin() and not M.checkLose() do
			coroutine:yield()
		end

		timeLine:stop()
		levelThread:stop()

		if M.checkWin() then
			M.doWin()
		elseif M.checkLose() then
			M.doLose()
		end

    end )
end

----------------------------------------------------------------------------------------------------

function M.checkWin()
	return player.getObjectsCount() >= levelSetup.targetCount
end

function M.checkLose()
	return ( not levelThread:isBusy() and (M.getLiveObjects() == 0) )
end

function M.doWin()
    print("You Won")
end

function M.doLose()
    print("You Lost")
end

----------------------------------------------------------------------------------------------------

-- Loads a list of objects from object conf.
-- You need to pass only the object configurations with type parameter set to object name.
function M.loadObjects( confs )
	local conf
	for _, conf in ipairs( confs ) do
		if not conf.type then
			error("When loading objects, please set the type in configuration passed.")
		else
			if objectsType[conf.type] == nil then
				objectsType[conf.type] = dofile( 'objects/' .. conf.type .. '.lua' )
				objectsType[conf.type].load()
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


--[[
	Dinamically adds random objects on screen.
		count: number of objects
		list: list of objects configurations from which to choose.
		minDelay: min delay between object spawning
		maxDelay: max delay between object spawning
--]]
function M.addTimedRandomObjects( count, list, minDelay, maxDelay )

	if not minDelay and not maxDelay then
	    for i = 1, count do
	    	M.addRandomObject( list )
	    end
	else
		timeCurve:reserveKeys( count )
		local t = 0
	    for i = 1, count do
	        t = t + math.random( minDelay, maxDelay )
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


-- NOT IN USE, NEEDS REFACTOR
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

function M.getTargetCount()
	return levelSetup.targetCount
end

---------------------------------------------------------------------------------------------------
-- Setters
---------------------------------------------------------------------------------------------------

function M.addLiveObject( )
	liveObjects = liveObjects + 1
end

function M.removeLiveObject( )
	liveObjects = liveObjects - 1
end

----------------------------------------------------------------------------------------------------
return M
