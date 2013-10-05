--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local RADIUS = 40
local VELOCITY_FACTOR = 25

local layer, prop, glitter
local particle

function M.load()

    layer = objects.getLayer()

    resources.loadSpriteSheet( "assets/sheets/tiles_sheet_3" )

    -- Particles
    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
    sparks = particles.new( "time", "assets/particles/player.pex", layer )

    -- Moving clouds
end

function M.add( conf )

    local x, y, speedX, speedY, body, fixture, prop, anim

    x, y = objects.configPos( conf )
    speedX, speedY = objects.configSpeed( conf )

    body = display.addBody( MOAIBox2DBody.DYNAMIC )
    fixture = body:addCircle( 0, 0, RADIUS )

    --[[
        prop, anim = resources.newSpriteAnim( 'fellow1', layer, 0, 0, { 1, 0.00,

                                                                    4, 2.90,
                                                                    1, 2.95,
                                                                    4, 3.00,
                                                                    1, 3.05 } )
    --]]

    local prop = resources.newSprite( 'fellow1', layer, 0, 0 )
    prop:setParent( body )

    fixture:setSensor( true )
    fixture:setFilter( CATEGORY_GOOD, MASK_GOOD )
    fixture:setCollisionHandler( M.onCollision,
                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )

    body:setTransform( math.random(200) - 100, math.random(200) - 100 )
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
