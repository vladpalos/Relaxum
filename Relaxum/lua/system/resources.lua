--==================================================================================================
--  Copyright (c) 2010-2012 Red Fruits Games, Inc. 
--  All Rights Reserved. 
--  http://www.redfruits.com
--==================================================================================================

local M = {}

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

-- Cache
local SHEETS = {}                      -- GFX 2d quad decks
local POLYS_SHEETS = {}                 -- Box2d polygon object definitions
local FONTS = {}

----------------------------------------------------------------------------------------------------
-- Global functions 
----------------------------------------------------------------------------------------------------
-- Sprite Sheets with TexturePacker
-- This function will create a deck 2D tiled map object that has a `names` proeprty. To use it you
-- would create a prop, set the object as the prop's deck, and set the index at names['sprite.png'].
-- See newSprite for an example.
function M.loadSpriteSheet( path )

    if not path then 
        error("Please check the required arguments of loadSpriteSheet function.")
        return 
    end

    local lua = path .. ".lua"
    local png = path .. ".png"

    if SHEETS[png] then 
        return 
    end

    local frames = dofile( lua ).frames

    local tex = MOAITexture.new()
    tex:load( png )

    local xtex, ytex = tex:getSize()
    
    -- Annotate the frame array with uv quads and geometry rects
    for i, frame in ipairs( frames ) do
        -- convert frame.uvRect to frame.uvQuad to handle rotation
        local uv = frame.uvRect
        local q = {}
        if not frame.textureRotated then
            -- From Moai docs: "Vertex order is clockwise from upper left (xMin, yMax)"
            q.x0, q.y0 = uv.u0, uv.v0
            q.x1, q.y1 = uv.u1, uv.v0
            q.x2, q.y2 = uv.u1, uv.v1
            q.x3, q.y3 = uv.u0, uv.v1
        else
            -- Sprite data is rotated 90 degrees CW on the texture
            -- u0v0 is still the upper-left
            q.x3, q.y3 = uv.u0, uv.v0
            q.x0, q.y0 = uv.u1, uv.v0
            q.x1, q.y1 = uv.u1, uv.v1
            q.x2, q.y2 = uv.u0, uv.v1
        end
        frame.uvQuad = q
 
        -- convert frame.spriteColorRect and frame.spriteSourceSize
        -- to frame.geomRect.
        -- MUZZEDIT. Trimming now works, and images are centered
 
        local cr = frame.spriteColorRect
        local r = {}
        r.x0 = cr.x
        r.y0 = cr.y + cr.height
        r.x1 = cr.x + cr.width
        r.y1 = cr.y  
        r.x0 = r.x0 - frame.spriteSourceSize.width / 2
        r.y0 = - r.y0 + frame.spriteSourceSize.height / 2
        r.x1 = r.x1 - frame.spriteSourceSize.width / 2
        r.y1 = - r.y1 + frame.spriteSourceSize.height / 2
 
        frame.geomRect = r 
    end

    -- Construct the deck
    local deck = MOAIGfxQuadDeck2D.new()
    deck:setTexture( tex )
    deck:reserve( #frames )
    local names = {}
    local config = {}
    for i, frame in ipairs( frames ) do
        local q = frame.uvQuad
        local r = frame.geomRect
        names[frame.name] = i
        config[frame.name] = frame
        deck:setUVQuad( i, q.x0, q.y0, q.x1, q.y1, q.x2, q.y2, q.x3, q.y3 )
        deck:setRect( i, r.x0, r.y0, r.x1, r.y1 )
    end

    -- Check if a sprite name exists in more then one sheet
    local i, j, k
    for i, _ in pairs( SHEETS ) do 
        for j, _ in pairs( SHEETS[i].names ) do 
            for k, _ in pairs( names ) do         
                if k == j then                     
                    error("The sheet " .. path .. " contains the sprite " .. k .. 
                          " that is allready defined in " .. i .. " !")
                    error("Please rename the sprite!")
                end
            end
        end
    end

    SHEETS[png] = deck
    SHEETS[png].names = names
    SHEETS[png].config = config

    return tex
end

-- This function returns the deck and the index of sprite with name if found.
function M.findSprite( name )

    local k,v
    for k, v in pairs( SHEETS ) do               
        if SHEETS[k].names[name] then            
            return SHEETS[k], SHEETS[k].names[name]
        end
    end
    warn( "The sprite " .. name .. " is not founded in any loaded sprite sheet file. " ..
          "Please load the sprite sheet that contains this sprite." )
    return 
end


-- This function returns a fresh new prop with the sprite name found in sprite sheets. 
-- The sprite names should all be unique.
function M.newSprite( name, layer, x, y )   
    
    local deck, index = M.findSprite( name )

    local prop = MOAIProp2D.new()            
    prop:setDeck( deck )
    prop:setIndex( index )
    prop:setLoc( x, y )

    if layer ~= nil then
        layer:insertProp( prop )
    end

    return prop
end

function M.getSpriteConfig( name )
    local k,v
    for k,v in pairs( SHEETS ) do               
        if SHEETS[k].config[name] then            
            return SHEETS[k].config[name]
        end
    end
    warn( "The sprite " .. name .. " is not founded in any loaded sprite sheet file. " ..
          "Please load the sprite sheet that contains this sprite." )           
end

--  Animations are logical folders within Texture Packer 3 which are just standard name conventions. 
--  
--  E.g. a animation called fellow1 with 4 keyframes would have the following sprites:
--      fellow1_1.png
--      fellow1_2.png
--      fellow1_3.png
--      fellow1_4.png
--
-- To call this function you can use: 
--      resources.newSpriteAnim("fellow1", layer, 0, 0, { 1, 0,
--                                                        2, 0.25,
--                                                        3, 0.5,
--                                                        4, 0.75, 
--                                                        1, 0 })
-- Warning !!! This function si not used anymore 
function M.newSpriteAnim( name, layer, x, y, keys )

    local sheet, k, v, i, prop, curve, anim, sprite
    
    if not layer then 
        error( "Please provide a layer! layer is nil." )
    end

    if #keys <= 2 then
        error("Please set more animation keyframes.")
    end
    
    -- Check if there is there is an animation in any sheet 
    -- file by checking the fellow1_1.png sprite.
    sprite = name .. '_1'
    for k, v in pairs( SHEETS ) do
        if SHEETS[k].names[sprite] then              
            sheet = k    
        end
    end

    if not sheet then
        error("Cound not find animation " .. name .. " in any sheet.")
        error("Please load the correspondent sheet!")
    end

    prop = MOAIProp2D.new()
    prop:setDeck( SHEETS[sheet] )

    curve = MOAIAnimCurve.new()
    curve:reserveKeys ( #keys / 2 )
    
    name = name .. '_'

    for i = 1, #keys / 2 do

        sprite = name .. keys[i + i - 1]
        if not SHEETS[sheet].names[sprite] then
            error("The sprite " .. sprite .. " is missing from " .. sheet .. " sheet.")
            return
        end

        curve:setKey( i, keys[i * 2], SHEETS[sheet].names[sprite], MOAIEaseType.FLAT )        
    end

    layer:insertProp( prop )

    anim = MOAIAnim.new()
    anim:reserveLinks( 1 )
    anim:setLink( 1, curve, prop, MOAIProp2D.ATTR_INDEX )
    anim:setMode( MOAITimer.LOOP )
    anim:start()

    return prop, anim
end

-- Physics --------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Global functions 
----------------------------------------------------------------------------------------------------
-- Physical object definition in Physics Body Editor by Aurelian Ribon 
function M.loadPolysSheet( path )
    if not path then 
        error("Please check the required arguments of loadSpriteSheet function.")
        return 
    end

    local file = path .. ".json"

    if POLYS_SHEETS[file] then 
        return 
    end

    local data = MOAIJsonParser.decode( io.open( file ):read("*all") )

    -- Now the list of polygon points looks like this: 
    --  [ [ {x:2, y:3 }, {x:3, y:3} ], [ {x:5, y:4} ] ]
    -- We transform it to this: 
    --  [ [ 2, 3, 3, 3 ], [ 5, 4 ] ]
    -- So it can be used with MOAIBox2DBody.addPolygon function directly

    local size = M.getSpriteConfig( "star" ).spriteSourceSize
    local object, point, finalFixture, finalFixturesList

    
    local polysSheet = {}

    for _, object in ipairs( data["rigidBodies"] ) do
        
        finalFixturesList = {}
        for _, fixture in ipairs( object["polygons"] ) do

            finalFixture = {}

            for _, point in ipairs( fixture ) do
                finalFixture[#finalFixture + 1] = ( point.x * size.width ) - ( size.width / 2 )
                finalFixture[#finalFixture + 1] = ( point.y * size.height ) - ( size.width / 2 )
            end

            finalFixturesList[#finalFixturesList + 1] = finalFixture 
        end

        polysSheet[#polysSheet + 1] = ( {
            name = object.name,
            fixtures = finalFixturesList
        } )
    end

    POLYS_SHEETS[ file ] = polysSheet 

end

function M.getPolys( objName )
    local file, obj
    for _, file in pairs(POLYS_SHEETS) do
        for _, obj in ipairs( file ) do
            if obj.name == objName then                
                return obj.fixtures
            end
        end
    end

    error("Could not find definition of " .. objName .. 
          " in any json file. Please load the correspondent file! ")

end

-- Fonts --------------------------------------------------------------------------------------------

function M.loadFont( path, name, options )

    if not path or not name then 
        error("Please check the required arguments of loadFont function.")
        return 
    end

    local glyphs = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'

    options           = options         or {}
    options.small     = options.small   or 20
    options.medium    = options.medium  or 32
    options.large     = options.large   or 38

    local font = MOAIFont.new()
    font:load(path)
    font:preloadGlyphs(glyphs, options.small)
    
    local small = MOAITextStyle.new()
    small:setFont(font)
    small:setSize(options.small)
    
    local medium = MOAITextStyle.new()
    medium:setFont(font)
    medium:setSize(options.medium)

    local large = MOAITextStyle.new()
    large:setFont(font)
    large:setSize(options.large)
    
    FONTS[name] = {}
    FONTS[name].file = path
    FONTS[name].small = small
    FONTS[name].medium = medium
    FONTS[name].large = large
end


-- Shaders --------------------------------------------------------------------------------------------

-- These files are not cached !
function M.loadShaderFiles( path )

    if not path then 
        error("Please check the required arguments of loadShaderFiles function.")
        return 
    end

    if MOAIGfxDevice.isProgrammable () then    
        local file = assert( io.open ( path .. '.vsh', mode ) )
        vsh = file:read( '*all' )

        file:close()

        file = assert( io.open ( path .. '.fsh', mode ) )
        fsh = file:read( '*all' )
        file:close()
 
        return vsh, fsh
    else
        warn("This device cannot use shaders !")
    end
end


-- Cleaning ----------------------------------------------------------------------------------------

function M.unloadAllSheets()

    for k, _ in pairs( SHEETS ) do
        SHEETS[k].names = nil
        SHEETS[k] = nil
    end
end


----------------------------------------------------------------------------------------------------
-- Getters / Setters
----------------------------------------------------------------------------------------------------

function M.getFont( name, size )

    if not FONTS[name] or not FONTS[name][size] then
        error( "The font requested is not loaded. Please load it first!" )
    else 
        return FONTS[name][size]
    end
end 


----------------------------------------------------------------------------------------------------
return M