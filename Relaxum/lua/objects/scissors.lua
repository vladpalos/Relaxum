--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local VELOCITY_FACTOR = 25

local updateThread-- Box2d doesn't accept body updates during collision handle so we lazy-update them

local sheet, layer

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y )

    object.addB2DEditorFixtures( "scissors_01", body, CATEGORY_GOOD, MASK_GOOD, M.onCollision )

    local scissorsTop = resources.newSprite('scissors_01_top', layer, -8, 0 )
    local scissorsBottom = resources.newSprite( 'scissors_01_bottom', layer, 0, 0 )

    scissorsTop:setParent( body )
    scissorsBottom:setParent( body )

    local rot = 15
    local time = 0.2

    display.newSpanAnimation( scissorsTop, time, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              -rot, rot, -rot) :start()
    display.newSpanAnimation( scissorsBottom, time, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              rot, -rot, rot) :start()

    local speedX = 0 -- math.random(2, 10)
    local speedY = math.random(2, 5)

    body:setLinearVelocity( -speedX * VELOCITY_FACTOR,
                            -speedY * VELOCITY_FACTOR )

    body.type = conf.type
    body.conf = conf
    body.prop = prop

    body.remove = function ( self )

        if self.prop ~= nil then
            layer:removeProp( self.prop )
            self.prop = nil
        end

        layer:removeProp( self.propCracked )
        self:destroy()
    end
end

function M.onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()

    if bodyB.type == "brick" then 
        --bodyA:setTransform( 0, 0, 180 )
        objects.add
        bodyA:applyAngularImpulse( 180 )
    end
    
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
        end

    end
end

----------------------------------------------------------------------------------------------------
return M
