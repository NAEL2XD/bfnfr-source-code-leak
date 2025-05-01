local module = {}

function module.GetDetails()
	local Title = "Sleep Talk"
	local Publisher = "Sock.clip"
	local Series = "Twinsomnia"
	local Icon = 15744846256
	local HeadIcon = 15744847829
	local Song = 0
	local PrevTime = 32

	local Difs = {
		[2] = {
			[1] = "Normal";
			[2] = 2;
		};
		[3] = {
			[1] = "Hard";
			[2] = 3;
		};
	}

	local Info = {Song, Title, Publisher, Series, Icon, PrevTime, Difs, HeadIcon, 3.5}
	return Info
end

return module
