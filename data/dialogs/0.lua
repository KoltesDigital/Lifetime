return {
	constants.exhibition and {
		right = {
			"",
			function()
				game:loadCutscene("5.lua")
			end
		}
	} or function()
		game:loadCutscene("5.lua")
	end
}