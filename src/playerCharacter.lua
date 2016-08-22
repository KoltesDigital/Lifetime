require("src/entity")
require("src/transformComponent")
require("src/graphicsComponent")
require("src/animationComponent")
require("src/characterComponent")

function PlayerCharacter(animationName, x, y)
	local self = Entity.new()
	
	self:addComponent(TransformComponent.new())
	self:addComponent(GraphicsComponent.new())
	self:addComponent(InputComponent.new())
	self:addComponent(AnimationComponent.new(animationName))
	self:addComponent(CharacterComponent.new())
	
	self:trigger("setPosition", x, y)
	
	return self
end