TriggerComponent = {
	_name = "trigger",
}
TriggerComponent.__index = TriggerComponent

function TriggerComponent.new(action, x, direction)
	local self = {
		x = x,
		direction = direction or "ltr",
		action = action
	}
	setmetatable(self, TriggerComponent)
	
	game:registerTrigger(self)
	
	return self
end