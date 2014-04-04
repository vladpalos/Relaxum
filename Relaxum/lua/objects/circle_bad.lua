--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local DAMAGE                    = 20

local DEFAULT_POINTS            = 10

local RADIUS                    = 32
local DEFAULT_VELOCITY          = 20


local layer, glitter

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local x, y = object.configMovementPos( conf, RADIUS )
    local speedX, speedY = object.configSpeed( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, x, y )
    local fixture = body:addCircle( 0, 0, RADIUS )

    local prop_saw = resources.newSprite( 'circle_bad_saw', layer, 0, 0 )
    local prop_body = resources.newSprite( 'circle_bad', layer, 0, 0 )
    local prop_eye = resources.newSprite( 'circle_bad_eye', layer, 0, 5 )

    local time = math.random(3, 5)
    display.newSpanAnimation( prop_saw, time, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_Z_ROT,
                              0, 360 ) :start()

    local dif = math.random(0, 1) and -1 or 1
    local eye_time = math.random(1, 2)
    display.newSpanAnimation( prop_eye, eye_time, MOAITimer.LOOP,  MOAIEaseType.FLAT,  MOAITransform.ATTR_X_LOC,
                              dif * -3, dif * 3, dif * -3 ) :start()

    prop_saw:setParent( prop_body )
    prop_eye:setParent( prop_body )
    prop_body:setParent( body )

    fixture:setFilter( CATEGORY_BAD, MASK_BAD )
    fixture:setCollisionHandler( M._onCollision, MOAIBox2DArbiter.PRE_SOLVE )


    body:setLinearVelocity( speedX * ( conf.velocityFactor or DEFAULT_VELOCITY ),
                            speedY * ( conf.velocityFactor or DEFAULT_VELOCITY ) )


    body:resetMassData()

    body.type = conf.type
    body.prop = { prop_body, prop_saw, prop_eye }

    body.points = conf.points or DEFAULT_POINTS

    body.remove = function ( self )
        display.deleteProps( layer, self.prop )
        self:destroy()
        level.removeLiveObject()
    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function M._onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    local xA, yA = bodyA:getWorldCenter()

    if bodyB.type == "player" then
        arbiter:setContactEnabled( false )
        local posX, posY = bodyA:getPosition()
        player.hit( DAMAGE, -posX * 2, -posY * 2)
    end
end

----------------------------------------------------------------------------------------------------
return M

