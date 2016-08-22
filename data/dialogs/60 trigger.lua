return {
	{
		fun = function()
			game:setTimeout(1, function()
				game:addEntity(Trigger("60 emily.lua", 450))
			end)
			game:exitDialog()
		end,
	}
}