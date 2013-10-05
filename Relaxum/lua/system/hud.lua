--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local layer	= nil
local partition = nil
local scoreText = nil
local lifeText = nil
local livesText = nil
local menuButton = nil


---------------------------------------------------------------------------------------------------
-- Global Functions
---------------------------------------------------------------------------------------------------

-- Initialization ---------------------------------------------------------------------------------

function M.init( layer )
	
	layer = display.newLayer( CAMERA_FIXED, 800 )
	partition = layer:getPartition()

	scoreText = gui.newTextBox( tostring( player.getScore() ), "f1", "large", layer,
								  		  300, 190, 100, 50,
										  1, 1, 1, 0.7 )

	lifeText = gui.newTextBox( tostring( player.getLife() ), "f1", "large", layer,
										 -200, 190, 70, 50,
										 1, 1, 1, 0.7 )

	livesText = gui.newTextBox( tostring( player.getLives() ), "f1", "large", layer,
										  -100, 190, 70, 50,
										  1, 1, 1, 0.7 )
	
end

function M.refresh()

	scoreText:setString( tostring( player.getScore() ) )
	lifeText:setString( tostring( player.getLife() ) )
	livesText:setString( tostring( player.getLives() ) )
end


-- Text ---------------------------------------------------------------------------------==========

function M.addMainText( text )
	local text = gui.newTextBox(text, "f1", "large", layer, 
								0, 0, 300, 200, 
								1, 1, 1, 0.8 )

	text:setAlignment( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
end

function M.addCharacterText( delay, text, effect )

	local EFFECT_DELAY = 4

	local height = 100

	local charProp = display.newImage( "assets/images/character3.png", layer, 
									   - HALF_WIDTH + 60 , - HALF_HEIGHT + height , 130, 200 )

	local textBox = display.newTextBox( text, "f1", "medium", layer, 
										50, -HALF_HEIGHT + height * 0.7, 
										650 , 
										height, 
										1, 1, 1, 1 )
	textBox:spool()

	charProp:setColor( 0, 0, 0, 0 ) 
	textBox:setColor( 0, 0, 0, 0 )

	local anim = MOAICoroutine.new()
	anim:run( function()
		
		helper.waitFor( charProp:seekColor( 1, 1, 1, 1, EFFECT_DELAY ),
						textBox:seekColor( 1, 1, 1, 1, EFFECT_DELAY ) )

		helper.delay( delay )
		
		charProp:seekColor( 0, 0, 0, 0, EFFECT_DELAY )
		textBox:seekColor( 0, 0, 0, 0, EFFECT_DELAY )
	end )

end


---------------------------------------------------------------------------------------------------
-- Getters 
---------------------------------------------------------------------------------------------------

function M.getPartition()
	
	return partition
end

----------------------------------------------------------------------------------------------------
return M