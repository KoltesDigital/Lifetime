--[[
Transform component
]]

TransformComponent = {
	_name = "transform",
}
TransformComponent.__index = TransformComponent

function TransformComponent.new(x, y)
	local self = {
		x = x or 0,
		y = y or 0
	}
	setmetatable(self, TransformComponent)
	return self
end

function TransformComponent:setPosition(x, y)
	self.x = x
	self.y = y
end

function TransformComponent:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
	if self.x < 0 then
		self.x = 0
	end
end