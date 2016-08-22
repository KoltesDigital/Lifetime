AnimationComponent = {
	_name = "animation"
}
AnimationComponent.__index = AnimationComponent

function AnimationComponent.new(resourceName, animationName)
	local self = {
		animation = animationName or "idle",
		playing = false
	}
	setmetatable(self, AnimationComponent)
	
	self:setAnimationSet(resourceName)
	
	return self
end

function AnimationComponent:setAnimationSet(resourceName)
	if self.animationSet then
		self.entity:trigger("move", 0, self.animationSet._height)
	end
	if resourceName then
		self.animationSet = love.filesystem.load(constants.dataPath .. "animations/" .. resourceName)()
		self.animation = "idle"
		self.time = 0
		self.index = 1
		self.playing = true
		if self.run then
			self.entity:trigger("setImage", self.animationSet[self.animation][self.index])
			self.entity:trigger("move", 0, - self.animationSet._height)
			self.entity.components.graphics:setOffset(self.animationSet._width)
		end
	else
		self.animationSet = false
		self.playing = false
	end
end

function AnimationComponent:setAnimation(animationName)
	self.animation = animationName
	self.time = 0
	self.index = 1
	self.playing = true
end

function AnimationComponent:init()
	self.run = true
	if self.animationSet then
		self.entity:trigger("setImage", self.animationSet[self.animation][self.index])
		self.entity:trigger("move", 0, - self.animationSet._height)
		self.entity.components.graphics:setOffset(self.animationSet._width)
	end
end

function AnimationComponent:moveTo(x)
	self.target = x
	local transform = self.entity.components.transform
	if transform.x < self.target then
		self.entity:trigger("setDirection", "right")
	else
		self.entity:trigger("setDirection", "left")
	end
	self.entity:trigger("setMoving", true)
end

function AnimationComponent:finishMovement()
	if self.target then
		self.entity.components.transform.x = self.target
		self.entity:trigger("setMoving", false)
		self.target = nil
	end
end

function AnimationComponent:update(dt)
	if self.animationSet and self.animationSet[self.animation] and self.playing then
		self.time = self.time + dt
		
		if self.time >= constants.animationDuration then
			self.time = self.time - constants.animationDuration
			
			self.index = self.index + 1
			if self.index > #self.animationSet[self.animation] then
				self.index = 1
			end
			
			if self.animationSet[self.animation][self.index] == false then
				self.index = self.index - 1
				self.playing = false
			else
				self.entity:trigger("setImage", self.animationSet[self.animation][self.index])
			end
		end
	end
	
	if self.target then
		local transform = self.entity.components.transform
		local step = dt * constants.speed
		local diff = math.abs(self.target - transform.x)
		if transform.x < self.target then
			if diff <= step then
				self.entity:trigger("move", diff, 0)
				self.entity:trigger("setMoving", false)
				self.target = nil
			else
				self.entity:trigger("move", step, 0)
			end
		else
			if diff <= step then
				self.entity:trigger("move", - diff, 0)
				self.entity:trigger("setMoving", false)
				self.target = nil
			else
				self.entity:trigger("move", - step, 0)
			end
		end
	end
end