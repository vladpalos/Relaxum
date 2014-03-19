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
    {
        type = "star",
        speedX = 0,
        y = "top",
        minSpeedY = -5,
        maxSpeedY = -1
    },
    {
        type = "lamp",
        speedX = 0,
        y = "top",
        minSpeedY = -5,
        maxSpeedY = -1
    },
    {
        type = "d_circle",
        speedX = 0,
        y = "top",
        minSpeedY = -7,
        maxSpeedY = -20,
        radius = 40,
        border = 10,
        points = 10,
        color = { 0.7, 0.7, 0.7, 0.6 },
        borderColor = { 0.4, 0.4, 0.4, 0.4}
    }
}

M.init = function()
    game.setBackground( 0.152941176, 0.235294118, 0.631372549, 1.0 ) -- blue 1
   -- game.setBackground( 0.505882353, 0.521568627, 0.890196078, 1.0 ) -- blue 2
   -- game.setBackground( 0.392156863, 0.643137255, 0, 1.0 )           -- green
    level.loadObjects( list )

    return setup
end


M.goTimeLine = function()

    level.addTimedRandomObjects( 800,
                                 { list[3] },
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
