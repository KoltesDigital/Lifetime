Cutscene = {}
Cutscene.__index = Cutscene

function Cutscene.new(cutsceneName)
	local self = {
		time = 0
	}
	setmetatable(self, Cutscene)
	
	self.data = love.filesystem.load(constants.dataPath .. "cutscenes/" .. cutsceneName)()
	
	for _, element in ipairs(self.data) do
		if element.image then
			element.image = love.graphics.newImage(constants.dataPath .. "images/" .. element.image)
			element.imageX = - element.image:getWidth() / 2
			element.imageY = - element.image:getHeight() / 2 + constants.imageVerticalPosition
		end
		
		if element.text then
			element.textX = - font:getWidth(element.text) / 2
			element.textY = constants.textVerticalOffset
		end
	end
	
	return self
end

function Cutscene:update(dt)
	self.time = self.time + dt
	
	for _, element in ipairs(self.data) do
		if element.level and element.time <= self.time then
			game:loadLevel(element.level)
			element.level = nil
		end
	end
end

function Cutscene:draw()
	for _, element in ipairs(self.data) do
		if element.duration and element.time <= self.time and element.time + element.duration > self.time then
			local opacity = math.min(1, ( self.time - element.time ) / constants.fadeDuration, - ( self.time - element.time - element.duration ) / constants.fadeDuration) * 255
			
			if element.image then
				love.graphics.setColor(255, 255, 255, opacity)
				love.graphics.draw(element.image, element.imageX, element.imageY)
			end
			
			if element.text then
				love.graphics.setColor(constants.fontBlack, constants.fontBlack, constants.fontBlack, opacity)
				love.graphics.print(element.text, element.textX, element.textY)
			end
		end
	end
end