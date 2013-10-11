--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc.
--  All Rights Reserved.
--  http://www.redfruits.com
--==================================================================================================

local M = {}

local VELOCITY_FACTOR = 25

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

    object.addB2DEditorFixtures( "scissors_01", body, CATEGORY_BAD, MASK_BAD, M.onCollision )

    local scissorsTop = resources.newSprite('scissors_01_top', layer, -8, 0 )
    local scissorsBottom = resources.newSprite( 'scissors_01_bottom', layer, 0, 0 )

    scissorsTop:setParent( body )
    scissorsBottom:setParent( body )

    local rot = 15
    local time = 0.2

    display.newSpanAnimation( scissorsTop, time, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,
                              -rot, rot, -rot) :start()
    display.newSpanAnimation( scissorsBottom, time, MOAITimer.LOOP,  MOAIEaseType.EASE_IN,  MOAITransform.ATTR_Z_ROT,        
                              rot, -rot, rot) :start()

    body.speedX = 0 -- math.random(2, 10)
    body.speedY = 3 --math.random(2, 5)

    body:setLinearVelocity( body.speedX * VELOCITY_FACTOR,
                            body.speedY * VELOCITY_FACTOR )

    body.type = conf.type
    body.conf = conf
    body.prop = prop

    body.coroutine = MOAICoroutine.new()

    body.remove = function ( self )
        
        if self.prop ~= nil then
            layer:removeProp( self.prop )
            self.prop = nil
        end

        layer:removeProp( self.propCracked )
        self:destroy()
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
                switchDirection( bodyA )                
            end )
        end
    end    
end



---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

function switchDirection( body ) 

    local px, py = body:getPosition()
    local angle = 180

    body:setTransform(px, py, angle)
    body:setLinearVelocity( - body.speedX * VELOCITY_FACTOR,
                            - body.speedY * VELOCITY_FACTOR )
    --local x, y = body:getPosition()
    --body:setTransform(x , y, 20)
end

----------------------------------------------------------------------------------------------------
return M
