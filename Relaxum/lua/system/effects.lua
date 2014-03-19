--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local M = {}
local SHADERS = {}

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------

-- Visuals -----------------------------------------------------------------------------------------

function M.addGlow( prop )

    if SHADERS['glow'] then
        prop:setShader( SHADERS['glow'] )
        return
    end

    local shader = MOAIShader.new()

    shader:reserveUniforms( 1 )
    shader:declareUniform( 1, 'transform', MOAIShader.UNIFORM_WORLD_VIEW_PROJ )
    shader:setVertexAttribute( 1, 'position' )
    shader:setVertexAttribute( 2, 'color' )

    shader:load( resources.loadShaderFiles( 'assets/shaders/glow' ) )

    prop:setShader( shader )

    SHADERS['glow'] = shader
end

-- Animation ---------------------------------------------------------------------------------------

-- The object must be a MOAITransfrom2D Object
function M.addShaker( prop )

    if prop.shakerCoroutine then
        warn("Object allready has a shaker!")
        return
    end

    prop.shakerCoroutine = MOAICoroutine.new()
end


function M.shake( prop, powerX, powerY, drag, elasticity )

    local drag = drag or .1
    local elasticity = elasticity or .1
    local err = 0.02

    if not prop.shakerCoroutine then
        error("Please add a shaker to the prop before using the shake effect!")
    end

    prop.shakerCoroutine:stop()
    prop.shakerCoroutine:run( function ()

        local powerX, powerY, prop, drag, elasticity
            = powerX, powerY, prop, drag, elasticity

        local posX, posY, velX, velY = 0, 0, powerX, powerY
        local oldX, oldY = prop:getLoc()

        while math.abs( velX ) >= err and math.abs( velY ) >= err do

            velX = velX - ( velX * drag )
            velY = velY - ( velY * drag )

            velX = velX - ( posX * elasticity )
            velY = velY - ( posY * elasticity )

            posX = posX + velX
            posY = posY + velX

            prop:moveLoc( posX, posY )

            coroutine:yield()
        end
    end )
end


function M.addCloud( layer, spriteName, x, y, time )

    resources.loadSpriteSheet('assets/sheets/perm_sheet_1')

    local _mw, _mh = map:getHalfDims()
    local cloud = resources.newSprite( spriteName, layer, x, y )
    local aux = cloud:getDims() / 2 + 30

    local anim = display.repeatAnimAttr( cloud, MOAITransform2D.ATTR_X_LOC, -_mw - aux, _mw + aux, time):start()

    anim:setTime( x )

end

-- Cleaning ----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
-- Getters / Setters
----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
return M