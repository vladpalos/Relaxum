--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local world

function M.load() 
    world = display.getWorld()
end

function M.add( conf )
    if conf.shape == 'rectangle' then  

        local halfW, halfH = conf.width / 2, conf.height / 2
        local body = world:addBody( MOAIBox2DBody.STATIC )
        local fixture = body:addRect( - halfW, -halfH, halfW, halfH )

        fixture:setFilter( CATEGORY_OBSTACLE, MASK_OBSTACLE );

        body:setTransform( conf.x, conf.y )

        body.type = conf.type
        body.conf = conf
    end
end

----------------------------------------------------------------------------------------------------
return M
