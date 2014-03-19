--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local RADIUS = 25
local ROT_TIME = 3

local layer, glitter

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local halfW, halfH = conf.width / 2, conf.height / 2
    local body = display.getWorld():addBody( MOAIBox2DBody.STATIC )
    local fixture = body:addCircle( 0, 0, RADIUS )

    body:setTransform( conf.x, conf.y )

    local prop = resources.newSprite( 'spiral', layer, 0, 0 )
    --prop:setColor(math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2, math.random() * 0.8 + 0.2)
    prop:setParent( body )

    fixture:setFilter( CATEGORY_OBSTACLE, MASK_OBSTACLE )
    fixture:setCollisionHandler( _onCollision, MOAIBox2DArbiter.PRE_SOLVE )

    local rand_rot = math.random(0, 360)
    display.newSpanAnimation( prop, ROT_TIME, MOAITimer.LOOP,  MOAIEaseType.LINEAR,  MOAITransform.ATTR_Z_ROT,
                              rand_rot, rand_rot + 360) :start()


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

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    local xA, yA = bodyA:getWorldCenter()

    if bodyB.type == "player" then
        arbiter:setContactEnabled( false )
        local x, y = bodyA:getPosition()
        print(x, y)
        glitter:surge( 20, x, y )
        bodyA:remove()
    end
end

----------------------------------------------------------------------------------------------------
return M
