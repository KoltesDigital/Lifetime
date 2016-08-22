return {
	player = PlayerCharacter("adult.lua", 450, 600),
	Image("ground.png", 0, 600),
	Image("ground.png", 700, 600),
	Image("50 boss.png", 400, 90),
	Trigger("50 boss.lua", -10),
	Image("door.png", 1300, 200),
	Trigger("50 door.lua", 1400)
}