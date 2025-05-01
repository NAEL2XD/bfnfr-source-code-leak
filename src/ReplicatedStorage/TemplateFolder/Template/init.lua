local module = {}

function module.GetDetails()
	local Title = "Untitled"
	local Publisher = "Author"
	local Series = "???"
	local Icon = 0
	local HeadIcon = 0
	local Song = 0
	local PrevTime = 32

	local Difs = {
		[1] = {
			[1] = "Easy";
			[2] = 1;
		};
		[2] = {
			[1] = "Normal";
			[2] = 1;
		};
		[3] = {
			[1] = "Hard";
			[2] = 1;
		};
	}

	local Info = {Song, Title, Publisher, Series, Icon, PrevTime, Difs, HeadIcon, 3.5}
	return Info
end

return module
