--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

--
--	This is a general helper for objects created.
--

local M = {}

--[[
Object prototype:
{
	name = "",
	type = "wall",
	shape = "rectangle",
	x = 448,
	y = 256,
	width = 256,
	height = 64,
	visible = true,
	properties = {}
}

Note: - Every object type use it's own configuration so the properties might not be the same on
		every object!
	  - The prototype looks like that so we can easily use it with TiledMapEditor
-- ]]

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------
local layer
local mapW, mapH

----------------------------------------------------------------------------------------------------
-- Global functions
----------------------------------------------------------------------------------------------------

-- Initialization ----------------------------------------------------------------------------------
function M.init()
	layer = display.newLayer( CAMERA_MOVING )
	mapW, mapH = map.getDims()

	-- Load all object box2d points definitions
	resources.loadPolysSheet( 'assets/physics/objects' )
end


-- Config ------------------------------------------------------------------------------------------
function M.config( conf )

end

-- Physics ------------------------------------------------------------------------------------------

-- Adds fixtures to body from list of defined fixtures points:
-- 
-- e.g. To add 3 fixture you call this function with:
-- 		[ 
-- 		  [ 2, 3, 3, 4 ], 
--	      [ 5, 4} ],
-- 		  [ 67, 8, 6, 6, 3, 6} ]
--      ] 
-- For this you ussualy use resources.getPoly

function M.addFixtures( fixturePolyList, body, category, mask, collisionHandler )

	for _, poly in ipairs( fixturePolyList ) do
		--body:addPoly()
    fixture = body:addCircle( 0, 0, SIZE )  

    prop = resources.newSprite( 'player', layer, 0, 0 )
    prop:setParent( body )

    --effects.addGlow( prop )

--    prop:setColor( 0, 0, 0 )

    fixture:setSensor( true )    
--    fixture:setFilter( CATEGORY_GOOD, MASK_GOOD )
    fixture:setCollisionHandler( M.onCollision, 
                                 MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END )
	end

end


---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getLayer()
	return layer
end


----------------------------------------------------------------------------------------------------
return M
