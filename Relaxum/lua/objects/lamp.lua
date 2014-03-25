--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local VELOCITY_FACTOR = 25

local layer, glitter

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local x, y = object.configMovementPos( conf, 70 )
    local speedX, speedY = object.configSpeed( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, x, y )

    body:setTransform( x, y )

    object.addFixtures( "lamp_1", body, CATEGORY_GOOD, MASK_GOOD, M._onCollision )

    local prop = resources.newSprite( 'lamp_1', layer, 0, 0 )
    prop:setOpacity( 0.5 )
    --prop:setColor(math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2)
    prop:setParent( body )

    local rot = math.random(2, 40)
    local time = math.random(3, 5)
    display.newSpanAnimation( prop, time, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_Z_ROT,
                              -rot, rot, -rot) :start()

    body:setLinearVelocity( speedX * VELOCITY_FACTOR,
                            speedY * VELOCITY_FACTOR )
    body:resetMassData()

    body.type = conf.type
    body.prop = prop

    body.remove = function ( self )
        layer:removeProp( self.prop )
        self:destroy()
        level.removeLiveObject()
    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function M._onCollision( ev, fixA, fixB, arbiter )

    if ev == MOAIBox2DArbiter.BEGIN then

        local bodyA, bodyB = fixA:getBody(), fixB:getBody()
        local xA, yA = bodyA:getWorldCenter()

        if bodyB.type == "player" or bodyB.type == "spike" then
            arbiter:setContactEnabled( false )

            bodyA:remove()

            if bodyB.type == "player" then
                glitter:surge( 20, xA, yA )
            elseif bodyB.type == "spike" then
                sparks:surge( 20, xA, yA )
            end
        end
    end
end

----------------------------------------------------------------------------------------------------
return M
