--=================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--=================================================================================================

---------------------------------------------------------------------------------------------------
-- Coding notations
---------------------------------------------------------------------------------------------------
--[[
	Each object has it's own:
	 	1. Physic definition (usually they are all in assets/physics/objects.json)
	 	2. Sprites (in different TexturePacker exported sprites)
	 	3. Logic (in objects folder). This logic uses the helper module which contains general 
	 			configuration functions.
	
	Objects are added in two ways: 
		1. In main level thread (go function of each levels/level#.lua file.)
		2. In TileMapEditor By specifing the name property (e.g. briks are added this way). 

		Warning! To have consistency, the TiledMapEditor Physical definition is only for debbuging. 
		The actual definition should be define in PhysicsBodyEditor. However, the position 
		of those objects are provided from TiledMapEditor. For this reason it is usually better to
		use TiledMapEditor for STATIC objects and to use the level thread for DYNAMIC objects.

	Each level has it's own:
	 	1. Map (Tiled map editor exported map: assets/maps/...)
	 	2. Logic (in levels folder)

	SpriteSheets:
		1. The map spritesheets are loaded differently than the usual spritesheets. They are not
		   loaded using resources.newSpriteSheet(...) but using prop:setTexture(...).
		2. _mw or _mh means half of map width/height.

	WARNING !
		1. When defining objects you NEED to define a way to clean that object. Also the world
		   contains an erase box (or walls) beyond the edges of the screen so that on collision, 
		   body:remove function is called. 
--]]

---------------------------------------------------------------------------------------------------
-- Coding style
---------------------------------------------------------------------------------------------------
--[[
	1) Spaced operators
	2) Spaces inside parentheses if there are any arguments e.g. function foo( arg1, arg2 )
	3) BrakLine after function header
		e.g.
			function foo()

				line1
				line2
				.....
				line100
			end
	4) Functions are verbs, variables are nouns
	5) M stands for Module
	6) There is no point in caching actual shader files, only shaders are cached( more specifically
	   those in effects.lua )
	7) Resources are cached (the sprite sheets and fonts)

	Notes:
		- 'world' refers only to Box2d World
		- This code was written in Sublime Text Editor 2
--]]

---------------------------------------------------------------------------------------------------
-- TODO
---------------------------------------------------------------------------------------------------
--[[
	1. Animated objects
	2. Player life
	3. Destroy objects better
--]]


---------------------------------------------------------------------------------------------------
-- Configuration
---------------------------------------------------------------------------------------------------

require 'extends'
require 'config'
require 'globals'

---------------------------------------------------------------------------------------------------
-- Globals
---------------------------------------------------------------------------------------------------

utils				= require 'system/utils'			
resources			= require 'system/resources'		-- Resources loading / caching / generating
display				= require 'system/display'			-- Display / Graphical drawing 
gui					= require 'system/gui'				
map					= require 'system/map'				-- TiledMapEditor map file reading
hud					= require 'system/hud'				
director	 		= require 'system/director'			-- Main scene director
input				= require 'system/input'			
particles			= require 'system/particles'		
player				= require 'system/player'			
game				= require 'system/game'				-- Main game logic here 
effects				= require 'system/effects'			
level 				= require 'system/level'			-- Level flow handling 
object 				= require 'system/object'			-- Object helpers


-- Initialization ---------------------------------------------------------------------------------

print('\n')
info('Started --------------------------------------')

display.init()
display.initPhysics()


-- Debug ------------------------------------------------------------------------------------------
if DEBUG then
	require('system/debug').enableDebug( 5 )
end

-- Begin ------------------------------------------------------------------------------------------
director.push( 'scenes/game_world_1' )
