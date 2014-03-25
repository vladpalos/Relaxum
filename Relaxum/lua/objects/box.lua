--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local DEFAULT_MASS = 40
local FORCE_FACTOR = 2500

local layer, glitter

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local fixture, prop, anim
    local x, y = object.configPos( conf, 70 )
    local speedX, speedY = object.configSpeed( conf )
    local body = display.addBody( MOAIBox2DBody.DYNAMIC, x, y )
    local mass = conf.mass or DEFAULT_MASS

    body:setTransform( x, y )
    body:setMassData( mass )

    object.addB2DEditorFixtures( "box", body )

    prop = resources.newSprite( 'box1', layer, 0, 0 )
    prop:setParent( body )

    body:applyForce( speedX * FORCE_FACTOR, speedY * FORCE_FACTOR )
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

        if bodyB.type == "player" then


          --  bodyA:remove()

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
