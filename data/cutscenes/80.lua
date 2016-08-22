local r = {
	{
		time = 2,
		duration = 5,
		text = "And now, it's going to be my turn."
	},
	{
		time = 4,
		duration = 8,
		image = "80 sofa a.png"
	},
	{
		time = 9,
		duration = 5,
		text = "If I could have a second life..."
	},
	{
		time = 15,
		duration = 6,
		text = "Would I make different choices? Would I change anything?"
	},
	{
		time = 23,
		duration = 5,
		text = "- Your session is over."
	},
	{
		time = 26,
		duration = 5,
		image = "80 sofa b.png"
	},
	{
		time = 32,
		duration = 5,
		image = "80 sofa c.png"
	},
	{
		time = 41,
		duration = 5,
		image = "credits 1.png"
	},
	{
		time = 47,
		duration = 7,
		image = "credits 2.png"
	}
}

if constants.exhibition then
	table.insert(r, {
		time = 60,
		level = "0.lua"
	})
end

return r