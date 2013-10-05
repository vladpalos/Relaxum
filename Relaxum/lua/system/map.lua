--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--=================================================================================================

--[[
	TiledMapEditor layers configuration:

		Titlesets
			Back	-- Mandatory
			Middle	-- Optional
			Front	-- Optional

		Physics
			Ground	-- Mandatory
			Objects	-- Optional

	Tilesets layers should have their own tilesets not exceeding 1024x1024 (iPhone3G Compatibility).
	The name of the layer should be exactly the name of the tileset (e.g. Back - Back).

	Objects are made of 3 parts:
		Physical Box2D Body 	-- Made with TiledMapEditor
		AI and configuration 	-- A single lua file (objname.lua)
		Graphic images			-- Texture packer sheet
--]]

local M = {}

---------------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------------

local Map = {

	width = 0,
	height = 0,
	tilewidth = 0,
	tileheight = 0,
	properties = nil,
	orientation = nil,

	layers = nil,		-- TiledMapEditor layer data
	tilesheets = {},	-- Sheets dictionary
--	layerTable = {},
	objects = {}, 		-- TODO
}


---------------------------------------------------------------------------------------------------
-- Private Functions
---------------------------------------------------------------------------------------------------

local function _addTilesLayer( layer )

	local sheet = layer.properties["sheet"]
	if sheet and Map.tilesheets[sheet] then
		local grid = MOAIGrid.new()

		grid:setSize( layer.width,
					  layer.height,
					  Map.tilewidth,
					  Map.tileheight )

		local i, val
		for i = 1, layer.height do
			for j = 1, layer.width do

				val = layer.data[ (layer.height - i) * layer.width + j ] -
				      Map.tilesheets[sheet].firstgid + 1

				grid:setTile( j, i, val )
			end
		end

		local prop = MOAIProp2D.new()
		prop:setDeck( Map.tilesheets[sheet].deck )
		prop:setGrid( grid )

		local w, h = prop:getDims()
		prop:setLoc( - w / 2, h / 2 )

		local moaiLayer = display.newLayer( CAMERA_MOVING , -100 )
		moaiLayer:insertProp( prop )

		moaiLayer.name = layer.name

		-- Parallax
		local px = layer.properties["parallax_x"] or 1
		local py = layer.properties["parallax_y"] or 1

		moaiLayer:setParallax( tonumber( px ), tonumber( py ) )

		-- TODO: Scroll option
		--[[
		local sx = layer.properties["scroll_x"] or 0
		local sy = layer.properties["scroll_y"] or 0

		local w = layer.width * M.tileWidth

		if sx or sy then
			moaiLayer:seekLoc( w, 0, 10, LINEAR )
		end
		--]]

		--[[
		moaiLayer.name = layer.name
		table.insert( M.layerTable, moaiLayer )
		--]]
	end
end

local function _addObjectsLayer( layer )

	for _, obj in ipairs(layer.objects) do
		if obj.visible == true then
			level.loadObjects( obj.type )

	        local halfW, halfH = obj.width / 2, obj.height / 2
        	local mapW, mapH = M.getDims()

        	obj.x = obj.x - ( mapW / 2 ) + halfW
        	obj.y = - obj.y + ( mapH / 2 ) - halfH

			level.addObject( obj )
		end
	end
end

--
--	Adds a boundary sensor wall so we can remove out of screen objects.
--
local function _addEraseBox()
	local fixture

	local wallBody = display.getWorld():addBody( MOAIBox2DBody.STATIC )
	local hw, hh = M.getHalfDims();

	local s = 50 	-- half size of wall
	local d = 250 	-- distance from edge of screen to center of wall

	-- Destroy the body. All the prop children will lose their references
	-- and removed by garbadge collector.
	local onCollision = function( ev, fixA, fixB, arbiter )
		local body = fixB:getBody()
		if body.type ~= "player" then
			body:remove()
		end
	end

    local left		= wallBody:addRect( -hw - s - d, -hh - s - d, -hw + s - d,  hh + s + d)
    local right		= wallBody:addRect(  hw - s + d, -hh - s - d,  hw + s + d,  hh + s + d)
   -- local top 		= wallBody:addRect( -hw - s - d,  hh - s + d,  hw + s + d,  hh + s + d)
    local bottom 	= wallBody:addRect( -hw - s - d, -hh - s - d,  hw + s + d, -hh + s - d)


	left:setCollisionHandler( onCollision, MOAIBox2DArbiter.PRE_SOLVE )
	right:setCollisionHandler( onCollision, MOAIBox2DArbiter.BEGIN )
--	top:setCollisionHandler( onCollision, MOAIBox2DArbiter.BEGIN )
	bottom:setCollisionHandler( onCollision, MOAIBox2DArbiter.BEGIN )
end

---------------------------------------------------------------------------------------------------
-- Global Functions
---------------------------------------------------------------------------------------------------

function M.load( file )

	local mapData = dofile( file .. '.lua' )

	if not mapData then
		error("Could not read level file: " .. file .. " !");
	end

	Map.width 			= mapData.width
	Map.height 			= mapData.height
	Map.tilewidth 		= mapData.tilewidth
	Map.tileheight 		= mapData.tileheight
	Map.properties 		= mapData.properties
	Map.orientation 	= mapData.orientation
	Map.layers	 		= mapData.layers

	-- Tilesets
	for _, set in ipairs( mapData.tilesets ) do
		local deck = MOAITileDeck2D.new()

		-- This Hack allows us to save maps in "assets/maps" folder with TiledMapEditor.
		set.image = "assets/" .. string.sub( set.image, 3 )

		deck:setTexture( set.image )

		deck:setSize( math.floor( set.imagewidth / set.tilewidth ),
					  math.floor( set.imageheight / set.tileheight ) )

		deck:setRect( -0.5, -0.5, 0.5, 0.5 )

		Map.tilesheets[set.name] = set
		Map.tilesheets[set.name].deck = deck
	end
end

function M.init()
	for _, layer in ipairs( Map.layers ) do
		if layer.visible == true then
			if layer.type == "tilelayer" then
				_addTilesLayer( layer )
			elseif layer.type == "objectgroup" then
				_addObjectsLayer( layer )
			end
		end
	end

	_addEraseBox()
end

function M.unloadMap()

	for k, _ in ipairs( Map.layerTable ) do Map.layerTable[k] = nil end
	for k, _ in pairs( Map.tilesheets ) do Map.tilesheets[k] = nil end
end


---------------------------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------------------------

function M.getProp( string )
	return Map.props[string]
end

function M.getDims()
	return (Map.width * Map.tilewidth)  , (Map.height * Map.tileheight)
end


function M.getHalfDims()
	return (Map.width * Map.tilewidth / 2)  , (Map.height * Map.tileheight / 2)
end

----------------------------------------------------------------------------------------------------
return M




--[[
function getLayerTable( )

	return M.layerTable
end
--]]