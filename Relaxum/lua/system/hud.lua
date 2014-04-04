--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--=================================================================================================

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local layer
local partition

local menuButton

local scoreText
local lifeText
local livesText
local countText

local progressScissorRect, pb_w, pb_h, pb_x, pb_y, pb_action
local heartScrissorRect, ht_w, ht_h, ht_x, ht_y, ht_action

local changeParticle


---------------------------------------------------------------------------------------------------
-- Global Functions
---------------------------------------------------------------------------------------------------

-- Initialization ---------------------------------------------------------------------------------

function M.init()

	resources.loadSpriteSheet( "assets/sheets/perm_sheet_1" )

	layer = display.newLayer( CAMERA_FIXED, 800 )
	partition = layer:getPartition()

	-- Upper Left Corner -------

	-- Progress Bar -----------------------------------------------------


	ht_x, ht_y = MIN_X + 60, MAX_Y - 60
	resources.newSprite( 'heart_bk', layer, ht_x + 2 , ht_y - 8 )
	local heart = resources.newSprite( 'heart', layer, ht_x, ht_y )

	ht_h = resources.getSpriteConfig( 'heart' ).spriteSourceSize.height
	ht_w = resources.getSpriteConfig( 'heart' ).spriteSourceSize.width

  	heartScrissorRect = MOAIScissorRect.new()
  	heartScrissorRect:setRect( ht_x - ( ht_w / 2), ht_y - ( ht_h / 2 ),
  							     ht_x + ( ht_w / 2), ht_x + ( ht_h / 2 ) )

  	heartScrissorRect:setLoc( 0, ht_h, 1, 2.5 )

	heart:setScissorRect(heartScrissorRect)



	pb_x, pb_y =  MIN_X + 260, MAX_Y - 40

	resources.newSprite( 'progress_bar_bk', layer, pb_x, pb_y - 6 )

	local progressBar = resources.newSprite( 'progress_bar', layer, pb_x, pb_y )

	pb_h = resources.getSpriteConfig( 'progress_bar' ).spriteSourceSize.height
	pb_w = resources.getSpriteConfig( 'progress_bar' ).spriteSourceSize.width

  	progressScissorRect = MOAIScissorRect.new()
  	progressScissorRect:setRect( pb_x - ( pb_w / 2), pb_y - ( pb_h / 2 ),
  							     pb_x + ( pb_w / 2), pb_y + ( pb_h / 2 ) )

  	progressScissorRect:setLoc( -pb_w, 0, 1, 2.5 )

	progressBar:setScissorRect(progressScissorRect)

	-- Target Objects -----------------------------------------------------
	objectsCountText = gui.newTextBox( '<b>' .. tostring( player.getObjectsCount() ) ..'</>' ..
							           '<sb>/' .. tostring( level.getTargetCount() ) ..'</>',
								  	   MIN_X + 200, MAX_Y - 90,
								  	   180, 70,
									   1, 1, 1, 0.9 )


	-- Upper Right Corner -------

	local pauseButton = resources.newSprite( "pause_button", layer, MAX_X - 50, MAX_Y - 55 )
	pauseButton:setScl( 0.8, 0.8 )

	scoreText = gui.newTextBox( '<lb>' .. tostring( player.getScore() ) .. '</>' ,
								MAX_X - 450, MAX_Y - 52,
								370, 70,
								1, 1, 1, 0.9 )

	scoreText:setAlignment( MOAITextBox.RIGHT_JUSTIFY,
						    MOAITextBox.RIGHT_JUSTIFY )

	local trophy = resources.newSprite( 'trophy', layer,
										MAX_X - 215, MAX_Y - 59 )


	-- Lower Left Corner -------

	livesText = gui.newTextBox( tostring( player.getLives() ),
										  -100, 190, 70, 50,
										  1, 1, 1, 0.9 )


	lifeText = gui.newTextBox( tostring( player.getLife() ),
						    			 -200, 190, 70, 50,
										 1, 1, 1, 0.9 )

	-- Lower Right Corner -------

	layer:insertProp( objectsCountText )
	layer:insertProp( scoreText )
	--layer:insertProp( livesText )
	changeParticle = particles.new( 'time', 'assets/particles/glitter4.pex', layer )
end

function M.refresh()

    local progress = player.getObjectsCount() / level.getTargetCount()

	if progress > 1 then
		progress = 1
	end

	if pb_action and pb_action:isBusy() then
		pb_action:stop()
	end

	pb_action = progressScissorRect:seekLoc( -pb_w + (pb_w * progress) , 0, 1, 0.5, MOAIEaseType.EASE_IN )
	--display.newSpanAnimation( heart, 0.5, MOAITimer.NORMAL, EASE_IN, MOAIColor.ATTR_R_COL, {
	--	1, 0, 1, 0
	--	} )

	changeParticle:surge( 20,  pb_x - ( pb_w / 2 ) + (pb_w * progress) , pb_y  )


	local life = player.getLife()

	if life < 0 then
		life = 0
	end

	hb_action = heartScrissorRect:seekLoc( 0, (ht_h / 100) * life, 1, 0.5, MOAIEaseType.EASE_IN )



	scoreText:setString( '<lb>' .. tostring( player.getScore() ) .. '</>' )

	objectsCountText:setString( '<b>' .. tostring( player.getObjectsCount() ) .. '</>' ..
							    '<sb> / ' .. tostring( level.getTargetCount() ) ..'</>' )



	--livesText:setString( tostring( player.getLives() ) )
end

function M.destroy()
	layer:clear()
end


-- Text NEEDS CHANGE ---------------------------------------------------------------------------------==========

function M.addMainText( text )
	local text = gui.newTextBox(text, 'f1', 'large', layer,
								0, 0, 300, 200,
								1, 1, 1, 0.8 )

	text:setAlignment( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
end

function M.addCharacterText( delay, text, effect )

	local EFFECT_DELAY = 4

	local height = 100

	local charProp = display.newImage( 'assets/images/character3.png', layer,
									   - HALF_WIDTH + 60 , - HALF_HEIGHT + height , 130, 200 )

	local textBox = display.newTextBox( text, 'f1', 'medium', layer,
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