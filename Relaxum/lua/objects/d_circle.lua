--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local DEFAULT_POINTS            = 10

local DEFAULT_RADIUS            = 40
local DEFAULT_BORDER            = 5
local DEFAULT_VELOCITY          = 20
local DEFAULT_COLOR             = { 0.8, 0.8, 0.8, 0.8 }
local DEFAULT_BORDER_COLOR      = {0.6, 0.6, 0.6, 0.6}

local layer, glitter

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local radius = conf.radius or DEFAULT_RADIUS
    local border = conf.border or DEFAULT_BORDER

    local x, y = object.configMovementPos( conf, radius )
    local speedX, speedY = object.configSpeed( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, x, y )
    local fixture = body:addCircle( 0, 0, radius + border )


    --local prop = resources.newSprite( 'spiral', layer, 0, 0 )

    local color = conf.color or DEFAULT_COLOR
    local borderColor = conf.borderColor or DEFAULT_BORDER_COLOR

    local s1, s2 =  math.random(2, 5),  math.random(2, 5)
    local p1, p2 =  math.random(-5, 5),  math.random(-5, 5)
    local aux1, aux2

    utils.setInterval( function()
        aux1, aux2 = s1, s2
        s1, s2 = 0, 0
        utils.setTimeout( function()
            s1, s2 = aux1, aux2
        end, 0.2 )
    end, math.random( 4, 6 ) )


    function onDraw ( index, xOff, yOff, xFlip, yFlip )
        MOAIGfxDevice.setPenColor ( borderColor[1], borderColor[2], borderColor[3], borderColor[4] )
        MOAIDraw.fillCircle ( 0, 0, radius + border, 24 )

        MOAIGfxDevice.setPenColor ( color[1], color[2], color[3], color[4] )
        MOAIDraw.fillCircle ( 0, 0, radius, 24 )

        MOAIGfxDevice.setPenColor ( 0.4, 0.4, 0.4, 1 )
        MOAIDraw.fillCircle ( -10 + p1, 10, s1, 10 )
        MOAIDraw.fillCircle ( 10 + p2, 10,  s2, 10 )
    end

    local scriptDeck = MOAIScriptDeck.new ()
    scriptDeck:setRect ( - (radius / 2), - (radius / 2), radius / 2, radius / 2 )
    scriptDeck:setDrawCallback ( onDraw )

    local prop = MOAIProp2D.new ()
    prop:setDeck ( scriptDeck )
    prop:setBlendMode( MOAIProp2D.BLEND_NORMAL )

    prop:setParent( body )

    layer:insertProp( prop )

    fixture:setFilter( CATEGORY_OBSTACLE, MASK_OBSTACLE )
    fixture:setCollisionHandler( M._onCollision, MOAIBox2DArbiter.PRE_SOLVE )


    body:setLinearVelocity( speedX * ( conf.velocityFactor or DEFAULT_VELOCITY ),
                            speedY * ( conf.velocityFactor or DEFAULT_VELOCITY ) )

    body:resetMassData()

    body.type = conf.type
    body.prop = prop

    body.points = conf.points or DEFAULT_POINTS

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

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    local xA, yA = bodyA:getWorldCenter()

    if bodyB.type == "player" then
        arbiter:setContactEnabled( false )
        local x, y = bodyA:getPosition()
        glitter:surge( 20, x, y )
        bodyA:remove()

        player.addScore( bodyA.points )
        player.addObjectsCount( 1 )
        hud.refresh()

        local text = gui.addShortAnimText( tostring( bodyA.points ), x, y, 120, 150, 1 )
        layer:insertProp( text )

        utils.setTimeout( function()
            layer:removeProp( text )
        end, 2 )
    end
end

----------------------------------------------------------------------------------------------------
return M

