--[[
class Entity

Generic entity class.
]]

Entity = {}
Entity.__index = Entity

function Entity.new(options)
	local self = options or {}
	setmetatable(self, Entity)
	
	if type(self.components) ~= "table" then
		self.components = {}
	end
	
	return self
end

function Entity:enable()
	self._enabled = true
	return self:trigger("enable")
end

function Entity:disable()
	self._enabled = false
	return self:trigger("disable")
end

function Entity:isEnabled()
	return self._enabled
end

function Entity:update(dt)
	if self.components.input then
		self.components.input:update(dt)
	end
	if self.components.animation then
		self.components.animation:update(dt)
	end
end

function Entity:trigger(event, ...)
	for _, component in pairs(self.components) do
		local handler = component[event]
		if handler then
			handler(component, ...)
		end
	end
end

function Entity:draw()
	if self.components.graphics then
		self.components.graphics:draw()
	end
end

function Entity:addComponent(component)
	self.components[component._name] = component
	component.entity = self
end