--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local RADIUS = 40
local VELOCITY_FACTOR = 25

local layer, glitter

function M.load()

    layer = objects.getLayer()

    resources.loadSpriteSheet( "assets/sheets/tiles_sheet_3" )
    
    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )    

end

function M.add( conf )
    
    local x, y, speedX, speedY, body, fixture, prop, anim

    x, y = objects.configPos( conf )
    speedX, speedY = objects.configSpeed( conf )

    body = display.addBody( MOAIBox2DBody.KINEMATIC, x, y )
    fixture = body:addCircle( 0, 0, RADIUS )  

    prop = resources.newSprite( 'player', layer, 0, 0 )
    prop:setParent( body )

    --effects.addGlow( prop )

--    prop:setColor( 0, 0, 0 )

    fixture:setSensor( true )    
    fixture:setFilter( CATEGORY_GOOD, MASK_GOOD )
    fixture:setCollisionHandler( M.onCollision, 
                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )

    body:setLinearVelocity( speedX * VELOCITY_FACTOR, 
                            speedY * VELOCITY_FACTOR )
    body:resetMassData()     

    body.type = conf.type
    body.prop = prop
end

function M.onCollision( ev, fixA, fixB, arbiter )

    if ev == MOAIBox2DArbiter.BEGIN then

        local bodyA, bodyB = fixA:getBody(), fixB:getBody()
        local xA, yA = bodyA:getWorldCenter()

        if bodyB.type == "player" or bodyB.type == "spike" then            
            arbiter:setContactEnabled( false )

            layer:removeProp( bodyA.prop )
            bodyA:destroy()

            objects.removeLiveObject()
    
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
