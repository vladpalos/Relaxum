--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================


--[[--------------------------------------------------------------------------------------------------
    The scissors are made out of a polyline wich is actually a path. 
    The scissors walk that path in a loop timer.
    ... 
    TODO
--]]--------------------------------------------------------------------------------------------------

local M = {}

local SPEED = 1

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

    local body = display.addBody( MOAIBox2DBody.DYNAMIC, conf.x, conf.y )

    object.addB2DEditorFixtures( "scissors_01", body, CATEGORY_BAD, MASK_BAD, M.onCollision, true )

    body:resetMassData()

    local prop = MOAIProp2D.new()
    local scissorsTop = resources.newSprite('scissors_01_top', layer, -8, 0 )
    local scissorsBottom = resources.newSprite( 'scissors_01_bottom', layer, 0, 0 )

    scissorsTop:setParent( prop )
    scissorsBottom:setParent( prop )
    prop:setParent( body )

    display.newSpanAnimation( scissorsTop, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              -BLADE_ROT, BLADE_ROT, -BLADE_ROT) :start()
    display.newSpanAnimation( scissorsBottom, CUT_TIME, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,        
                              BLADE_ROT, -BLADE_ROT, BLADE_ROT) :start()


    local pathPoints = conf.polyline
    
    local xCurve = MOAIAnimCurve.new()
    local yCurve = MOAIAnimCurve.new()

    xCurve:reserveKeys( #pathPoints + 1 )
    yCurve:reserveKeys( #pathPoints + 1 )

    for n, point in ipairs( pathPoints ) do
        xCurve:setKey( n, SPEED * (n - 1), point.x + conf.x )
        yCurve:setKey( n, SPEED * (n - 1), - point.y + conf.y )
    end

    local n = #pathPoints + 1
    xCurve:setKey( n, SPEED * n , pathPoints[1].x + conf.x )
    yCurve:setKey( n, SPEED * n , - pathPoints[1].y + conf.y )
    
    local anim = MOAIAnim.new ()
    anim:reserveLinks( 2 )
    anim:setLink( 1, xCurve, body, MOAITransform.ATTR_X_LOC )
    anim:setLink( 2, yCurve, body, MOAITransform.ATTR_Y_LOC )
    
    local timerType = conf.properties and conf.properties.timerType or "LOOP"
    anim:setMode( MOAITimer.LOOP )
    
    anim:setCurve( xCurve )
    anim:setListener( MOAITimer.EVENT_TIMER_KEYFRAME, function ( self, i, t, v ) 
        if i ~= #pathPoints + 1 then 

            local point, nextPoint = i, i + 1
            if i == #pathPoints then 
                point, nextPoint = #pathPoints, 1
            end

            print (point, nextPoint)
            local dx, dy = pathPoints[nextPoint].x, pathPoints[nextPoint].y      
            local x, y = body:getPosition()
    
            local rot = math.atan2( x - dx, -y + dy )
            prop:moveRot( math.deg( rot ) - 120, 0.3 )
        end
    end )

    anim:start()

    body.type = conf.type
    body.conf = conf
    body.props = { scissorTop, scissorsBottom }
    --body.xCurve = xCurve
    --body.yCurve = yCurve
    --body.timer = timer
    body.coroutine = MOAICoroutine.new()

    body.remove = function ( self )
        
--        display.removeProps( layer, body.props )
  --      self:destroy()
    end
end

function M.onCollision( ev, fixA, fixB, arbiter )

    local bodyA, bodyB = fixA:getBody(), fixB:getBody()

    if bodyA.type == "scissors" and bodyB.type == "brick" then       
    
        -- Box2d doesn't accept body updates during collision handle so we lazy-update them
        -- This leaves room for performance improvement. We can have a single coroutine to 
        -- update all scissors.
        -- IMPROVEMENT: Performance
    
        if bodyA.coroutine then 
            bodyA.coroutine:stop()
            bodyA.coroutine:run( function () 
       --         coroutine:yield()
         --       switchDirection( bodyA )                
            end )
        end
    end    
end



---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function _changeDirection(  self, i ) 

    local px, py = body:getPosition()
    local vx, vy = body:getLinearVelocity()

    local lastAngle = body:getAngle()
    local angle = -180 + lastAngle

    body:setTransform( px, py, angle )
    body.prop:setRot( -angle, ROT_TIME )
    body.prop:moveRot( angle, ROT_TIME )

--    if (vx < 0)

    print(vx, vy)
    vx = vx < 0 and -1 or 1 
    vy = vy < 0 and -1 or 1 
    body:setLinearVelocity( vx * body.speedX * VELOCITY_FACTOR,
                            vy * body.speedY * VELOCITY_FACTOR )

--    body:setTransform(px, py, angle)
  --  body:setLinearVelocity( - body.speedX * VELOCITY_FACTOR,
    --                        - body.speedY * VELOCITY_FACTOR )
    --local x, y = body:getPosition()
    --body:setTransform(x , y, 20)
end

----------------------------------------------------------------------------------------------------
return M


