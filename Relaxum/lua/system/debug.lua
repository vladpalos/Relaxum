-- ==============================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
-- ==============================================================

local M = {}

---------------------------------------------------------------
-- Globals
----------------------------------------------------------------

local _DEBUG_LAYER = nil
local debugEnabled = false

---------------------------------------------------------------
-- Memory
----------------------------------------------------------------

local lastMemCheck = {
	sysMem = 0
}

local function checkMem( say )

	collectgarbage()
	local sysMem = collectgarbage( "count" ) * .001
	if say == true or lastMemCheck.sysMem ~= sysMem then
		lastMemCheck.sysMem = sysMem
		print( "Mem: " .. math.floor( sysMem * 1000 ) * .001 .. "MB \t" )
	end
end

----------------------------------------------------------------
-- Video/Graphics
----------------------------------------------------------------

local function updateFPS()

	local frames = 0
	local x, y = - SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * 0.1


	infoBox = gui.newTextBox( "", x, y, 250, 140, 1, 1, 1, 0.7 )

	_DEBUG_LAYER:insertProp( infoBox )

	while true do
		coroutine.yield()
		frames = frames + 1
		if frames % 10 == 0 then
			infoBox:setString( string.format( "fps %d", MOAISim.getPerformance()) )
		end
	end
end

function M.printGraphicsDebug()
	print( "Loaded Textures:" )
--	for k, _ in pairs( GraphicsMgr.getLoadedTextures() ) do
--		print( "["..k.."]" )
--	end
	print( "\n" )
end

----------------------------------------------------------------
-- Debug
----------------------------------------------------------------
function repeatWithDelay( delay, repeats, func, ... )

	local t = MOAITimer.new()
	t:setSpan( delay )

	local repeats = repeats
	--func(unpack(arg))

	t:setMode( MOAITimer.LOOP )
	t:setListener( MOAITimer.EVENT_TIMER_END_SPAN,
		function ()
			func( unpack( arg ) )

			if repeats > 1 then
				repeats = repeats - 1
			else
				t:stop()
				t = nil
			end
	   	end
	)
 	t:start()
 	return t
end

function M.dumpDetails()
	print ("               Display Name : ", MOAIEnvironment.appDisplayName)
	print ("                     App ID : ", MOAIEnvironment.appID)
	print ("                App Version :  ", MOAIEnvironment.appVersion)
	print ("            Cache Directory : ", MOAIEnvironment.cacheDirectory)
	print ("   Carrier ISO Country Code : ", MOAIEnvironment.carrierISOCountryCode)
	print ("Carrier Mobile Country Code : ", MOAIEnvironment.carrierMobileCountryCode)
	print ("Carrier Mobile Network Code : ", MOAIEnvironment.carrierMobileNetworkCode)
	print ("               Carrier Name : ", MOAIEnvironment.carrierName)
	print ("            Connection Type : ", MOAIEnvironment.connectionType)
	print ("               Country Code : ", MOAIEnvironment.countryCode)
	print ("                    CPU ABI : ", MOAIEnvironment.cpuabi)
	print ("               Device Brand : ", MOAIEnvironment.devBrand)
	print ("                Device Name : ", MOAIEnvironment.devName)
	print ("        Device Manufacturer : ", MOAIEnvironment.devManufacturer)
	print ("                Device Mode : ", MOAIEnvironment.devModel)
	print ("            Device Platform : ", MOAIEnvironment.devPlatform)
	print ("             Device Product : ", MOAIEnvironment.devProduct)
	print ("         Document Directory : ", MOAIEnvironment.documentDirectory)
	print ("         iOS Retina Display : ", MOAIEnvironment.iosRetinaDisplay)
	print ("              Language Code : ", MOAIEnvironment.languageCode)
	print ("                   OS Brand : ", MOAIEnvironment.osBrand)
	print ("                 OS Version : ", MOAIEnvironment.osVersion)
	print ("         Resource Directory : ", MOAIEnvironment.resourceDirectory)
	print ("                 Screen DPI : ", MOAIEnvironment.screenDpi)
	print ("              Screen Height : ", MOAIEnvironment.screenHeight)
	print ("               Screen Width : ", MOAIEnvironment.screenWidth)
	print ("                       UDID : ", MOAIEnvironment.udid)
end


function M.enableDebug( delay, level )
	debugEnabled = true
	MOAISim.setHistogramEnabled( true )

	M.dumpDetails()


	_DEBUG_LAYER = display.newLayer( CAMERA_FIXED, 9999 )
--
	local fpsThread = MOAIThread.new()
	fpsThread:run( updateFPS )

--4	repeatWithDelay( 1, 10000, checkMem, false )

	if level and (type(level) == 'number') and level > 2 then
		M.enableDebugLines()
	end

	if delay then
		repeatWithDelay( delay, 5000, debugLoop )
	end
end

function debugLoop()

	print( "---------------------------------------------------------------" )
	print( "LUA LOADED MODULES")
	for k, v in pairs( package.loaded ) do print( k, v ) end
	print( "---------------------------------------------------------------" )
	--printGraphicsDebug()

	print( "REPORTING HISTOGRAM" )
	MOAISim.reportHistogram()

--[[	histogram = MOAISim.getHistogram()
	if histogram then
		print( "GETTING, ITERATING HISTOGRAM" )
		for k, v in pairs( histogram ) do
			io.write( k .. '\t\t\t' )
			colorPrint( '1;32', v )
		end
	end

--]]

	print( "\nCurrent states stack: " )
	for _, v in ipairs( director.getSceneStack() ) do print( v._filename ) end

	print( "\nCurrent rendering layers stack: " )
	local rt = display.getAllLayers()

	utils.print( rt, "Render Table" )

	print( "---------------------------------------------------------------" )
	local memTable = MOAISim.getMemoryUsage()
	print("Memory Usage: \n" )
	for k, v in pairs( memTable ) do
		print( k, v / 1000000 .. 'MB' )
	end
end

function M.enableLeakReport( delay, clearAfter )
--	MOAISim:reportLeaks( clearAfter )
end

function M.enableDebugLines()
	debugEnabled = true
	MOAIDebugLines.setStyle( MOAIDebugLines.PARTITION_CELLS, 2, 0, 0, 1, 1 )
	MOAIDebugLines.setStyle( MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0, 1, 0, 1 )

	MOAIDebugLines.setStyle( MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 1, 0, 0, 1 )

	MOAIDebugLines.setStyle( MOAIDebugLines.TEXT_BOX, 1, 1, 1, 1, 1 )
	MOAIDebugLines.setStyle( MOAIDebugLines.TEXT_BOX_BASELINES, 2, 1, 1, 0, 1 )
	MOAIDebugLines.setStyle( MOAIDebugLines.TEXT_BOX_LAYOUT, 2, 1, 1, 0, 1 )
end

function M.printDebugInfo()
	--checkMem( true )
	debugLoop()
end




function M.isArray( array )
    for k, _ in pairs(array) do
        if type(k) ~= "number" then
            return false
        end
    end
    return true --Found nothing but numbers !
end

---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getDebugLayer ()
	return _DEBUG_LAYER
end

---------------------------------------------------------------
return M

