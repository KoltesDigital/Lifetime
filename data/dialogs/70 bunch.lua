return {
	"Someone forgot their bunch of flowers.",
	{
		left = {
			"[Take it]",
			function()
				game.entities.bunch = nil
				game.entities.player:trigger("setAnimationSet", "70 old flower.lua")
				game:addEntity(Trigger("70 speech b.lua", 257, "rtl"))
				game:setTimeout(0.5, function()
					game:exitDialog()
				end)
			end
		},
		right = {
			"[Keep moving]",
			function()
				game:exitDialog()
			end
		}
	}
}