--=================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc. 
-- 	All Rights Reserved. 
-- 	http://www.redfruits.com
--=================================================================================================

---------------------------------------------------------------------------------------------------
-- Global general-purpose constants
---------------------------------------------------------------------------------------------------

HALF_WIDTH              = (SCREEN_WIDTH * 0.5)
HALF_HEIGHT             = (SCREEN_HEIGHT * 0.5)

MIN_X                   = - HALF_WIDTH
MAX_X                   = HALF_WIDTH
MAX_Y                   = HALF_HEIGHT
MIN_Y                   = - HALF_HEIGHT

SCREEN_SHAKE_POWER_X    = 0.1
SCREEN_SHAKE_POWER_Y    = 0.1

OBJ_GOOD                = 1
OBJ_BAD                 = 2
OBJ_GROW                = 3

-- Animation Constants
EASE_IN                 = MOAIEaseType.EASE_IN 
EASE_OUT                = MOAIEaseType.EASE_OUT	
FLAT                    = MOAIEaseType.FLAT
LINEAR                  = MOAIEaseType.LINEAR
SHARP_EASE_IN           = MOAIEaseType.SHARP_EASE_IN
SHARP_EASE_OUT          = MOAIEaseType.SHARP_EASE_OUT
SHARP_SMOOTH 	        = MOAIEaseType.SHARP_SMOOTH
SMOOTH 			        = MOAIEaseType.SMOOTH
SOFT_EASE_IN 	        = MOAIEaseType.SOFT_EASE_IN
SOFT_EASE_OUT           = MOAIEaseType.SOFT_EASE_OUT
SOFT_SMOOTH             = MOAIEaseType.SOFT_SMOOTH

CAMERA_FIXED            = 1
CAMERA_MOVING           = 2

---------------------------------------------------------------------------------------------------
-- BOX2d Collision bits
---------------------------------------------------------------------------------------------------

CATEGORY_NONE           = 0
CATEGORY_ALL            = 65535

CATEGORY_PLAYER         = math.pow( 2, 0 )
CATEGORY_OBSTACLE       = math.pow( 2, 1 )
CATEGORY_GOOD           = math.pow( 2, 2 )
CATEGORY_BAD            = math.pow( 2, 3 )
CATEGORY_ASSETS         = math.pow( 2, 4 )

MASK_SOLID              = CATEGORY_ALL
MASK_OBSTACLE           = CATEGORY_ALL
MASK_PLAYER             = CATEGORY_ALL
MASK_GOOD               = CATEGORY_PLAYER + CATEGORY_OBSTACLE
MASK_BAD                = CATEGORY_PLAYER + CATEGORY_OBSTACLE

---------------------------------------------------------------------------------------------------
-- global function overrides
---------------------------------------------------------------------------------------------------

function error(...)  
    io.write('\027[31m--> ERROR : ')
    print(...)
    io.write('\027[0m\n')
end

function warn(...)  
    io.write('\027[33m--> WARNING : ')
    print(...)
    io.write('\027[0m\n')
end

function info(...)  
    io.write('\027[34m--> INFO: ')    
    print(...)
    io.write('\027[0m\n')
end

function title(...)  
    io.write('\027[34m========================================================================\n')    
    print(...)
    io.write('\n========================================================================\027[0m\n')
end

function colorPrint(color, ...)
    io.write('\027[' .. color .. 'm')    
    print(...)
    io.write('\027[0m')
end