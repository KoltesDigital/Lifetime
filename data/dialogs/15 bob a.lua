return {
	{
		fun = function()
			game:addEntity(Trigger("15 prevomiting.lua", 1500))
			game:addEntity(Trigger("15 prevomiting.lua", 700, "rtl"))
			game:addEntity(Trigger("15 vomiting.lua", 1800))
			game:addEntity(Trigger("15 vomiting.lua", 400, "rtl"))
		end,
		text = "- Whassup dude?! See how you're walking!"
	},
	"Ha ha ha!",
	"- Yeah... I... drunk some beers...",
	"- Hey... want to drink something else?",
	"- What's that?",
	"- My magic bottle. Give it a try!",
	{
		right = {
			"Ok",
			function()
				game.entities.player:trigger("setAnimation", "drinking")
				game.entities.bob:trigger("setAnimation", "nobottle")
				game:setTimeout(7 * constants.animationDuration, function()
					game:loadDialog("15 bob b.lua")
				end)
			end
		},
		left = {
			"No",
			"- You missed your chance! Ha ha!"
		}
	}
}