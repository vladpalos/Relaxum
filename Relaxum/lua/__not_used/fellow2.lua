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
    layer = level.getLayer()
    mapW, mapH = map.getDims()

    resources.loadSpriteSheet( "assets/sheets/tiles_sheet_1" )

    -- Particles
    glitter = particles.new( "time", "assets/particles/glitter.pex", layer )
    sparks = particles.new( "time", "assets/particles/glitter.pex", layer )   
end

function M.add( conf )
    
    
    local x, y = conf.x, conf.y
    local speedX, speedY = conf.speedX, conf.speedY

    if type(x) == 'string' and x == 'rand' then 
        x = math.random( mapW - 100 ) - ( mapW / 2 - 100 )
    end

    if type(y) == 'string' and y == 'rand' then 
        y = math.random( mapH ) - ( mapH / 2 )
    end

    local body = world:addBody( MOAIBox2DBody.KINEMATIC )
    local fixture = body:addCircle( 0, 0, RADIUS )
    body:setTransform( x, y )
    fixture:setSensor( true )
    
    local prop = resources.newSprite( 'fellow2/0.png', layer, 0, 0 )
    prop:setParent( body )
    body:setLinearVelocity( speedX * VELOCITY_FACTOR, 
                            speedY * VELOCITY_FACTOR )

    fixture:setFilter( CATEGORY_GOOD, MASK_GOOD )
    fixture:setCollisionHandler( M.onCollision, 
                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )
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

            level.removeLiveObject()
    
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
