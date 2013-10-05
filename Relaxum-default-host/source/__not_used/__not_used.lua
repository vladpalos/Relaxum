color_action =  myPropD:seekColor(-1,-1,-1,0,5.0)

     color_action:setListener ( MOAIAction.EVENT_STOP, actionDone )

 


-- To slow --
--  local colors = { {0.666666667, 0.690196078, 1.0},
--                   {0.666666667, 0.690196078, 1.0},
--                   {0.152941176, 0.235294118, 0.631372549},
--                   {0.152941176, 0.235294118, 0.631372549} }

--  local colors = { {0, 0, 0},
--                   {0, 0, 0},
--                   {0.022941176, 0.115294118, 0.511372549},
--                   {0.022941176, 0.115294118, 0.511372549} }


function M.newLinearGradientRect( layer, x1, y1, x2, y2, c )

    local vertexFormat = MOAIVertexFormat.new()

    -- Moai's default shaders expect loc, uv, color
    vertexFormat:declareCoord( 1, MOAIVertexFormat.GL_FLOAT, 2 )
    vertexFormat:declareColor( 2, MOAIVertexFormat.GL_UNSIGNED_BYTE )

    local vbo = MOAIVertexBuffer.new()

    vbo:setFormat( vertexFormat )
    vbo:reserveVerts( 4 )

    vbo:writeFloat( x1, y1 )
    vbo:writeColor32( c[1][1], c[1][2], c[1][3] )

    vbo:writeFloat( x2, y1 )
    vbo:writeColor32( c[2][1], c[2][2], c[2][3] )

    vbo:writeFloat( x2, y2 )
    vbo:writeColor32( c[3][1], c[3][2], c[3][3] )

    vbo:writeFloat( x1, y2 )
    vbo:writeColor32( c[4][1], c[4][2], c[4][3] )

    vbo:bless()

    local mesh = MOAIMesh.new()
    mesh:setVertexBuffer( vbo )
    mesh:setPrimType( MOAIMesh.GL_TRIANGLE_FAN )

    if MOAIGfxDevice.isProgrammable () then
        local shader = MOAIShader.new( )

        shader:reserveUniforms( 1 )
        shader:declareUniform( 1, 'transform', MOAIShader.UNIFORM_WORLD_VIEW_PROJ )

        shader:setVertexAttribute( 1, 'position' )
        shader:setVertexAttribute( 2, 'color' )

        shader:load( resources.loadShaderFiles( 'assets/shaders/gradient' ) )
        mesh:setShader( shader )
    end

    prop = MOAIProp2D.new()
    prop:setDeck( mesh )
    layer:insertProp( prop )
end


--  Effects ----------------------------------------------------------------------------------------

function M.shakeProp( prop, delta, speed, count )

    local curve = MOAIAnimCurve.new()
    local ease = MOAIEaseType.EASE_IN
    local dt = prop:getLoc()

    if count == -1 or count == 0 then count = 100 end

    curve:reserveKeys( count )

    for i = 1, count do
        if math.mod( i, 2 ) == 0 then
            curve:setKey( i, (i - 1) * speed, dt - delta, ease )
        else
            curve:setKey( i, (i - 1) * speed, dt + delta, ease )
        end
    end

    local anim = MOAIAnim:new()
    anim:reserveLinks( 1 )
    anim:setLink( 1, curve, prop, MOAITransform2D.ATTR_X_LOC )
    anim:setMode( MOAITimer.LOOP )
    anim:start()
    return anim
end


-- NOT WORKING
-- Creates a grid that fills the whole map on layer with brush from deck's index.
function M.fillBackground( name, layer ) 

    local deck, index = resources.findSprite( name )

    deck:setRect(index, 0, 0, 50, 50)

    local mx, my = map.getDims()

    local factor = 1
    while factor * 512 <= mx and factor * 512 <= my do
        factor = factor + 1
    end 

    local grid = MOAIGrid.new()
    grid:setSize( factor, factor, 50, 50 )

    for i = 1, factor do
        for j = 1, factor do
            grid:setTile( j, i, index )
        end
    end

    local gridDeck = MOAIGridDeck2D.new()
    gridDeck:reserveBrushes( 1 )
    gridDeck:setGrid( grid )
    gridDeck:setDeck( deck )

    local prop = MOAIProp2D.new()
    prop:setDeck( gridDeck )

    local aux = (factor * 512) / 2
    prop:setLoc( -605, 0 )

    layer:insertProp( prop )

    return prop, grid
    
