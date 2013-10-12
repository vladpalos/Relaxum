--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local CRACK_FORCE = 500

local sheet, layer

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )
    if conf.shape == 'rectangle' then

        local halfW, halfH = conf.width / 2, conf.height / 2
        local body = display.getWorld():addBody( MOAIBox2DBody.STATIC )
        local fixture = body:addRect( - halfW, -halfH, halfW, halfH )

        body:setTransform( conf.x, conf.y )

        local propCracked = resources.newSprite( 'brick1_cracked_'.. math.random( 2 ), layer, 0, 0 )
        local prop = resources.newSprite( 'brick1', layer, 0, 0 )


        prop:setParent( body )
        propCracked:setParent( body )
        propCracked:setVisible( false )

        fixture:setFilter( CATEGORY_OBSTACLE, MASK_OBSTACLE )
        fixture:setCollisionHandler( _onCollision, MOAIBox2DArbiter.PRE_SOLVE )

        fixture:setFriction(1)

        body.type = conf.type
        body.conf = conf
        body.prop = prop
        body.propCracked = propCracked

        body.cracked = false

        body.remove = function ( self )

            if self.prop ~= nil then
                layer:removeProp( self.prop )
                self.prop = nil
            end

            layer:removeProp( self.propCracked )
            self:destroy()
        end

    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function _onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    if bodyA.type == "brick" and bodyB.type == "player" then
        local vx, vy = bodyB:getLinearVelocity()
        local xA, yA = bodyA:getWorldCenter()
        if math.abs( vx ) > CRACK_FORCE or
           math.abs( vy ) > CRACK_FORCE then

            if not bodyA.cracked then
                layer:removeProp( bodyA.prop )
                bodyA.prop = nil
                bodyA.propCracked:setVisible( true )
                bodyA.cracked = true
            else
                bodyA:remove()
            end

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
