return {
	player = PlayerCharacter("kid.lua", 0, 600),
	Image("ground.png", -500, 600),
	Image("ground.png", 200, 600),
	Image("5 mommy.png", -450, 360),
	Trigger("5 mommy.lua", 200),
	Image("5 sand.png", 900, 600),
	badboys = Character("5 bad boys.lua", 1500, 580),
	Trigger("5 bad boys.lua", 1450),
	castle = Character("5 sand castle.lua", 2500, 630),
	girl = Character("5 girl.lua", 2620, 630),
	Trigger("5 sand castle.lua", 2450),
}