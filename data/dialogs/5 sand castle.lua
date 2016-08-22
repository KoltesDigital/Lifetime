return {
	"A sand castle...",
	{
		right = {
			"[Give it a kick]",
			function()
				game.entities.girl:trigger("setAnimation", "stopped")
				game.entities.castle:trigger("setAnimation", "exploding")
			end,
			function()
				game.entities.girl:trigger("setAnimation", "crying")
				if game.choices.joinBadTeam then
					game:addEntity(Trigger("5 bad boys b.lua", 1900, "rtl"))
						game:exitDialog()
				else
					game.entities.badboys:trigger("moveTo", 2400)
				end
			end,
			"- Hey!? What did you do?",
			"We are bad boys, but not that bad.",
			{
				fun = function()
					game.entities.badboys:trigger("moveTo", 3600)
				end,
				text = "You are so mean!"
			},
			function()
				game:loadCutscene("10.lua")
			end
		},
		left = {
			"[Leave it]",
			{
				fun = function()
					game.entities.girl:trigger("setAnimation", "stopped")
				end,
				text = "- Hi! Want to build a castle with me?"
			},
			{
				right = {
					"Yes",
					function()
						game.entities.girl:trigger("setAnimation", "idle")
						game.entities.player:trigger("setAnimation", "sitting")
						game.entities.badboys:trigger("moveTo", 2400)
					end,
					game.choices.joinBadTeam and
						"- What are you doing? I said, destroy it!" or
						"- Ha ha! Look at those idiots building a sand castle!",
					{
						fun = function()
							game.entities.girl:trigger("setAnimation", "stopped")
							game.entities.castle:trigger("setAnimation", "exploding")
						end,
						text = game.choices.joinBadTeam and
							"Like that!" or
							"Goodbye, sand castle!"
					},
					{
						fun = function()
							game.entities.girl:trigger("setAnimation", "crying")
							game.entities.badboys:trigger("moveTo", 3600)
						end,
						text = "Ha ha ha!"
					},
					function()
						game:loadCutscene("10.lua")
					end
				},
				left = {
					"No",
					function()
						game.entities.girl:trigger("setAnimation", "idle")
						if game.choices.joinBadTeam then
							game:addEntity(Trigger("5 bad boys c.lua", 1900, "rtl"))
							game:exitDialog()
						else
							game.entities.badboys:trigger("moveTo", 2400)
						end
					end,
					"- Ha ha! Look at those idiots building a sand castle!",
					{
						fun = function()
							game.entities.girl:trigger("setAnimation", "stopped")
							game.entities.castle:trigger("setAnimation", "exploding")
						end,
						text = "Goodbye, sand castle!"
					},
					{
						fun = function()
							game.entities.girl:trigger("setAnimation", "crying")
							game.entities.badboys:trigger("moveTo", 3600)
						end,
						text = "Ha ha ha!"
					},
					function()
						game:loadCutscene("10.lua")
					end
				}
			}
		}
	}
}