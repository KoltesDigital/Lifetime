return {
	{
		fun = function()
			game.entities.boy:trigger("moveTo", 1400)
			game:setTimeout(5, function()
				game.entities.boy:trigger("finishMovement")
				game.entities.boy:trigger("setAnimation", "crying")
				game:addEntity(Trigger("35 boy.lua", 1250))
			end)
		end,
		text = game.choices.joinBadTeam and
			"- I want to go there!" or
			"- I want to go somewhere else!"
	},
	{
		fun = function()
			game.entities.player:trigger("setDirection", "right")
		end,
		text = "- Hey wait a minute! Your ice cream!"
	}
}