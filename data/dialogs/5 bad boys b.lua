return {
	"- Oh? You destroyed the castle...",
	"Poor little girl. We are not that bad!",
	"You are so dumb! Go away!",
	function()
		game:setTimeout(5, function()
			game:loadCutscene("10.lua")
		end)
		game:exitDialog()
	end
}