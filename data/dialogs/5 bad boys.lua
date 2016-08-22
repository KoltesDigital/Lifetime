return {
	"- Hello. Can I play with you?",
	function()
		game.entities.badboys:trigger("setAnimation", "talking")
	end,
	"- Who are you? We are the team of the bad boys!",
	"We'll only play with you if you join the team!",
	{
		right = {
			"I'd like to join.",
			{
				fun = function()
					game.entities.badboys:trigger("setAnimation", "idle")
					game.choices.joinBadTeam = true
				end,
				text = "- Hey, did you hear that!?"
			},
			"Ha ha ha!",
			{
				fun = function()
					game.entities.badboys:trigger("setAnimation", "talking")
				end,
				text = "Well, we have to make sure we can trust you"
			},
			"before you become a member...",
			"Do you see this girl, over there?",
			"She's making a pathetic sand castle...",
			"Go there and destroy it.",
			function()
				game.entities.badboys:trigger("setAnimation", "idle")
				game:exitDialog()
			end
		},
		left = {
			"No thanks.",
			"- Ha ha! You are a just a girl! Go back to your mom!",
			function()
				game.entities.badboys:trigger("setAnimation", "idle")
				game:exitDialog()
			end
		}
	}
}