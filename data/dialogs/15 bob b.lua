return {
	{
		fun = function()
			game.entities.player:trigger("setAnimation", "idle")
			game.entities.bob:trigger("setAnimation", "idle")
		end,
		text = "- Ha ha! And now, fly!"
	}
}