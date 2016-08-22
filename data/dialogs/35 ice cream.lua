return {
	{
		fun = function()
			game.entities.player:trigger("setDirection", "left")
			game.entities.boy:trigger("setDirection", "left")
		end,
		text = "- mmm..."
	},
	"Vanilla!",
	"- Two vanilla ice creams, please.",
	"",
	{
		fun = function()
			game.entities.boy:trigger("setDirection", "right")
		end,
		text = game.choices.joinBadTeam and
			"- Dad, why do we never go to the park?" or
			"- Dad, why do we always go to the park?"
	},
	{
		right = {
			"It's for your good.",
			function()
				game:loadDialog("35 ice cream b.lua")
			end
		},
		left = {
			"I don't know.",
			function()
				game:loadDialog("35 ice cream b.lua")
			end
		}
	}
}