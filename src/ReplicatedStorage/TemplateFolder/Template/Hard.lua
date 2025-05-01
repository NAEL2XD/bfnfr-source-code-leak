local module = {}

function module.GetDetails()
	local Song = 0
	local BPM = 60
	local Speed = 1


	local Info = {Song, BPM, Speed, 3.5, nil, nil}
	return Info
end

local Notes1 = {}

function module.GetNotes1()
	return Notes1
end

local Notes2 = {}

function module.GetNotes2()
	return Notes2
end


return module
