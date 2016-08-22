return {
	"I miss you.",
	{
		fun = function()
			game.entities.player:trigger("setAnimationSet", "70 old.lua")
			game:addEntity(Image("70 bunch.png", -100, 450))
		end,
		text = "I have always loved you."
	}
}