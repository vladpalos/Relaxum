--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local RADIUS = 40
local VELOCITY_FACTOR = 25

local world, layer, prop, glitter
local mapW, mapH
local particle

function M.load()

    world = display.getWorld()
    layer = objects.getLayer()
    mapW, mapH = map.getDims()

    resources.loadSpriteSheet( "assets/sheets/tiles_sheet_3" )

    -- Particles
    glitter = particles.new( "time", "assets/particles/glitter.pex", layer )
    sparks = particles.new( "time", "assets/particles/glitter.pex", layer )

end

function M.add( conf )
    
    objects.setLiveObjects( objects.getLiveObjects() + 1 )

    local y = conf.y or math.random( mapH ) - ( mapH / 2 )
    local x = conf.x or math.random( mapW - 100 ) - ( mapW / 2 - 100 )

    local speedX = conf.speedX or 
                   conf.minSpeedX and conf.maxSpeedX and math.random( conf.minSpeedX, conf.maxSpeedX ) or
                   math.random( -5, -1 )

    local speedY = conf.speedY or 
                   conf.minSpeedY and maxSpeedY and math.random( conf.minSpeedX, conf.maxSpeedX ) or
                   math.random( -5 , -1 )


    local body = world:addBody( MOAIBox2DBody.KINEMATIC )
    local fixture = body:addCircle( 0, 0, RADIUS )
    local prop = resources.newSprite( 'player.png', layer, 0, 0 )

    prop:setParent( body )
    prop:setColor( math.random(), 
                   math.random(),
                   math.random(), 1 )

    fixture:setSensor( true )    
    fixture:setFilter( CATEGORY_GOOD, MASK_GOOD )
    fixture:setCollisionHandler( M.onCollision, 
                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )

    body:setTransform( x, y )
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

            objects.setLiveObjects( objects.getLiveObjects() - 1 )
    
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
