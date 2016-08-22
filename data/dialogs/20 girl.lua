return {
	"- Hi.",
	{
		fun = function()
			game.entities.girl:trigger("setDirection", "left")
		end,
		left = {
			"Want to dance?",
			function()
				game:loadDialog("20 girl b.lua")
			end
		},
		right = {
			"Want to drink something?",
			function()
				game:loadDialog("20 girl b.lua")
			end
		}
	}
}