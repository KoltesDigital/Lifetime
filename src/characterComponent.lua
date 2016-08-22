CharacterComponent = {
	_name = "character"
}
CharacterComponent.__index = CharacterComponent

function CharacterComponent.new()
	local self = {
	}
	setmetatable(self, CharacterComponent)
	
	return self
end

function CharacterComponent:setMoving(moving)
	self.entity:trigger("setAnimation", moving and "walking" or "idle")
end