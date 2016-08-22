--[[
class GraphicsComponent

Draws rectangle and is happy.
]]

GraphicsComponent = {
	_name = "graphics",
}
GraphicsComponent.__index = GraphicsComponent

local images = {}

function GraphicsComponent.new(resourceName)
	local self = {
		color = {255, 255, 255},
		mirror = false,
		image = false,
		offset = 0
	}
	setmetatable(self, GraphicsComponent)
	
	self:setImage(resourceName)
	
	return self
end

function GraphicsComponent:setImage(resourceName)
	if images[resourceName] then
		self.image = images[resourceName]
	elseif resourceName then
		self.image = love.graphics.newImage(constants.dataPath .. "images/" .. resourceName)
		images[resourceName] = self.image
	else
		self.image = false
	end
end

function GraphicsComponent:setColor(color)
	self.color = color
end

function GraphicsComponent:setOpacity(opacity)
	self.color[4] = opacity
end

function GraphicsComponent:setDirection(direction)
	if direction == "left" then
		self.mirror = true
	elseif direction == "right" then
		self.mirror = false
	end
end

function GraphicsComponent:getWidth()
	return self.image and self.image:getWidth()
end

function GraphicsComponent:setOffset(offset)
	self.offset = offset
end

function GraphicsComponent:draw()
	if self.image then
		love.graphics.push()
		
		local transform = self.entity.components.transform
		if transform then
			love.graphics.translate(transform.x, transform.y)
		end
		
		love.graphics.setColor(unpack(self.color))
		
		if self.mirror then
			love.graphics.translate(self.offset, 0)
			love.graphics.scale(-1, 1)
		end
		
		love.graphics.draw(self.image, 0, 0)
		
		love.graphics.pop()
	end
end