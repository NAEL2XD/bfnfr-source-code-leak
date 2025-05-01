local module = {}

_G.Settings = {
	["Inputs"] = {
		[1] = "F";
		[2] = "G";
		[3] = "H";
		[4] = "J";
		[5] = "Q";
		[6] = "F";
		[7] = "J";
		[8] = "M"
	};
	["Chat"] = false;
	["PlayedBefore"] = false;
	["ScrollType"] = "Middle";
	["Direction"] = 1;
	["Focus"] = true;
	["HideDisplay"] = false;
	["MissFX"] = false;
	["HidePl"] = true;
	["Shadows"] = true;
	["Lights"] = "Max";
	["Notes"] = 1;
	["Map"] = true;
	["MapQ"] = "Max";
	["MobileType"] = "Tiles";
	["NoteSpeed"] = 3;
	["NoteSize"] = 0.9;
	["NoteOffset"] = 0;
	["Brightness"] = 0.75;
	["Distractions"] = true;
	["SoloBot"] = 0;
	["BotAnim"] = "Auto";
	["AnimFriend"] = 0;
	["IDOverride"] = false;
	["CameraSway"] = true;
	["NoClump"] = false;
	["BotPlay"] = true; -- was suppose to be supported, but i don't know roblox luau
}

return module
