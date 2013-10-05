--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

module(..., package.seeall)

----------------------------------------------------------------------------------------------------
-- Global variables
----------------------------------------------------------------------------------------------------

-- This table is sent to MOAIRenderManager 
layerTable = {}

----------------------------------------------------------------------------------------------------
-- Local variables
----------------------------------------------------------------------------------------------------


local actionRoot = nil

---------------------------------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------------------------------

local levels = {}

levels[1] = {
    
    goal        = 5,
    timeLimit   = 0,

    sheets      = ["assets/sheets/level1.png"],
    objects     = ["assets/objects/objList1.lua"]
    map         = "assets/maps/level1.lua"
}


----------------------------------------------------------------------------------------------------
-- Basic functions
----------------------------------------------------------------------------------------------------

function onLoad()

    input.setCB( game.onTouchEvent )

    layerTable = game.init( settings, objects ) 

    game.loadLevel( "levels/world1/level" .. player.getLevel() .. ".lua" )  


    --bkgLayer:clear()
    --game.run()            
    
    collectgarbage( "stop" )

end


function onFocus()  

    game.resume()
end

function onBlur()

    game.pause()
end

function onDelete() 

    player.deinit()
end


---------------------------------------------------------------------------------------------------
return M