end


---- Gradient fillBackground

    -- Gradient

--  local colors = { {0.666666667, 0.690196078, 1.0},
--                   {0.666666667, 0.690196078, 1.0},
--                   {0.152941176, 0.235294118, 0.631372549},
--                   {0.152941176, 0.235294118, 0.631372549} }

--  local colors = { {0.5, 0.5, 1.0},
--                   -{0.666666667, 0.690196078, 1.0},
--                   {0.022941176, 0.115294118, 0.511372549},
--                   {0.022941176, 0.115294118, 0.511372549} }

--  resources.loadSpriteSheet( 'assets/sheets/tiles_background' )

--  local color = display.fillBackground( 'white', M.backgroundLayer )
--  color:setColor( 0.6, 0, 0, 1 )

    --display.newImageRect( M.backgroundLayer, 0, 0, 512, 512, 1, 1, 1, 1 )



    --local noise = display.fillBackground( 'noise_1', M.backgroundLayer )

--[[    display.newLinearGradientRect( M.backgroundLayer, -mx/2, -my/2, mx/2, my/2, colors )

    -- Noise Pattern
    -- We are not using resource.loadSpriteSheet here because we need to make the texture repeat
    -- itself on the hole screen.
    local texture = resources.loadSpriteSheet( 'assets/sheets/tiles_background' )
    local background, deck, index = resources.newSprite( "background_tile_1", 
                                                          M.backgroundLayer, 0, 0 )

    local factor = 1
    while factor * 512 <= mx or factor * 512 <= my do
          factor = factor + 1
    end

    local halfSize = 512 * factor / 2
    texture:setWrap( true )
    deck:setUVRect( index, 0, factor, factor, 0 )
    deck:setRect( index, - halfSize, - halfSize, halfSize, halfSize )
--]]
--  local colors = { {0, 0, 0},
--                   {0, 0, 0},
--                   {0.022941176, 0.115294118, 0.511372549},
--                   {0.022941176, 0.115294118, 0.511372549} }
--[[
    -- Gradient
    texture = resources.loadSpriteSheet( 'assets/sheets/tiles_effects' )
    _, deck, index = resources.newSprite( 'gradient_64x1024',
                                           M.backgroundLayer, 0, 0 )
    factor = 1
    while factor * 64 <= mx do
        factor = factor + 1
    end

    halfSize = 64 * factor / 2
    texture:setWrap( true )
    deck:setUVRect( index, 0, factor, 1, 0 )
    deck:setRect( index, - halfSize, - 512, halfSize, 512 )


    -- Color and Noise Pattern
    texture = resources.loadSpriteSheet( 'assets/sheets/tiles_background' )

    factor = 1
    while factor * 512 <= mx or factor * 512 <= my do
          factor = factor + 1
    end
    halfSize = 512 * factor / 2

    texture:setWrap( true )
    

    local sprite
    
    _, colorDeck, colorIndex = resources.newSprite( "white",
                                                    M.backgroundLayer, 0, 0 )
    sprite, noiseDeck, noiseIndex = resources.newSprite( "background_tile_1",
                                                    M.backgroundLayer, 0, 0 )
sprite:setColor( 1, 0, 0, 1 )
    
    noiseDeck:setUVRect( noiseIndex, 0, factor, factor, 0 )
    noiseDeck:setRect( noiseIndex, - halfSize, - halfSize, halfSize, halfSize )

    colorDeck:setUVRect( colorIndex, 0, factor, factor, 0 )
    colorDeck:setRect( colorIndex, - halfSize, - halfSize, halfSize, halfSize )
--]]
