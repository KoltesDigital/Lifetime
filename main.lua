-- bind love to the Game

-- debugging = true

require("constants")
require("src/game")

function love.load()
	local modes = love.graphics.getModes()
	table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)   -- sort from smallest to largest
	mode = modes[1]
	assert(mode.width >= mode.height, "horizontal screen please")
	
	love.graphics.setMode(mode.width, mode.height, true, true, 0)
	love.mouse.setVisible(false)
	
	font = love.graphics.newFont(constants.dataPath .. "fonts/" .. constants.font, constants.fontSize)
	love.graphics.setFont(font)
	
	game = Game.new()
	
	game:loadLevel("0.lua")
end

function love.keypressed(key, unicode)
	game:keyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
	game:keyReleased(key, unicode)
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	love.graphics.translate((mode.width - constants.width) / 4, 0);
	love.graphics.scale(mode.height / constants.height, mode.height / constants.height)
	game:draw()
end
