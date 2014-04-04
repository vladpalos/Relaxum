--=================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local P = {} -- Player
local layer = nil
local mapW, mapH

P.age = {
	[1] = {
		power = 1,
		speed = 3,
	},
	[2] = {
		power = 1,
		speed = 3,
	},
	[3] = {
		power = 1,
		speed = 3,
	},

}

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

-- Initialization
function initProps()

	P.prop = resources.newSprite( "player", layer, P.x, P.y )
	P.prop:setVisible( true )
	P.prop:setPriority( 10 )

	P.xProp = resources.newSprite( "x", layer, P.x, P.y)
	P.xProp:setVisible( false )
	P.xProp:setVisible( 12 )

	P.aimProp = resources.newSprite( "player_aim", layer, P.x, P.y)
	P.aimProp:setPriority( 12 )
	P.aimProp:setVisible( false )

	P.aimLineProp = display.newDrawing( layer, 0, 0, 3000, 3000, -- maybe
		function( index, xOff, yOff, xFlip, yFlip )
			MOAIGfxDevice.setPenColor( 0.2, 0.2, 0.2, 0.2 )
			MOAIGfxDevice.setPenWidth( P.lineSize )
			MOAIGfxDevice.setPointSize( P.lineSize )
			local bx, by = P.body:getPosition()
			MOAIDraw.drawLine( bx, by, P.projX, P.projY )
		end
	)
	P.aimLineProp:setVisible( false )
	P.aimLineProp:setPriority( 1 )

end

function initParticles()
	P.glowParticles = particles.new( "time", "assets/particles/player.pex", layer )

	P.glowParticlesEmitter = particles.newEmitter( P.glowParticles )
	P.glowParticlesEmitter:start()
	P.glowParticlesEmitter:setParent( P.prop )
end

function initPhysicsBody()
	local world = display.getWorld()
	P.body = display.addBody(  MOAIBox2DBody.DYNAMIC, 0, 0 )

	local fixture = P.body:addCircle( 0, 0, P.size - 8 )
	fixture:setDensity( P.density )
	fixture:setRestitution( P.restitution )

    fixture:setFilter( CATEGORY_PLAYER, MASK_PLAYER )
    fixture:setCollisionHandler( M._onCollision, MOAIBox2DArbiter.BEGIN )

	P.body:setTransform( P.x, P.y )
	P.body:setLinearDamping( P.linearDamping )
	P.body:setFixedRotation()
	P.body:resetMassData()

	P.body.type = "player"

	P.prop:setParent( P.body )
end

---------------------------------------------------------------------------------------------------
-- Global Functions
---------------------------------------------------------------------------------------------------

-- Player load / save data in file/db --------------------------------------------------------------
function M.loadData()
	-- Should load from file
	P.name = "Vlad Palos"

	P.level = 1
	P.score = 0
	P.life = 100
	P.lives = 3
	P.speed = 4
	P.objectsCount = 0

	P.loaded = true
	P.size = 50				-- Texture size
	P.lineSize = 10

	P.density = 2
	P.restitution = 0.6
	P.linearDamping = 2

	-- Power up when the player touches and holds
	P.power = 0
	P.powerDelta = .1


	P.x, P.y  = 0, 0
	P.projX, P.projY = P.x, P.y
	P.seekX, P.seekY = P.x, P.y

	P.projW	= P.power * 50

	P.moveAnim = nil
end

function M.saveData( )
end

-- Initialization ---------------------------------------------------------------------------------
function M.init( )
	if not P.loaded then
		error( "No player loaded!" )
	end

	resources.loadSpriteSheet( "assets/sheets/perm_sheet_1" )

    layer = display.newLayer( CAMERA_MOVING )

	-- Initializaion
	initProps()
	initParticles()
	initPhysicsBody()

	-- Movement
	P.moveCoroutine = MOAICoroutine.new()
	P.hitCoroutine = MOAICoroutine.new()

	effects.addShaker( P.prop )

	-- Follow player with camera
	mapW, mapH = map.getDims()
	display.setAnchor( P.prop, mapW, mapH )

end

function M.moveAnimated( x, y )

	P.aimProp:setVisible( false )
	P.aimLineProp:setVisible( false )

	P.xProp:setVisible( true )
	P.xProp:setLoc( x, y )

	P.seekX, P.seekY = x, y

	P.moveCoroutine:run( function ()

		local err = 2
		local speed = P.speed
		local seekx, seeky = P.seekX, P.seekY
		local vx, vy

		P.body:setLinearVelocity( 0, 0 )

		maxvx = (seekx - P.x) * P.speed
		maxvy = (seeky - P.y) * P.speed

		while seekx ~= P.x and seeky ~= P.y do

			P.x, P.y = P.body:getPosition()

			vx = (seekx - P.x) * speed
			vy = (seeky - P.y) * speed

			if math.abs( vx ) < err and
			   math.abs( vy ) < err then
				sx, sy = P.x, P.y
				P.body:setLinearVelocity( 0, 0 )
			else
				P.body:setLinearVelocity( vx, vy )
			end

			coroutine:yield()
		end

		P.xProp:setVisible( false )

	end )
