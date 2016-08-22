return {
	"- I...",
	{
		fun = function()
			game.entities.player:trigger("setAnimationSet", "15 young b.lua")
		end,
		text = ""
	},
	"",
	function()
		game:loadCutscene("20.lua")
	end
}