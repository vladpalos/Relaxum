--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

local M = {}

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local LAYERS = {}						-- Stack of rendering layers

local viewport = nil
local world = nil						-- This refers only to box2d World

local cameraMoving = nil
local cameraFixed = nil

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------

-- Initialization ----------------------------------------------------------------------------------

function M.init()

	MOAISim.setStep( 1 / DISPLAY_FPS )
--	MOAISim.clearLoopFlags()
--	MOAISim.setLoopFlags( MOAISim.SIM_LOOP_ALLOW_BOOST )
--	MOAISim.setLoopFlags( MOAISim.SIM_LOOP_LONG_DELAY )
--	MOAISim.setBoostThreshold( 0 )

	MOAISim.openWindow( APP_TITLE, DEVICE_WIDTH, DEVICE_HEIGHT )

	viewport = MOAIViewport.new()
	viewport:setSize( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )
	viewport:setScale( SCREEN_UNITS_X, SCREEN_UNITS_Y )

	cameraMoving = MOAICamera2D.new()
	cameraFixed = MOAICamera2D.new()

	MOAIRenderMgr.setRenderTable( LAYERS )

	effects.addShaker( display.getCamera( CAMERA_MOVING ) )

	resources.loadFont("assets/fonts/Righteous-Regular.ttf", "f1")
end

function M.initPhysics()
	world = MOAIBox2DWorld.new()
    world:setGravity( GRAVITY_X, GRAVITY_Y )
    world:setUnitsToMeters( 1 / 10 )
    world:start()

    --world:setIterations( 1 / DISPLAY_FPS, 1 / DISPLAY_FPS  )
    if DEBUG then
    	world:setDebugDrawEnabled(true)
    end
end

-- Sets the moving camera to follow a prop (the player for instance)
function M.setAnchor( prop, mw, mh )

	-- Setting up camera fitter / tracker
	local fitter = MOAICameraFitter2D.new()
	fitter:setViewport( M.getViewport() )
	fitter:setCamera( M.getCamera( CAMERA_MOVING ) )
	--fitter:setBounds( -800, -480, 800, 480 )

	fitter:setBounds( - mw / 2, - mh / 2, mw / 2, mh / 2 )
	fitter:setMin( SCREEN_HEIGHT )
	fitter:setDamper( 0.5 )

	M.getCamera( CAMERA_MOVING )

	local anchor = MOAICameraAnchor2D.new()
	anchor:setParent( prop )
	anchor:setRect( -1, -1, 1, 1 )

	fitter:insertAnchor( anchor )
	fitter:start()

end


-- Basic graphic objects ---------------------------------------------------------------------------

function M.newLayer( cameraId, zIndex )

	local layer = MOAILayer2D.new()
	local partition = MOAIPartition.new()

	layer.zIndex = zIndex or 1

	layer:setViewport( viewport )
	layer:setPartition( partition )

	if cameraId and cameraId == CAMERA_MOVING then
		layer:setCamera( cameraMoving )
	else
		layer:setCamera( cameraFixed )
	end

	table.insert( LAYERS, layer )

	-- Sort rendering table by zIndex
	--  We use an optimized bubble sort since
	--  we need a stable sorting algorithm and
	--  we don't care about performance here.
	--  Lua's table.sort is not stable.

	local i, j
	local swapped, aux

	repeat
		swapped = false
		for i = 2, #LAYERS do
			if LAYERS[i - 1].zIndex > LAYERS[i].zIndex then
				LAYERS[i], LAYERS[i - 1] = LAYERS[i - 1], LAYERS[i]
				swapped = true
			end
		end
	until swapped == false

	--[[
	table.sort( LAYERS, function( a , b ) return a.zIndex < b.zIndex end )
	for k,v in ipairs(LAYERS) do print(k, v.zIndex) end
	--]]

	return layer
end

function M.getLayerByName( name )
	for _, layer in ipairs( LAYERS ) do
		if layer and layer.name == name then
			return layer
		end
	end
	warn('Could not find layer ' .. name .. ' !')
end

