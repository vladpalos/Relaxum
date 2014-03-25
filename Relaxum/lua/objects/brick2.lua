--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local sheet, layer

local CRACK_FORCE = 500

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

        local halfW, halfH = conf.width / 2, conf.height / 2
        local body = display.getWorld():addBody( MOAIBox2DBody.STATIC )
        local fixture = body:addRect( - halfW, -halfH, halfW, halfH )

        body:setTransform( conf.x, conf.y )

        local prop = resources.newSprite( 'brick2', layer, 0, 0 )

        prop:setParent( body )

        fixture:setFilter( CATEGORY_OBSTACLE, MASK_OBSTACLE )
        fixture:setCollisionHandler( _onCollision, MOAIBox2DArbiter.PRE_SOLVE )

        fixture:setFriction(1)

        body.type = conf.type
        body.conf = conf
        body.prop = prop

        body.remove = function ( self )

            if self.prop ~= nil then
                layer:removeProp( self.prop )
                self.prop = nil
            end

            self:destroy()
        end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function M._onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    if bodyA.type == "brick2" and bodyB.type == "player" then
        local vx, vy = bodyB:getLinearVelocity()
        local xA, yA = bodyA:getWorldCenter()
        if math.abs( vx ) > CRACK_FORCE or
           math.abs( vy ) > CRACK_FORCE then
            stars:surge( 5, xA, yA )

            effects.shake( display.getCamera( CAMERA_MOVING ),
                           70 * SCREEN_SHAKE_POWER_X,
                           70 * SCREEN_SHAKE_POWER_Y )

            player.changeFace( "focused" )
        end

    end
end

----------------------------------------------------------------------------------------------------
return M
