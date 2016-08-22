require("src/entity")
require("src/transformComponent")
require("src/graphicsComponent")

function Image(imageName, x, y)
	local self = Entity.new()
	
	self:addComponent(TransformComponent.new())
	self:addComponent(GraphicsComponent.new(imageName))
	
	self:trigger("setPosition", x, y)
	
	return self
end