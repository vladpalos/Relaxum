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

    local speedX = conf.speedX or
                   conf.minSpeedX and conf.maxSpeedX and math.random( conf.minSpeedX, conf.maxSpeedX ) or
                   math.random( -5, -1 )

    local speedY = conf.speedY or
                   conf.minSpeedY and maxSpeedY and math.random( conf.minSpeedY, conf.maxSpeedY ) or
                   math.random( -5 , -1 )
   
    return speedX, speedY
end

function M.addFixtures( name, body, category, mask, collisionHandler )
    local fixture
    for _, points in ipairs( resources.getPolys( name ) ) do
        fixture = body:addPolygon( points )  

        fixture:setSensor( true )    
        if category or mask then 
        --	fixture:setFilter( category, mask )
        end
        if collisionHandler then
	        fixture:setCollisionHandler( collisionHandler, 
    	                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )
        end
    end
end



----------------------------------------------------------------------------------------------------
return M