function M.newSpanAnimation( prop, keyDuration, mode, ease, property, ... )

	local curve = MOAIAnimCurve.new()

	curve:reserveKeys( #arg )

	for i = 1, #arg do
		curve:setKey( i, (i - 1) * keyDuration, arg[i], ease )
	end

	local anim = MOAIAnim:new()
	anim:reserveLinks( 1 )
	anim:setLink( 1, curve, prop, property )
	anim:setMode( mode )

	return anim
end


function M.repeatAnimAttr( prop, attr, from, to, time, ease )

	local ease = ease or MOAIEaseType.LINEAR
	local curve = MOAIAnimCurve.new()
	time = time or 10

	curve:reserveKeys( 2 )
	curve:setKey( 1, 0, from, ease )
	curve:setKey( 2, time, to, MOAIEaseType.FLAT )

	local anim = MOAIAnim:new()
	anim:reserveLinks( 1 )
	anim:setLink( 1, curve, prop, attr )
	anim:setMode( MOAITimer.LOOP )

	return anim
end

--  Primitives -------------------------------------------------------------------------------------

function M.newDrawing( layer, x, y, w, h, drawFunc )

	local scriptDeck = MOAIScriptDeck.new()

	local px, py = w * .5, h * .5
	scriptDeck:setRect( -px, -py, px, py )

	scriptDeck:setDrawCallback( drawFunc )

	local prop = MOAIProp2D.new()
	prop:setDeck( scriptDeck )
	prop:setLoc( x, y )
	layer:insertProp( prop )

--	prop:setBlendMode( MOAIProp2D.GL_SRC_ALPHA, MOAIProp2D.GL_ONE_MINUS_SRC_ALPHA )

	return prop, scriptDeck
end

-- Graphics ----------------------------------------------------------------------------------------

function M.clearBackground( r, g, b, a )

	if MOAIGfxDevice.getFrameBuffer then
		-- This does not work in 1.3 but it works in 1.4
		MOAIGfxDevice:getFrameBuffer():setClearColor( r, g, b, a )
	else

		layer = display.newLayer( CAMERA_MOVING,  -9999 )
		local _mw, _mh = map.getHalfDims()
		display.newDrawing( layer, 0, 0, _mw * 2, _mh * 2, function( index, xOff, yOff, xFlip, yFlip )
				MOAIGfxDevice.setPenColor( r, g, b, a )
				MOAIDraw.fillRect( -_mw, -_mh, _mw, _mh )
		end )
	end
end

function M.setAlpha( prop, a )
	prop:setColor( 1 / a, 1 / a, 1 / a, a )
end


function M.newLinearGradientRect( layer, x1, y1, x2, y2, c )

    local vertexFormat = MOAIVertexFormat.new()

    -- Moai's default shaders expect loc, uv, color
    vertexFormat:declareCoord( 1, MOAIVertexFormat.GL_FLOAT, 2 )
    vertexFormat:declareColor( 2, MOAIVertexFormat.GL_UNSIGNED_BYTE )

    local vbo = MOAIVertexBuffer.new()

    vbo:setFormat( vertexFormat )
    vbo:reserveVerts( 4 )

    vbo:writeFloat( x1, y1 )
    vbo:writeColor32( c[1][1], c[1][2], c[1][3] )

    vbo:writeFloat( x2, y1 )
    vbo:writeColor32( c[2][1], c[2][2], c[2][3] )

    vbo:writeFloat( x2, y2 )
    vbo:writeColor32( c[3][1], c[3][2], c[3][3] )

    vbo:writeFloat( x1, y2 )
    vbo:writeColor32( c[4][1], c[4][2], c[4][3] )

    vbo:bless()

    local mesh = MOAIMesh.new()
    mesh:setVertexBuffer( vbo )
    mesh:setPrimType( MOAIMesh.GL_TRIANGLE_FAN )

    if MOAIGfxDevice.isProgrammable () then
        local shader = MOAIShader.new( )

        shader:reserveUniforms( 1 )
        shader:declareUniform( 1, 'transform', MOAIShader.UNIFORM_WORLD_VIEW_PROJ )

        shader:setVertexAttribute( 1, 'position' )
        shader:setVertexAttribute( 2, 'color' )

        shader:load( resources.loadShaderFiles( 'assets/shaders/gradient' ) )
        mesh:setShader( shader )
    end

    prop = MOAIProp2D.new()
    prop:setDeck( mesh )
    layer:insertProp( prop )
end

-- Physics -----------------------------------------------------------------------------------------

function M.addBody( type, x, y, rot )
    
    local body = world:addBody( type, x, y )
    body:setTransform( x, y, rot )
	
    return body

end


----------------------------------------------------------------------------------------------------
-- Getters / Setters
----------------------------------------------------------------------------------------------------

function M.getViewport()

	return viewport
end

function M.getCamera( id )

	if id and id == CAMERA_MOVING then return cameraMoving
	else return cameraFixed end
end

function M.getAllLayers()
	return LAYERS
end

function M.getWorld()
	return world
end


-- Clean -------------------------------------------------------------------------------------------

function M.deleteProps ( layer, props ) 
    if props ~= nil then
        if type( props ) == 'table' then
            for i, prop in ipairs( props ) do
                layer:removeProp( prop )
                props[i] = nil
            end
        else
            layer:removeProp( props )
        end
    end
end



----------------------------------------------------------------------------------------------------
return M