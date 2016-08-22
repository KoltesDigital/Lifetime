return {
	"- You didn't destroy it, did you?",
	"So you don't want to join our team...",
	"You are so dumb. Go away!",
	function()
		game:setTimeout(5, function()
			game:loadCutscene("10.lua")
		end)
		game:exitDialog()
	end
}