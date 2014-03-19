--=================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--=================================================================================================

---------------------------------------------------------------------------------------------------
-- Global device configuration
---------------------------------------------------------------------------------------------------
APP_TITLE                       = "SpaceGenius"

DISABLE_PARTICLES               = false


-- This is the debug option
-- Can be one of: 0 - Disabled
--                1 - Low
--                2 - Medium
--                3 - Full

DEBUG                           = 0



-- [[
-- GalaxyS
---------------------------------------------------------------------------------------------------
SCREEN_WIDTH                    = 960
SCREEN_HEIGHT                   = 640

SCREEN_UNITS_X                  = 960
SCREEN_UNITS_Y                  = 640

DEVICE_WIDTH                    = 960
DEVICE_HEIGHT                   = 640
-- ]]


-- Iphone4
---------------------------------------------------------------------------------------------------
--[[
SCREEN_WIDTH                    = 960
SCREEN_HEIGHT                   = 640

SCREEN_UNITS_X                  = SCREEN_WIDTH
SCREEN_UNITS_Y                  = SCREEN_HEIGHT

DEVICE_WIDTH                    = 960
DEVICE_HEIGHT                   = 640

local screenWidth = MOAIEnvironment.horizontalResolution or 320
local screenHeight = MOAIEnvironment.verticalResolution or 480
local viewScale = screenWidth >= 640 and 2 or 1
-- ]]


-- General
---------------------------------------------------------------------------------------------------

DISPLAY_FPS                     = 60

INPUT_DOWN                      = 0
INPUT_MOVE                      = 1
INPUT_UP                        = 2


