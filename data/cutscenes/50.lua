return {
	{
		time = 2,
		duration = 5,
		image = game.choices.park and "50 park.png"
			or game.choices.themePark and "50 theme park.png"
			or "50 order.png"
	},
	{
		time = 4,
		duration = 5,
		text = (game.choices.park or game.choices.themePark) and "I loved that boy."
			or "It was a pain to bring up that boy."
	},
	{
		time = 9,
		duration = 5,
		image = (game.choices.park or game.choices.themePark) and "50 family.png"
			or "50 tree.png"
	},
	{
		time = 10,
		duration = 5,
		text = (game.choices.park or game.choices.themePark) and "As I raised him, I became a better person."
			or "I failed his education."
	},
	{
		time = 17,
		duration = 5,
		text = "Time goes by so fast."
	},
	{
		time = 20,
		duration = 6,
		image = "50 sofa.png"
	},
	{
		time = 22,
		duration = 5,
		text = "I was absorbed in my own life."
	},
	{
		time = 26,
		duration = 5,
		image = "50 desktop 1.png"
	},
	{
		time = 28,
		duration = 5,
		text = "Work, responsabilities..."
	},
	{
		time = 31,
		duration = 5,
		image = "50 desktop 2.png"
	},
	{
		time = 33,
		duration = 5,
		text = "Too little time spent taking care of my family."
	},
	{
		time = 36,
		duration = 5,
		image = "50 desktop 3.png"
	},
	{
		time = 38,
		duration = 5,
		text = "And one day, children are gone."
	},
	{
		time = 44,
		level = "50.lua"
	},
}