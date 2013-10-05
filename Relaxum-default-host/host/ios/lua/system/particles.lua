
--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

local M = {}
M.__index = M

----------------------------------------------------------------------------------------------------
-- Constants
----------------------------------------------------------------------------------------------------

local CONST = MOAIParticleScript.packConst
local r1 = MOAIParticleScript.packReg( 1 )

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------

function M.new( type, file, layer )

	local system
	if type == "time" then

		local texture = string.sub( file, 0, -5 ) .. ".png"
		local plugin = MOAIParticlePexPlugin.load( file )
		local minLifespan, maxLifespan = plugin:getLifespan()
		local state = MOAIParticleState.new()
		local deck = MOAIGfxQuad2D.new()
		local maxParticles = plugin:getMaxParticles()

		system = MOAIParticleSystem.new()

		system:reserveParticles( maxParticles, plugin:getSize() )
		system:reserveSprites( maxParticles )
		system:reserveStates( 1 )
		system:setBlendMode( plugin:getBlendMode() )

		deck:setTexture( texture )
		deck:setRect( -0.5, -0.5, 0.5, 0.5 ) -- HACK: Currently for scaling we need to set the deck's rect to 1x1
		system:setDeck( deck )

		state:setTerm( minLifespan, maxLifespan )
		state:setPlugin( plugin )

		system:setPriority( 9999 )
		system:setState( 1, state )

		layer:insertProp( system )

		system._emission = plugin:getEmission()
		system._frequency = plugin:getFrequency()
		system._rect = plugin:getRect()

		system:start()
	else
		error( "The particle type is not yet implemented! ")
		return nil
	end

	return system
end

function M.newEmitter( system )

	local emitter = MOAIParticleTimedEmitter.new()
	emitter:setLoc( 0, 0 )
	emitter:setSystem( system )
	emitter:setEmission( system._emission )
	emitter:setFrequency( system._frequency )
	--emitter:setRect( system._rect )

	return emitter
end


function M.clearAll( particleSystem, layer ) 

	particleSystem:stop() -- without this line the FPS drops every level!!
	particleSystem:setDeck(nil)
	layer:removeProp(particleSystem)
	particleSystem = nil
end


if DISABLE_PARTICLES then
	
	-- Mocking		
	
	local foo = function () end

	function M.new()
		return { surge = foo }
	end
	
	function M.newEmitter()
		return { 
			start = foo,
			surge = foo,
			setParent = foo
		}
	end

	function M.clearAll() end
	return M
end


----------------------------------------------------------------------------------------------------
return M