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

local DAMAGE                = 10

local DEFAULT_SPEED         = 1
local DEFAULT_TIMER_MODE    = "LOOP"
local DEFAULT_EASE_TYPE     = "EASE_IN"

local RADIUS                = 33

local ROT_TIME              = 0.5
local CUT_TIME              = 0.3
local BLADE_ROT             = 15

local ROT_CORRECTION        = 16    -- Degrees of rotation error correction (if any)

local sheet, layer

function M.load()
    layer = level.getLayer()

    resources.loadSpriteSheet( "assets/sheets/objects_sheet_1" )
    resources.loadPolysSheet( "assets/physics/objects" )

    -- stars = particles.new( "time", "assets/particles/glitter2.pex", layer )
end

function M.add( conf )

    local timerMode = conf.properties   and conf.properties.timerMode   or DEFAULT_TIMER_MODE
    local easeType = conf.properties    and conf.properties.easeType    or DEFAULT_EASE_TYPE
    local speed = conf.properties       and conf.properties.speed       or DEFAULT_SPEED

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y )
    local fixture = body:addCircle( 0, 0, RADIUS )

    fixture:setFilter( CATEGORY_BAD, MASK_BAD )
    fixture:setCollisionHandler( _onCollision, MOAIBox2DArbiter.BEGIN )
    fixture:setSensor( true )

    --body:resetMassData()

    local prop = MOAIProp2D.new()
    local scissorsTop = resources.newSprite('scissors_01_top', layer, 4, 0 )
    local scissorsBottom = resources.newSprite( 'scissors_01_bottom', layer, 0, 0 )

    scissorsTop:setParent( prop )
    scissorsBottom:setParent( prop )
    scissorsTop:setPriority( 2 )
    scissorsBottom:setPriority( 1 )

    prop:setParent( body )

    -- Movement and Animation

    local pathPoints = conf.polyline

    local xCurve = MOAIAnimCurve.new()
    local yCurve = MOAIAnimCurve.new()

    xCurve:reserveKeys( #pathPoints + 1 )
    yCurve:reserveKeys( #pathPoints + 1 )

    for n, point in ipairs( pathPoints ) do
        print(n, point.x, point.y)
        xCurve:setKey( n, speed * (n - 1), point.x + conf.x, MOAIEaseType[easeType] )
        yCurve:setKey( n, speed * (n - 1), - point.y + conf.y, MOAIEaseType[easeType] )
    end

    -- Inser one more keyframe from the end to the beggining of polygon line
    local n = #pathPoints + 1
    xCurve:setKey( n, speed * ( n - 1 ), pathPoints[1].x + conf.x, MOAIEaseType[easeType] )
    yCurve:setKey( n, speed * ( n - 1 ), - pathPoints[1].y + conf.y, MOAIEaseType[easeType] )

    local bx, by = body:getPosition()
    local movement = MOAIAnim.new ()
    movement:reserveLinks( 2 )
    movement:setLink( 1, xCurve, body, MOAITransform.ATTR_X_LOC )
    movement:setLink( 2, yCurve, body, MOAITransform.ATTR_Y_LOC )
    movement:setCurve( xCurve )
    movement:setMode( MOAITimer[timerMode] )

    body:setTransform( bx, by, ROT_CORRECTION )

    movement:setListener( MOAITimer.EVENT_TIMER_KEYFRAME, function ( self, i, t, v )
        if i ~= #pathPoints + 1 then

            local point, nextPoint = i, i + 1
            if i == #pathPoints then
                point, nextPoint = #pathPoints, 1
            end

            local dx, dy = pathPoints[nextPoint].x, pathPoints[nextPoint].y
            local x, y = pathPoints[point].x, pathPoints[point].y

            local lastRot = prop:getRot()
            local rot = math.deg( math.atan2( x - dx, y - dy ) )

            -- Make the scissors turn less
            local lastRotInverse = math.fmod( lastRot - 360, 360 )
            if math.abs( rot - lastRot ) > math.abs( rot - lastRotInverse ) then
                prop:setRot( lastRotInverse )
            end

            prop:seekRot( rot, ROT_TIME )
        end
    end )

    -- Create the scissors animations and attach them to the
    -- movement animation so we can take care of only the movement animation.

    display.newSpanAnimation( scissorsTop, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              -BLADE_ROT, BLADE_ROT, -BLADE_ROT) :attach( movement )
    display.newSpanAnimation( scissorsBottom, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              BLADE_ROT, -BLADE_ROT, BLADE_ROT) :attach( movement )
    movement:start()

    -- Object Configuration
    body.type = conf.type
    body.conf = conf
    body.prop = { scissorsTop, scissorsBottom, prop }
    body.movement = movement

    body.remove = function ( self )
        display.deleteProps( layer, body.prop )
        body.movement:stop()
        self:destroy()
    end
end

---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function _onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()

    if bodyA.type == "scissors" and bodyB.type == "player" then
        local posX, posY = bodyA:getPosition()
        player.hit( DAMAGE, -posX * 15, -posY * 15)
    end
end

----------------------------------------------------------------------------------------------------
return M


