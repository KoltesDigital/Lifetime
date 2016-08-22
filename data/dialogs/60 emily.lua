return {
	"All right... I'm free!",
	"- Good to hear that!",
	"So, what are your plans for tomorrow?",
	{
		left = {
			"To go outside!",
			function()
				game.choices.outside = true
				game:loadCutscene("70.lua")
			end
		},
		right = {
			"To rest a little bit...",
			function()
				game:loadCutscene("70.lua")
			end
		}
	}
}