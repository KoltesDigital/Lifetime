return {
	"- No, thank you.",
	"- You're here to have fun! Come on!",
	"- No really, I don't want to.",
	{
		fun = function()
			game:addEntity(Trigger("20 someone.lua", 1500, "rtl"))
		end,
		right = {
			"- What's the problem with you?",
			"- What do you care?",
			"Go back with your douche friends.",
			{
				fun = function()
					game.entities.girl:trigger("setDirection", "right")
				end,
				text = "Leave me alone please."
			}
		},
		left = {
			"- Suit yourself.",
			"- That's right.",
			"Go back with your douche friends.",
			{
				fun = function()
					game.entities.girl:trigger("setDirection", "right")
				end,
				text = "Leave me alone please."
			}
		}
	}
}