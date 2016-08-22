--[[
class Game

It has a list of entities. It updates and renders them every frame.
]]

require("src/image")
require("src/character")
require("src/playerCharacter")
require("src/trigger")
require("src/cutscene")

Game = {}
Game.__index = Game

function Game.new()
	local self = {}
	setmetatable(self, Game)
	
	love.graphics.setBackgroundColor(255, 255, 255)
	
	self.entities = {}
	
	self.triggers = {}
	
	self:setCamera(0)
	
	self.left = love.graphics.newImage(constants.dataPath .. "images/left.png")
	self.right = love.graphics.newImage(constants.dataPath .. "images/right.png")
	
	self.choices = {}
	
	self.timeouts = {}
	self.time = 0
	self.activityTime = 0
	
	self.sound = love.audio.newSource(constants.dataPath .. "musics/cirrus.mp3")
	self.sound:setLooping(true)
	self.sound:setVolume(constants.volumeDuringGame)
	self.sound:play()
	
	return self
end

function Game:loadLevel(levelName)
	self.currentLevel = levelName
	if levelName == "0.lua" then
		self.choices = {}
	end
	self.triggers = {}
	self.entities = love.filesystem.load(constants.dataPath .. "levels/" .. levelName)()
	self:trigger("init")
	self:trigger("setOpacity", 0)
	self:setCamera()
	self.fadeIn = 0
	self.time = 0
	self.activityTime = 0
end

function Game:loadCutscene(cutsceneName)
	self.triggers = {}
	self.cutscene = Cutscene.new(cutsceneName)
	game:trigger("disableInput")
	self.fadeOut = 0
	self.timeouts = {}
end

function Game:loadDialog(dialogName)
	self.dialog = {
		data = love.filesystem.load(constants.dataPath .. "dialogs/" .. dialogName)(),
		index = 1,
		time = 0
	}
	function processDialog(dialog)
		for index, element in pairs(dialog) do
			if type(element) == "string" then
				dialog[index] = {
					text = element,
					textX = - font:getWidth(element) / 2,
					textY = constants.textVerticalOffset
				}
			elseif type(element) == "function" then
				dialog[index] = {
					fun = element
				}
			end
			if type(element) == "table" then
				if element.text then
					element.textX = - font:getWidth(element.text) / 2
					element.textY = constants.textVerticalOffset
				end
				if element.left then
					processDialog(element.left)
				end
				if element.right then
					processDialog(element.right)
				end
			end
		end
	end
	processDialog(self.dialog.data)
	game:trigger("disableInput")
	if self.dialog.data[1].fun then
		self.dialog.data[1].fun()
	end
end

function Game:exitDialog()
	self.dialog = nil
	game:trigger("enableInput")
end

function Game:setTimeout(time, fun)
	self.timeouts[fun] = self.time + time
end

function Game:addEntity(entity, id)
	if id then
		self.entities[id] = entity
	else
		table.insert(self.entities, entity)
	end
	entity:trigger("init")
end

function Game:setCamera(x)
	if not x then
		x = self.entities.player.components.transform.x + self.entities.player.components.graphics:getWidth() / 2
	end
	self.camera = x
end

function Game:trigger(event, ...)
	for id, entity in pairs(self.entities) do
		entity:trigger(event, ...)
	end
end

function Game:registerTrigger(trigger)
	table.insert(self.triggers, trigger)
end

function Game:keyPressed(key, unicode)
	self.activityTime = self.time
	
	if key == "escape" then
		if constants.exhibition then
			self.dialog = false
			self.cutscene = false
			self.timeouts = {}
			self.pushOn = false
			self:loadLevel("0.lua")
		else
			love.event.push("quit")
		end
	end
	
	if key == "f4" then
		love.event.push("quit")
	end
end

function Game:keyReleased(key, unicode)
end

