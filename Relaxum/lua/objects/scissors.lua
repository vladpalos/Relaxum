--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================


--[[--------------------------------------------------------------------------------------------------
    The scissors are made out of a polyline wich is actually a path. 
    The scissors walk that path in a loop timer.

    Scissors have a circle shaped body.
    ... 
    TODO
--]]--------------------------------------------------------------------------------------------------

local M = {}

local DAMAGE = 2

local DEFAULT_SPEED = 1

local RADIUS = 33

local ROT_TIME = 3
local CUT_TIME = 0.3
local BLADE_ROT = 15

local sheet, layer

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    updateThread = MOAICoroutine.new()

    -- stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y, 16 )
    local fixture = body:addCircle( 0, 0, RADIUS )

    fixture:setFilter( CATEGORY_BAD, MASK_BAD )
    fixture:setCollisionHandler( _onCollision, MOAIBox2DArbiter.BEGIN )  
    fixture:setSensor( true )

    body:resetMassData()

    local prop = MOAIProp2D.new()
    local scissorsTop = resources.newSprite('scissors_01_top', layer, 4, 0 )
    local scissorsBottom = resources.newSprite( 'scissors_01_bottom', layer, 0, 0 )

    scissorsTop:setParent( prop )
    scissorsBottom:setParent( prop )
    scissorsTop:setPriority( 2 )
    scissorsBottom:setPriority( 1 )

    prop:setParent( body )

    -- Follow path and scissor animation

    local pathPoints = conf.polyline
    local speed = conf.properties and conf.properties.speed or DEFAULT_SPEED
    
    local xCurve = MOAIAnimCurve.new()
    local yCurve = MOAIAnimCurve.new()

    xCurve:reserveKeys( #pathPoints + 1 )
    yCurve:reserveKeys( #pathPoints + 1 )

    for n, point in ipairs( pathPoints ) do
        xCurve:setKey( n, speed * (n - 1), point.x + conf.x )
        yCurve:setKey( n, speed * (n - 1), - point.y + conf.y )
    end

    local n = #pathPoints + 1
    xCurve:setKey( n, speed * n , pathPoints[1].x + conf.x )
    yCurve:setKey( n, speed * n , - pathPoints[1].y + conf.y )
    
    local movement = MOAIAnim.new ()
    movement:reserveLinks( 2 )
    movement:setLink( 1, xCurve, body, MOAITransform.ATTR_X_LOC )
    movement:setLink( 2, yCurve, body, MOAITransform.ATTR_Y_LOC )
    
    local timerType = conf.properties and conf.properties.timerType or "LOOP"
    movement:setMode( MOAITimer.LOOP )
    
    movement:setCurve( xCurve )
    movement:setListener( MOAITimer.EVENT_TIMER_KEYFRAME, function ( self, i, t, v ) 
        if i ~= #pathPoints + 1 then 

            local point, nextPoint = i, i + 1
            if i == #pathPoints then 
                point, nextPoint = #pathPoints, 1
            end

            local dx, dy = pathPoints[nextPoint].x, pathPoints[nextPoint].y      
            local x, y = pathPoints[point].x, pathPoints[point].y
            
            local rot = math.atan2( x - dx, y - dy )
            prop:seekRot( math.deg( rot ), 0.3 )
        end
    end )

    display.newSpanAnimation( scissorsTop, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              -BLADE_ROT, BLADE_ROT, -BLADE_ROT) :start()
    display.newSpanAnimation( scissorsBottom, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,        
                              BLADE_ROT, -BLADE_ROT, BLADE_ROT) :start()
    movement:start()

    -- Object Configuration
    body.type = conf.type
    body.conf = conf
    body.prop = { scissorsTop, scissorsBottom, prop }
    body.anim = anim
    body.remove = function ( self )
            
        display.removeProps( layer, body.prop )
  --      self:destroy()
    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function _onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()

    if bodyA.type == "scissors" and bodyB.type == "brick" then       
        if bodyA.coroutine then 
        end
    end    
end



----------------------------------------------------------------------------------------------------
return M