end

function M.stop()
	P.moveCoroutine:stop()
	P.xProp:setVisible( false )
end

function M.reinit()

end


function M.destroy()
	--P.prop:seekColor( 0, 0, 0, 0, 2 )

	P.glowParticles:stop()
	M.stop()
	P.body:destroy()
	display.deleteProps(layer, { P.aimLineProp, P.xProp, P.aimProp })

	P.prop:moveLoc( 0, -1000, 1.5, EASE_OUT )

	utils.setTimeout( function ()
		display.deleteProps(layer, { P.prop })
	end, 4 )

end


function M.aim( x, y )
	P.aimProp:setVisible( true )
	P.aimLineProp:setVisible( true )

	P.projX = x
	P.projY = y

	local rot = math.atan2( P.x - x, -P.y + y )
	P.prop:setRot( math.deg( rot ) + 180 )

	P.aimProp:setLoc( x, y )
end


---------------------------------------------------------------------------------------------------
-- Private functions
---------------------------------------------------------------------------------------------------

function M._onCollision( ev, fixA, fixB, arbiter )
	-- TODO Only on category or mask
    local vx, vy = P.body:getLinearVelocity()
    -- if obstacle the
    -- M.stop()
	-- P.body:applyLinearImpulse( vx , vy )
end

---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getScore() 			return P.score 			end
function M.isInitialized() 		return P.initialized 	end
function M.getLevel() 			return P.level 			end
function M.getPower() 			return P.power 			end
function M.getLife() 			return P.life 			end
function M.getLives() 			return P.lives 			end
function M.getObjectsCount() 	return P.objectsCount	end

function M.getProp()			return P.prop			end
function M.getLayer()			return layer 			end

---------------------------------------------------------------------------------------------------
-- Setters
---------------------------------------------------------------------------------------------------

-- The vx and vy parameters are when you need to emulate an object or you don't use the default
-- box2d system for collision support.
function M.hit( damage, vx, vy )

	if P.hitCoroutine:isBusy() then
		return -- Let the man breathe a little
	end

	M.subLife( damage )
	hud.refresh( )

    M.stop()

	P.hitCoroutine:run( function()

		M.changeFace( "sad" )
		--if damage < 30 then
			
			P.body:applyLinearImpulse( vx, vy )
			P.body:setLinearVelocity( vx, vy )
			
			P.body:resetMassData()

    		utils.wait( P.prop:seekColor( .8, .8, .8, .8, .1, EASE_OUT ) )
    		utils.wait( P.prop:seekColor( .6, .6, .6, .6, .1, EASE_IN ) )
    		utils.wait( P.prop:seekColor( .8, .8, .8, .8, .1, EASE_OUT ) )
    		utils.wait( P.prop:seekColor( .6, .6, .6, .6, .1, EASE_IN ) )
    		utils.wait( P.prop:seekColor( .8, .8, .8, .8, .1, EASE_OUT ) )
    		utils.wait( P.prop:seekColor( .6, .6, .6, .6, .1, EASE_IN ) )
    		utils.wait( P.prop:seekColor( .8, .8, .8, .8, .1, EASE_OUT ) )
    		utils.wait( P.prop:seekColor( .6, .6, .6, .6, .1, EASE_IN ) )
    		utils.wait( P.prop:seekColor( 1, 1, 1, 1, .1 ) )

		--end
		M.changeFace()
	end )

end

-- If persistent is:
-- 	   *  true: the face stays like this forever.
--     *  number: the face returns to normal after this amount of time ( seconds )
--     *  missing / false / etc.: the face returns to normal after a constant amount of time.

function M.changeFace( face, persistent )

    local face = (not face) and "player" or "player_" .. face

	resources.changeSprite( P.prop, face )

	if M._changeFaceTimer then
		M._changeFaceTimer:stop()
	end

	if type( persistent ) == 'number' or not persistent then
		local persistent = persistent or DEFAULT_RESTORE_FACE

		if M._changeFaceTimer then
			M._changeFaceTimer:start()
		else
			M._changeFaceTimer = utils.setTimeout( function()
				player.changeFace()
			end, persistent )
		end
	end
end

function M.grow()

end

function M.shrink()

end

function M.setLevel( x ) 			P.level	= x 			end
function M.setPower( x ) 			P.power = x 			end
function M.setLife( x ) 			P.life 	= x 			end
function M.setScore( x ) 			P.score = x 			end
function M.setlives( x ) 			P.lives = x 			end
function M.setObjectsCount( x ) 	P.objectsCount = x 		end

function M.addObjectsCount( x )
	P.objectsCount = P.objectsCount + x
end

function M.addScore( x )

	P.score = P.score + x
end

function M.subLife( x )

	P.life = P.life - x

	if P.life <= 0 then
		game.gameOver()
		return
	end

end


----------------------------------------------------------------------------------------------------
return M
