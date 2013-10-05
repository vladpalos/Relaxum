--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local objects = {
    "star",
    "box"
}

--[[
    For configuration types:
        x -> "left" | "right" | number | undefined( wich is random )
        y -> "top" | "bottom" | number | undefined( wich is random ),
--]]

local list = {
    {
        type = "star",
        speedX = 0,
        y = "top",
        minSpeedY = -5,
        maxSpeedY = -1
    },
    {
        type = "box",
        minSpeedY = -5,
        maxSpeedY = -1,
        speedX = 0,
        y = "top"
    }
}

M.init = function()
    game.setBackground( 0.152941176, 0.235294118, 0.631372549, 1.0 )
    level.loadObjects( objects )
end


M.go = function()
    MOAICoroutine.new():run( function()

        -- -- >>
        for i = 1, 100 do level.addRandomObject( list ) end

        while level.getLiveObjects() > 0 do coroutine:yield() end
        level.clean()

        print('Hello')

        --for i = 1, 100 do level.addRandomObject( list ) end

        --while level.getLiveObjects() > 0 do coroutine:yield() end
        --level.clean()
        -- -- >>
--        for i = 1, 100 do objects.addRandom( list2 ) end
--
  --      while objects.getLiveObjects() > 0 do coroutine:yield() end
    --    objects.clean()

    end )
end

----------------------------------------------------------------------------------------------------
return M
