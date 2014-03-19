--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local CRACK_FORCE = 500
local WIDTH, HEIGHT = 64, 64

local sheet, layer

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

    local halfW, halfH = WIDTH / 2, HEIGHT / 2
    local body = display.getWorld():addBody( MOAIBox2DBody.STATIC )
    local fixture = body:addRect( - halfW, -halfH, halfW, halfH )

    body:setTransform( conf.x, conf.y )

    local prop = resources.newSprite( 'brick1', layer, 0, 0 )

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
function _onCollision( ev, fixA, fixB, arbiter )
    local bodyA, bodyB = fixA:getBody(), fixB:getBody()
    if bodyA.type == "brick1" and bodyB.type == "player" then
    end
end

----------------------------------------------------------------------------------------------------
return M
