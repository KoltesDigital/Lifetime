require("src/entity")
require("src/triggerComponent")

function Trigger(action, x, direction)
	local self = Entity.new()
	
	self:addComponent(TriggerComponent.new(action, x, direction))
	
	return self
end