function Game:update(dt)
	if dt > 0.2 then
		return
	end
	
	self.time = self.time + dt
	for fun, time in pairs(self.timeouts) do
		if self.time >= time then
			self.timeouts[fun] = nil
			fun()
		end
	end
	
	if self.fadeIn then
		self.fadeIn = self.fadeIn + dt
		if self.fadeIn < constants.fadeDuration then
			self:trigger("setOpacity", self.fadeIn / constants.fadeDuration * 255)
			self.sound:setVolume(1 - self.fadeIn / constants.fadeDuration * (1 - constants.volumeDuringGame))
		else
			self:trigger("setOpacity", 255)
			self.sound:setVolume(constants.volumeDuringGame)
			self.fadeIn = nil
		end
	end
	
	if self.fadeOut then
		self.fadeOut = self.fadeOut + dt
		if self.fadeOut < constants.fadeDuration then
			self:trigger("setOpacity", (1 - self.fadeOut / constants.fadeDuration) * 255)
			self.sound:setVolume(constants.volumeDuringGame + self.fadeOut / constants.fadeDuration * (1 - constants.volumeDuringGame))
		else
			self:trigger("setOpacity", 0)
			self.sound:setVolume(1)
			self.fadeOut = nil
			self.entities = {}
		end
	end
	
	for _, entity in pairs(self.entities) do
		entity:update(dt)
	end
	
	if #self.entities == 0 then
		self.activityTime = self.time
	end
	
	if self.entities.player then
		local x = self.entities.player.components.transform.x + self.entities.player.components.graphics:getWidth() / 2
		self.camera = self.camera + dt * constants.cameraSpeed * ( x - self.camera )
		
		for index, trigger in pairs(self.triggers) do
			if x >= trigger.x and trigger.direction == "ltr" or x < trigger.x and trigger.direction == "rtl" then
				if type(trigger.action) == "string" then
					self:loadDialog(trigger.action)
				elseif type(trigger.action) == "function" then
					trigger:action()
				end
				self.triggers[index] = nil 
			end
		end
	end
	
	if self.cutscene then
		self.cutscene:update(dt)
	end
	
	if self.dialog then
		self.dialog.time = self.dialog.time + dt
		local element = self.dialog.data[self.dialog.index]
		if (element.left or element.right) and not self.pushOn then
			if self.dialog.time > constants.dialogDuration / 2 then
				self.dialog.time = constants.dialogDuration / 2
			end
			if element.left and love.keyboard.isDown("left") then
				self.pushOn = "left"
				self.dialog.time = constants.dialogDuration / 2
			elseif element.right and love.keyboard.isDown("right") then
				self.pushOn = "right"
				self.dialog.time = constants.dialogDuration / 2
			end
		elseif self.dialog.time >= constants.dialogDuration then
			if self.pushOn == "left" then
				self.dialog = element.left[2] and {
					data = element.left,
					index = 1
				}
				self.pushOn = false
			elseif self.pushOn == "right" then
				self.dialog = element.right[2] and {
					data = element.right,
					index = 1
				}
				self.pushOn = false
			end
			
			self.dialog.time = 0
			self.dialog.index = self.dialog.index + 1
			
			element = self.dialog.data[self.dialog.index]
			if not element then
				self.dialog = false
				game:trigger("enableInput")
			elseif element.fun then
				element.fun()
			end
		end
		if element and not (element.left or element.right) then
			self.activityTime = self.time
		end
	end
	
	if constants.exhibition and self.time - self.activityTime > 60 and self.currentLevel ~= "0.lua" then
		self.dialog = false
		self.cutscene = false
		self.timeouts = {}
		self.pushOn = false
		self:loadLevel("0.lua")
	end
end

local pressAKeyText = "[Press a key if you're still here]"
function Game:draw()
	love.graphics.push()
	
	love.graphics.translate(- self.camera + constants.width / 2, 0)
	
	for _, entity in pairs(self.entities) do
		entity:draw()
	end
	
	love.graphics.pop()
	love.graphics.translate(constants.width / 2, constants.height / 2)
	
	if self.cutscene then
		self.cutscene:draw()
	end
	
	if self.dialog then
		local element = self.dialog.data[self.dialog.index]
		if element.left or element.right then
			local opacity = math.min(1, self.dialog.time / constants.fadeDuration) * 255
			if self.pushOn then
				opacity = math.min(opacity, - ( self.dialog.time - constants.dialogDuration ) / constants.fadeDuration * 255)
				opacity = math.max(opacity, 0)
			end
			local shift = math.max((self.dialog.time - constants.dialogDuration / 2) * constants.shiftFactor, 0)
			if element.left and self.pushOn ~= "right" then
				love.graphics.setColor(255, 255, 255, opacity)
				love.graphics.draw(self.left, ( constants.width * -0.5 - self.left:getWidth()) / 2 - shift, constants.keyVerticalOffset)
				love.graphics.setColor(constants.fontBlack, constants.fontBlack, constants.fontBlack, opacity)
				love.graphics.print(element.left[1].text, ( constants.width * -0.5 - font:getWidth(element.left[1].text) ) / 2, constants.textVerticalOffset)
			end
			if element.right and self.pushOn ~= "left" then
				love.graphics.setColor(255, 255, 255, opacity)
				love.graphics.draw(self.right, ( constants.width * 0.5 - self.right:getWidth() ) / 2 + shift, constants.keyVerticalOffset)
				love.graphics.setColor(constants.fontBlack, constants.fontBlack, constants.fontBlack, opacity)
				love.graphics.print(element.right[1].text, ( constants.width * 0.5 - font:getWidth(element.right[1].text) ) / 2, constants.textVerticalOffset)
			end
		elseif element.text then
			local opacity = math.min(1, self.dialog.time / constants.fadeDuration, - ( self.dialog.time - constants.dialogDuration ) / constants.fadeDuration) * 255
			opacity = math.max(opacity, 0)
			love.graphics.setColor(constants.fontBlack, constants.fontBlack, constants.fontBlack, opacity)
			love.graphics.print(element.text, element.textX, element.textY)
		end
	end
	
	if constants.exhibition and self.time - self.activityTime > 50 and self.currentLevel ~= "0.lua" then
		local opacity = math.min(1, self.time - self.activityTime - 50) * 255
		love.graphics.setColor(constants.fontBlack, constants.fontBlack, constants.fontBlack, opacity)
		love.graphics.print(pressAKeyText, - font:getWidth(pressAKeyText) / 2, -300)
	end
end
