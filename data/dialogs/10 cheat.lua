return {
	"- He, psst...",
	{
		fun = function()
			game.entities.player:trigger("setDirection", "left")
			game.entities.cheater:trigger("setAnimation", "talking")
		end,
		text = "I heard you're gonna be in trouble..."
	},
	"Trust me, it's not a big deal...",
	"...I can give you the answers.",
	{
		left = {
			"No thanks.",
			{
				fun = function()
					game.entities.cheater:trigger("setAnimation", "idle")
				end,
				text = "- Whatever. Good luck anyway..."
			}
		},
		right = {
			"I want them.",
			"- It's 5 bucks.",
			{
				left = {
					"Hey? No way.",
					{
						fun = function()
							game.entities.cheater:trigger("setAnimation", "idle")
						end,
						text = "- As you want. Good luck nevertheless..."
					}
				},
				right = {
					"Deal!",
					"- Everything is on this paper.",
					{
						fun = function()
							game.choices.cheated = true
							game.entities.cheater:trigger("setAnimation", "idle")
						end,
						text = "Don't get caught by the prof."
					}
				}
			}
		}
	}				
}