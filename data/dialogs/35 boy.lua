return {
	"And now you're crying...",
	{
		right = {
			"Stop crying!",
			"Please stop crying, right now!",
			{
				fun = function()
					game.entities.boy:trigger("moveTo", 2800)
				end,
				text = "Boo hoo hoo..."
			},
			function()
				game:loadCutscene("50.lua")
			end	
		},
		left = game.choices.joinBadTeam and {
			"Ok, let's go to the park.",
			"Hey! I said let's go to the park!",
			{
				fun = function()
					game.choices.park = true
					game.entities.boy:trigger("setDirection", "left")
					game.entities.boy:trigger("setAnimation", "idle")
				end,
				text = "- Now?"
			},
			"- Sure!",
			"But before, an ice cream is waiting for you...",
			{
				fun = function()
					game.entities.boy:trigger("moveTo", 0)
				end,
				text = "- My ice cream!"
			},
			function()
				game:loadCutscene("50.lua")
			end	
		} or {
			"Ok, where do you want to go?",
			"Hey! I asked where do you want to go?",
			{
				fun = function()
					game.entities.boy:trigger("setDirection", "left")
				end,
				text = "- To the theme park!"
			},
			"- Ok, let's go to the theme park!",
			{
				fun = function()
					game.choices.themePark = true
					game.entities.boy:trigger("setAnimation", "idle")
				end,
				text = "- Now?"
			},
			"- Sure!",
			"But before, an ice cream is waiting for you...",
			{
				fun = function()
					game.entities.boy:trigger("moveTo", 0)
				end,
				text = "- My ice cream!"
			},
			function()
				game:loadCutscene("50.lua")
			end	
		}
	}
}