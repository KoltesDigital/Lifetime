--[[
class InputComponent
]]

InputComponent = {
	_name = "input"
}
InputComponent.__index = InputComponent

function InputComponent.new()
	local self = {
		moving = false,
		direction = "right",
		enabled = true
	}
	setmetatable(self, InputComponent)
	return self
end

function InputComponent:enableInput()
	self.enabled = true
end

function InputComponent:disableInput()
	self.enabled = false
end

function InputComponent:setDirection(direction)
	self.direction = direction
end

function InputComponent:update(dt)
	local dx = self.enabled and ((love.keyboard.isDown("right") and 1 or 0) - (love.keyboard.isDown("left") and 1 or 0)) or 0
	
	if dx < 0 and self.direction == "right" then
		self.entity:trigger("setDirection", "left")
	elseif dx > 0 and self.direction == "left" then
		self.entity:trigger("setDirection", "right")
	end
	
	if dx ~= 0 and not self.moving then
		self.moving = true
		self.entity:trigger("setMoving", self.moving)
	elseif dx == 0 and self.moving then
		self.moving = false
		self.entity:trigger("setMoving", self.moving)
	end
	
	if dx ~= 0 then
		self.entity:trigger("move", dt * dx * constants.speed, 0)
	end
end