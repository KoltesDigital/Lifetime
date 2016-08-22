return {
	"- Hey... sorry for what I said.",
	{
		fun = function()
			game.entities.girl:trigger("setDirection", "left")
		end,
		text = "I didn't want to hurt you."
	},
	"- Well, you did.",
	"",
	"What's your name?",
	"- Ethan. And you?",
	"- Emily.",
	function()
		game:loadCutscene("35.lua")
	end
}