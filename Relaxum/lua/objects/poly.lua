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
    stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

    local prop, body
    if conf.properties.body == "solid" then
        body = display.addBody( MOAIBox2DBody.STATIC, conf.x, conf.y )
    elseif conf.properties.body == "dynamic" then
        body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y )
    elseif conf.properties.body == "kinematic" then
        body = display.addBody( MOAIBox2DBody.KINEMATIC, conf.x, conf.y )
    else
        error("Please set the body property of polygon object in tiled2d mapeditor")
    end

    object.addTiled2DPolyFixtures( conf.polygon, body, CATEGORY_GOOD, MASK_GOOD, _onCollision, false,
                                   DENSITY, FRICTION )

    --local prop = display.newGradientPolygon( layer, conf.polygon )

    -- local scriptDeck = MOAIScriptDeck.new()

    -- local minx, miny, maxx, maxy = 0, 0, 0, 0
    -- for _, p in ipairs(conf.polygon) do
    --     if minx < p.x then minx = p.x
    --     elseif p.x > maxx then maxx = p.x end

    --     if miny < p.y then minx = p.y
    --     elseif p.y > maxy then maxy = p.y end
    -- end

    -- scriptDeck:setRect( minx, miny, maxx, maxy)
    -- scriptDeck:setDrawCallback( function (index, xOff, yOff, xFlip, yFlip )
    --         MOAIGfxDevice.setPenColor( 1, 1, 1, 1 )
    --         MOAIGfxDevice.setPenWidth( 20 )
    --         MOAIDraw.drawLine( bx, by, P.projX, P.projY )
    -- end )

  --  prop:setParent( body )

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

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------
local l = 0
function _onCollision( ev, fixA, fixB, arbiter )
l = l + 1
print(l)
    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    if bodyA.type == "brick1" and bodyB.type == "player" then
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
