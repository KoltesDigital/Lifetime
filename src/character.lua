require("src/entity")
require("src/transformComponent")
require("src/graphicsComponent")
require("src/inputComponent")
require("src/animationComponent")
require("src/characterComponent")

function Character(animationName, x, y)
	local self = Entity.new()
	
	self:addComponent(TransformComponent.new())
	self:addComponent(GraphicsComponent.new())
	self:addComponent(AnimationComponent.new(animationName))
	self:addComponent(CharacterComponent.new())
	
	self:trigger("setPosition", x, y)
	
	return self
end