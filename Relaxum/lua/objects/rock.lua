--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local layer, glitter

local DENSITY = 250
local FRICTION = 1

function M.load()

    layer = level.getLayer()
    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )

    glitter = particles.new( "time", "assets/particles/glitter4.pex", layer )
end

function M.add( conf )

    local prop, anim
    local body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y )

    object.addB2DEditorFixtures( "rock", body, CATEGORY_GOOD, MASK_GOOD, _onCollision, false, 
                                 DENSITY, FRICTION )

    prop = resources.newSprite( 'rock', layer, 0, 0 )
    prop:setParent( body )

    body:resetMassData()  

    body.type = conf.type
    body.prop = prop

    body.remove = function ( self )
        layer:removeProp( self.prop )
        self:destroy()
        level.removeLiveObject()
    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function _onCollision( ev, fixA, fixB, arbiter )
end

----------------------------------------------------------------------------------------------------
return M