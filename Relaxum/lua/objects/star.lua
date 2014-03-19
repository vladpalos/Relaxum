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

    local fixture, prop, anim
    local x, y = object.configMovementPos( conf, 70 )
    local speedX, speedY = object.configSpeed( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, x, y )


    object.addB2DEditorFixtures( "star", body, CATEGORY_GOOD, MASK_GOOD, _onCollision, true )

    body:setTransform( x, y, math.random( 360 ) )

    prop = resources.newSprite( 'star', layer, 0, 0 )
    --prop:setOpacity( math.random() * 0.8 + 0.2)
    --prop:setColor(math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2)
    --prop:setColor(1, 1, 1, math.random() * 0.8 + 0.2)
    prop:setParent( body )

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

function _onCollision( ev, fixA, fixB, arbiter )

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
