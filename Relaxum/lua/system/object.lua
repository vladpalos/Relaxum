--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

--
--	This is a module with some functions used by object types configuration.
--

local M = {}

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------


function M.init()		
end

function M.configPos( conf, apxSize ) 

    -- The aproximation size to know where the object to position itself at the beggining  
    -- This shoudn't be to big, because it can hit the remove walls (or remove box)  
	apxSize = apxSize or 70

    local mapW, mapH = map.getDims()
    local deltaX, deltaY = (mapW / 2) + apxSize, (mapH / 2) + apxSize

    local x = (conf.x == "left") and -deltaX or 
              (conf.x == "right") and deltaX or 
              type(conf.x) == "number" and conf.x or 
              (math.random( mapW ) - ( deltaX ))

    local y = (conf.y == "top") and deltaY or 
              (conf.y == "bottom") and -deltaY or 
              type(conf.y) == "number" and conf.y or 
              (math.random( mapH ) - ( deltaY ))

    return x, y
end


function M.configSpeed( conf ) 

    local speedX, speedY

    speedX = conf.speedX 
             or conf.minSpeedX and 
                conf.maxSpeedX and 
                (math.random() * (conf.maxSpeedX - conf.minSpeedX)) + conf.minSpeedX
             or math.random(-5, 1)

    speedY = conf.speedY 
             or conf.minSpeedY and 
                conf.maxSpeedY and 
                (math.random() * (conf.maxSpeedY - conf.minSpeedY)) + conf.minSpeedY
             or math.random(-5, 1)
   
    return speedX, speedY
end


-- This is used only for polygon-body-shaped. For other fixtures, you must manually add them (ex: Circle).
function M.addB2DEditorFixtures( name, body, category, mask, collisionHandler, isSensor )
    local fixture
    for _, points in ipairs( resources.getPolys( name ) ) do
        fixture = body:addPolygon( points )  

        fixture:setSensor( isSensor or false )    
        if category or mask then 
            fixture:setFilter( category, mask )
        end
        if collisionHandler then
	        fixture:setCollisionHandler( collisionHandler, 
    	                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )
        end

        fixture:setDensity( 10 )
        fixture:setFriction( 0 )
    end
end



----------------------------------------------------------------------------------------------------
return M
