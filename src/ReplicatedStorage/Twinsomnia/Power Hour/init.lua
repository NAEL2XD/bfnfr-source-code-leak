local module = {}

function module.GetDetails()
	local Title = "Power Hour"
	local Publisher = "Sock.clip"
	local Series = "Twinsomnia"
	local Icon = 15744847091
	local HeadIcon = 15744848653
	local Song = 0
	local PrevTime = 32

	local Difs = {
		[2] = {
			[1] = "Normal";
			[2] = 5;
		};
		[3] = {
			[1] = "Hard";
			[2] = 6;
		};
	}

	local Info = {Song, Title, Publisher, Series, Icon, PrevTime, Difs, HeadIcon, 3.5}
	return Info
end

return module
