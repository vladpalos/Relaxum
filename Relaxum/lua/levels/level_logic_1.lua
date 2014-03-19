--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local thread

--[[
    For configuration types:
        x -> "left" | "right" | number | undefined( wich is random )
        y -> "top" | "bottom" | number | undefined( wich is random ),
--]]

local setup = {
    targetCount = 15
}

local list = {
    --[[ White Circle ]]--
    {
        type = "d_circle",
        speedX = 0,
        y = "top",
        minSpeedY = -1,
        maxSpeedY = -5,
        radius = 40,
        border = 10,
        points = 10,
        color = { 0.7, 0.7, 0.7, 0.6 },
        borderColor = { 0.4, 0.4, 0.4, 0.4}
    },

    --[[ Green Circle ]]--
    {
        type = "d_circle",
        speedX = 0,
        y = "top",
        minSpeedY = -1,
        maxSpeedY = -5,
        radius = 40,
        border = 10,
        points = 10,
        color = { 0.2, 0.9, 0.2, 0.9 },
        borderColor = { 0, 0.4, 0, 0.4}
    },

    --[[ Red Circle ]]--
    {
        type = "d_circle_bad",
        speedX = 0,
        y = "top",
        minSpeedY = -7,
        maxSpeedY = -20,
        radius = 40,
        border = 10,
        points = 10,
        color = { 1.00, 0.21, 0.17, 1 };
        borderColor = { 0.6, 0.2, 0, 0.4}
    }
}

M.init = function()

    local colors = { {0.01, 0.1, 0.3},
                     {0.01, 0.1, 0.3},
                     {0.022941176, 0.115294118, 0.511372549},
                     {0.022941176, 0.115294118, 0.511372549} }

    game.setBackground( nil )
    level.loadObjects( list )

    return setup
end


M.goTimeLine = function()

    level.addTimedRandomObjects( 8000,
                                 list,
                                 0, 1 )

--        level.addTimedRandomObjects( 20,
--                                   { list[1] },
--                                 0, 1 )
    ---info ('Now passed')
  --  level.addTimedRandomObjects( 5,
    --                             { list[2] },
      --                           2, 4 )

    --level.addTimedRandomObjects( 50,
      --                           { list[1] },
        --                         0, 1 )
--        level.addRandomObjects( 20, list, 0, 0.5 )

--        while level.getLiveObjects() > 0 do coroutine:yield() end
--      level.clean()

--    print('Hello')

    --for i = 1, 100 do level.addRandomObject( list ) end

    --while level.getLiveObjects() > 0 do coroutine:yield() end
    --level.clean()
    -- -- >>
--        for i = 1, 100 do objects.addRandom( list2 ) end
--
--      while objects.getLiveObjects() > 0 do coroutine:yield() end
--    objects.clean()

end

----------------------------------------------------------------------------------------------------
return M
