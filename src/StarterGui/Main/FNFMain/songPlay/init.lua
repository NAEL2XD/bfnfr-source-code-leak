local module = {}

local Player = game.Players.LocalPlayer

local TweenService = game:GetService("TweenService")
local RS = game:GetService("RunService")
local function Tween(Obj,Info,Goals)
	local tween = TweenService:Create(Obj,Info,Goals)
	return tween
end

local noteMod = require(script.Note)

local CurrentSongSpeed = 0

shared.BeatConfig = {
	[1] = 1; -- Frequency
	[2] = 1; -- Strength
}

local accuracy = {
	[1] = 6821104390;
	[2] = 6821104483;
	[3] = 6821104556;
}

local numbertable = {
	[0] = 6820871936;
	[1] = 6820871833;
	[2] = 6820871728;
	[3] = 6820871646;
	[4] = 6820871556;
	[5] = 6820871449;
	[6] = 6820871364;
	[7] = 6820871259;
	[8] = 6820871127;
	[9] = 6820870960;
}

local Chart = {}

local AccInd = game.ReplicatedStorage.Assets.AccInd:Clone()
local ComboInd = game.ReplicatedStorage.Assets.ComboInd:Clone()

local MaxCombo = 0

function Combo(Pos, Acc, Pos2)
	ComboInd.CFrame = CFrame.new(Pos)
	AccInd.CFrame = CFrame.new(Pos2)
	MaxCombo = MaxCombo + 1
	
	local ms = 2000-((1-Acc)*2000)
	
	local AGUI = AccInd.GUI:Clone()
	AGUI.Parent = AccInd
	AGUI.Enabled = true
	local AC = Tween(AGUI.Frame.Acc, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
	local AD = Tween(AGUI, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {StudsOffsetWorldSpace=Vector3.new(0,1,0);StudsOffset=Vector3.new(0,0,-0.01)})
	game.Debris:AddItem(AGUI, 1)

	local CGUI = ComboInd.GUI:Clone()
	CGUI.Parent = ComboInd
	CGUI.Enabled = true
	game.Debris:AddItem(CGUI, 1)

	local C1 = Tween(CGUI.Frame.N1, TweenInfo.new(0.96, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
	local C2 = Tween(CGUI.Frame.N2, TweenInfo.new(0.97, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
	local C3 = Tween(CGUI.Frame.N3, TweenInfo.new(0.98, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
	local C4 = Tween(CGUI.Frame.N4, TweenInfo.new(0.99, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
	local CD = Tween(CGUI, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {StudsOffsetWorldSpace=Vector3.new(0,1,0);StudsOffset=Vector3.new(0,0,-0.01)})

	local StringCom = tonumber(MaxCombo)
	ComboInd.Parent = workspace
	AccInd.Parent = workspace
	CGUI.Frame.N1.Image = "rbxassetid://6820871936"
	CGUI.Frame.N2.Image = "rbxassetid://6820871936"
	CGUI.Frame.N3.Image = "rbxassetid://6820871936"
	CGUI.Frame.N4.Image = ""
	local D = 1 
	local NumCount = 0
	for i in string.gmatch(StringCom, "%d") do  D = D + 1 end
	for i in string.gmatch(StringCom, "%d") do
		D = D - 1
		local Num = CGUI.Frame["N"..D]
		Num.Parent = CGUI.Frame
		Num.Image = "rbxassetid://"..numbertable[tonumber(i)]
	end
	if ms <= 35 then
		AGUI.Frame.Acc.Image = "rbxassetid://"..accuracy[1]
	elseif ms <= 80 then
		AGUI.Frame.Acc.Image ="rbxassetid://".. accuracy[2]
	else
		AGUI.Frame.Acc.Image = "rbxassetid://"..accuracy[3]
	end
	C1:Play()
	C2:Play()
	C3:Play()
	C4:Play()
	CD:Play()
	AC:Play()
	AD:Play()
end

local Playing = false
local CurrentSide = 2
local OtherSide = 1

local UI = script.Parent.Parent
local MatchFrame = UI.MatchFrame
local KeySync1 = MatchFrame.KeySync1
local KeySync2 = MatchFrame.KeySync2

local hidden = {}

local pos = {
	["Up"] = {

	};
	["Down"] = {

	};
}

local timetable = {
	[1] = 0;
	[2] = 1;
	[3] = 2;
	[4] = 3;
}

local holding = {
	[1] = false;
	[2] = false;
	[3] = false;
	[4] = false;
}

local notes = {
	[1] = {
		[1] = 6664653894;
		[2] = 6664654849;
		[3] = 6664655141;
		[4] = 6664655461;
	};
	[2] = {
		[1] = 6880051763;
		[2] = 6880052053;
		[3] = 6880051652;
		[4] = 6880051703;
	};
}

local press = {
	[1] = {
		[1] = 7148041843;
		[2] = 7148041988;
		[3] = 7148041500;
		[4] = 7148041696;
	};
	[2] = {
		[1] = 7148041760;
		[2] = 7148041913;
		[3] = 7148041386;
		[4] = 7148041614;
	};
}

local midnotes = {
	[1] = 6664807971;
	[2] = 6734467617;
	[3] = 6734467473;
	[4] = 6734416480;
}

local endnotes = {
	[1] = 6741677633;
	[2] = 6741678627;
	[3] = 6741678410;
	[4] = 6741677908;
}

local NoteKeys = {
	[1] = {
		[1] = noteMod.new(KeySync1["Arrow1"]);
		[2] = noteMod.new(KeySync1["Arrow2"]);
		[3] = noteMod.new(KeySync1["Arrow3"]);
		[4] = noteMod.new(KeySync1["Arrow4"]);	
	};
	[2] = {
		[1] = noteMod.new(KeySync2["Arrow1"]);
		[2] = noteMod.new(KeySync2["Arrow2"]);
		[3] = noteMod.new(KeySync2["Arrow3"]);
		[4] = noteMod.new(KeySync2["Arrow4"]);
	};
}

function NoteSplash()

end

local ctable = {}
local ctable2 = {}

local function CreateNote(Note, Speed, Hold, Side, NoteN, T)
	local ArPar = MatchFrame["KeySync"..Side]["Arrow"..Note].Notes
	local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Note].Hold.Hitbox

	local NoteInst = Instance.new("ImageLabel")
	NoteInst.Size = UDim2.new(1,0,1,0)
	NoteInst.Image = "rbxassetid://"..notes[_G.Settings.Notes][Note]
	NoteInst.Parent = ArPar
	NoteInst.Position = UDim2.new(0,0,(11*Speed),0)	
	NoteInst.BackgroundTransparency = 1
	NoteInst.Name = NoteN
	NoteInst:SetAttribute("T",T)
	NoteInst:SetAttribute("Type","Note")
	NoteInst.ZIndex = 2
	local HFrame = Instance.new("Frame")
	HFrame.Name = NoteN
	HFrame.Size = UDim2.new(0.4,0,(Hold*5)*Speed,0)
	HFrame.Position = UDim2.new(0.3,0,(0.5+11*Speed),0)
	HFrame.BackgroundTransparency = 1
	HFrame.Parent = ArPar
	HFrame:SetAttribute("T",T)
	HFrame:SetAttribute("Type","Hold")
	game.Debris:AddItem(HFrame,Hold+4)
	local HInst = Instance.new("ImageLabel")
	HInst.Size = UDim2.new(1,0,1,0)
	HInst.Position = UDim2.new(0,0,0,0)
	HInst.BorderSizePixel = 0
	HInst.BackgroundTransparency = 1
	HInst.ImageTransparency = 0.5
	HInst.Image = "rbxassetid://"..midnotes[Note]
	HInst.Name = "Hold"
	HInst.Parent = HFrame
	local EInst = Instance.new("ImageLabel")
	EInst.Size = UDim2.new(1,0,(0.3/(Hold*10)),0)
	EInst.Position = UDim2.new(0,0,1,0)
	EInst.BorderSizePixel = 0
	EInst.BackgroundTransparency = 1
	EInst.ImageTransparency = 0.5
	EInst.Image = "rbxassetid://"..endnotes[Note]
	EInst.Name = "End"
	EInst.Parent = HInst

	coroutine.wrap(function()
		while NoteInst.Parent == ArPar do
			if NoteInst.Position.Y.Scale < -math.clamp((0.6)*Speed,0.9,4) then
				if Side == CurrentSide then
					MaxCombo = 0
					NoteInst.Parent = MatchFrame["KeySync"..Side]["Arrow"..Note].Missed
					NoteInst.ImageTransparency = 0.75
					game.Debris:AddItem(NoteInst, 2)
					if _G.Settings["MissFX"] then
						local SFX = Instance.new("Sound", UI)
						SFX.SoundId = "rbxassetid://6417048819"
						SFX.Volume = 0.3
						SFX:Play()
						game.Debris:AddItem(SFX,0.75)
					end
					break
				end
			end
			wait(0.1)
		end
	end)()

	local FD = (11*Speed)/2
	
	TweenService:Create(NoteInst,TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=NoteInst.Position-(UDim2.new(0,0,(22*Speed)))}):Play()
	TweenService:Create(HFrame,TweenInfo.new(2*FD, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=HFrame.Position-(UDim2.new(0,0,(11*Speed)*FD,0))}):Play()

end

-- The Automatic Notes are here 

local function CreateAutoNote(Note, Speed, Hold, Side, NoteN)
	local KeySync = MatchFrame["KeySync"..Side]
	local Dir = _G.Settings.Direction
	local ArPar = MatchFrame["KeySync"..Side]["Arrow"..Note].Notes
	local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Note].Hold.Hitbox

	local NoteInst = Instance.new("ImageLabel")
	NoteInst.Size = UDim2.new(1,0,1,0)
	NoteInst.Image = "rbxassetid://"..notes[_G.Settings.Notes][Note]
	NoteInst.Parent = ArPar
	NoteInst.Position = UDim2.new(0,0,(11*Speed),0)	
	NoteInst.BackgroundTransparency = 1
	NoteInst.Name = NoteN
	NoteInst:SetAttribute("Type","Note")
	NoteInst.ZIndex = 2
	local HFrame = Instance.new("Frame")
	HFrame.Name = NoteN
	HFrame.Size = UDim2.new(0.4,0,(Hold*5)*Speed,0)
	HFrame.Position = UDim2.new(0.3,0,(0.5+11*Speed),0)
	HFrame.BackgroundTransparency = 1
	HFrame.Parent = ArPar
	HFrame:SetAttribute("Type","Hold")
	game.Debris:AddItem(HFrame,Hold+4)
	local HInst = Instance.new("ImageLabel")
	HInst.Size = UDim2.new(1,0,1,0)
	HInst.Position = UDim2.new(0,0,0,0)
	HInst.BorderSizePixel = 0
	HInst.BackgroundTransparency = 1
	HInst.ImageTransparency = 0.5
	HInst.Image = "rbxassetid://"..midnotes[Note]
	HInst.Name = "Hold"
	HInst.Parent = HFrame
	local EInst = Instance.new("ImageLabel")
	EInst.Size = UDim2.new(1,0,(0.3/(Hold*10)),0)
	EInst.Position = UDim2.new(0,0,1,0)
	EInst.BorderSizePixel = 0
	EInst.BackgroundTransparency = 1
	EInst.ImageTransparency = 0.5
	EInst.Image = "rbxassetid://"..endnotes[Note]
	EInst.Name = "End"
	EInst.Parent = HInst

	coroutine.wrap(function()
		while NoteInst.Parent == ArPar do
			if NoteInst.Position.Y.Scale < -math.clamp((0.6)*Speed,0.9,4) then
				NoteInst:Destroy()
				break
			end
			wait(0.1)
		end
	end)()

	coroutine.wrap(function()
		wait(2)
			if _G.NoteHit1 and Side == 1 then
				_G.NoteHit1()
			end
			NoteKeys[Side][Note]:Hit(true)



			NoteInst:Destroy()
			wait(Hold)
			NoteKeys[Side][Note]:Release()
	end)()

	coroutine.wrap(function()
		while HFrame.Parent do
				if HFrame:GetAttribute("Type") == "Hold" and HFrame.Position.Y.Scale < (0.5) then
					HFrame.Parent = HArrow
					break
				end			
			wait()
		end
	end)()

	local FD = (11*Speed)/2

	TweenService:Create(NoteInst,TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=NoteInst.Position-(UDim2.new(0,0,(22*Speed)))}):Play()
	TweenService:Create(HFrame,TweenInfo.new(2*FD, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=HFrame.Position-(UDim2.new(0,0,(11*Speed)*FD,0))}):Play()
end

-- for flipped side

local function CreateNote2(Note, Speed, Hold, Side, NoteN, T)
	local Dir = _G.Settings.Direction
	local ArPar = MatchFrame["KeySync"..Side]["Arrow"..Note].Notes
	local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Note].Hold.Hitbox

	local NoteInst = Instance.new("ImageLabel")
	NoteInst.Size = UDim2.new(1,0,1,0)
	NoteInst.Image = "rbxassetid://"..notes[_G.Settings.Notes][Note]
	NoteInst.Parent = ArPar
	NoteInst.Position = UDim2.new(0,0,-(11*Speed),0)	
	NoteInst.BackgroundTransparency = 1
	NoteInst.Name = NoteN
	NoteInst:SetAttribute("T",T)
	NoteInst:SetAttribute("Type","Note")
	NoteInst.ZIndex = 2
	local HFrame = Instance.new("Frame")
	HFrame.Name = NoteN
	HFrame.Size = UDim2.new(0.4,0,-(Hold*5)*Speed,0)
	HFrame.Position = UDim2.new(0.3,0,0.5-(11*Speed),0)
	HFrame.BackgroundTransparency = 1
	HFrame.Parent = ArPar
	HFrame:SetAttribute("T",T)
	HFrame:SetAttribute("Type","Hold")
	game.Debris:AddItem(HFrame,Hold+4)
	local HInst = Instance.new("ImageLabel")
	HInst.Size = UDim2.new(1,0,1,0)
	HInst.Position = UDim2.new(0,0,0,0)
	HInst.BorderSizePixel = 0
	HInst.BackgroundTransparency = 1
	HInst.ImageTransparency = 0.5
	HInst.Image = "rbxassetid://"..midnotes[Note]
	HInst.Name = "Hold"
	HInst.Parent = HFrame
	local EInst = Instance.new("ImageLabel")
	EInst.Size = UDim2.new(1,0,-(0.3/(Hold*10)),0)
	EInst.Position = UDim2.new(0,0,0,0)
	EInst.BorderSizePixel = 0
	EInst.BackgroundTransparency = 1
	EInst.ImageTransparency = 0.5
	EInst.Image = "rbxassetid://"..endnotes[Note]
	EInst.Name = "End"
	EInst.Rotation = 180
	EInst.Parent = HInst

	coroutine.wrap(function()
		while NoteInst.Parent == ArPar do
			if NoteInst.Position.Y.Scale > math.clamp((0.6)*Speed,0.9,4) then
				if Side == CurrentSide then
					MaxCombo = 0
					NoteInst.Parent = MatchFrame["KeySync"..Side]["Arrow"..Note].Missed 
					NoteInst.ImageTransparency = 0.75
					game.Debris:AddItem(NoteInst, 2)
					if _G.Settings["MissFX"] then
						local SFX = Instance.new("Sound", UI)
						SFX.SoundId = "rbxassetid://6417048819"
						SFX.Volume = 0.3
						SFX:Play()
						game.Debris:AddItem(SFX,0.75)
					end
					break
				end
			end
			wait(0.1)
		end

	end)()

	local FD = (11*Speed)/2


	TweenService:Create(NoteInst,TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=NoteInst.Position+(UDim2.new(0,0,(22*Speed)))}):Play()
	TweenService:Create(HFrame,TweenInfo.new(2*FD, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=HFrame.Position+(UDim2.new(0,0,(11*Speed)*FD,0))}):Play()
end

-- The Automatic Notes are here 

local function CreateAutoNote2(Note, Speed, Hold, Side, NoteN)
	local KeySync = MatchFrame["KeySync"..Side]
	local Dir = _G.Settings.Direction
	local ArPar = MatchFrame["KeySync"..Side]["Arrow"..Note].Notes
	local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Note].Hold.Hitbox

	local NoteInst = Instance.new("ImageLabel")
	NoteInst.Size = UDim2.new(1,0,1,0)
	NoteInst.Image = "rbxassetid://"..notes[_G.Settings.Notes][Note]
	NoteInst.Parent = ArPar
	NoteInst.Position = UDim2.new(0,0,-(11*Speed),0)	
	NoteInst.BackgroundTransparency = 1
	NoteInst.Name = NoteN
	NoteInst:SetAttribute("Type","Note")
	NoteInst.ZIndex = 2
	local HFrame = Instance.new("Frame")
	HFrame.Name = NoteN
	HFrame.Size = UDim2.new(0.4,0,-(Hold*5)*Speed,0)
	HFrame.Position = UDim2.new(0.3,0,0.5-(11*Speed),0)
	HFrame.BackgroundTransparency = 1
	HFrame.Parent = ArPar
	HFrame:SetAttribute("Type","Hold")
	game.Debris:AddItem(HFrame,Hold+4)
	local HInst = Instance.new("ImageLabel")
	HInst.Size = UDim2.new(1,0,1,0)
	HInst.Position = UDim2.new(0,0,0,0)
	HInst.BorderSizePixel = 0
	HInst.BackgroundTransparency = 1
	HInst.ImageTransparency = 0.5
	HInst.Image = "rbxassetid://"..midnotes[Note]
	HInst.Name = "Hold"
	HInst.Parent = HFrame
	local EInst = Instance.new("ImageLabel")
	EInst.Size = UDim2.new(1,0,-(0.3/(Hold*10)),0)
	EInst.Position = UDim2.new(0,0,0,0)
	EInst.BorderSizePixel = 0
	EInst.BackgroundTransparency = 1
	EInst.ImageTransparency = 0.5
	EInst.Rotation = 180
	EInst.Image = "rbxassetid://"..endnotes[Note]
	EInst.Name = "End"
	EInst.Parent = HInst

	coroutine.wrap(function()
		while NoteInst.Parent == ArPar do
			if NoteInst.Position.Y.Scale > math.clamp((0.6)*Speed,0.9,4) then
				NoteInst:Destroy()
				break
			end
			wait(0.1)
		end

	end)()

	coroutine.wrap(function()
		wait(2)
			if _G.NoteHit1 and Side == 1 then
				_G.NoteHit1()
			end

			NoteKeys[Side][Note]:Hit(true)

			NoteInst:Destroy()
			wait(Hold)
			NoteKeys[Side][Note]:Release()
	end)()

	coroutine.wrap(function()
		while HFrame.Parent do
				if HFrame:GetAttribute("Type") == "Hold" and HFrame.Position.Y.Scale > (0.5) then
					HFrame.Parent = HArrow
					break
				end
			wait()
		end

	end)()

	local FD = (11*Speed)/2
	
	TweenService:Create(NoteInst,TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=NoteInst.Position+(UDim2.new(0,0,(22*Speed)))}):Play()
	TweenService:Create(HFrame,TweenInfo.new(2*FD, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),{Position=HFrame.Position+(UDim2.new(0,0,(11*Speed)*FD,0))}):Play()
end

function module.PlaySong(Map, Data, Side, Side2)
	coroutine.wrap(function()

		local SaveSpeed = _G.Settings.NoteSpeed
		local Speed = _G.Settings.NoteSpeed

		CurrentSongSpeed = Speed

		if _G.Settings.NoteSpeed <= 0 then
			Speed = Data[3]
			CurrentSongSpeed = Data[3]
		end

		MaxCombo = 0
		local BeatMap = Map["GetNotes"..Side]()

		Playing = true
		CurrentSide = Side
		OtherSide = Side2

		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

		local StartingTime = os.clock()
		local lasti = 0
			
		for i,v in pairs(BeatMap) do
			task.delay(v[1],function()
				--if lasti < i then return end
				lasti = i
				
				if type(v[2]) == "number" then
					
					if _G.Settings.Direction == -1 then
						CreateNote2(v[2], Speed, v[3], Side, i, v[1])
					else
						CreateNote(v[2], Speed, v[3], Side, i, v[1])
					end
				end
			end)
		end

		coroutine.wrap(function()
			wait(2)
			while true do
				MatchFrame.Position = UDim2.new(0.5,0,0.5,0)
				MatchFrame.Size=UDim2.new(1.02*shared.BeatConfig[2],0,1.02*shared.BeatConfig[2],0)
				if shared.BeatConfig[1] > 1 then
					workspace.CurrentCamera.FieldOfView = 70/(shared.BeatConfig[2])
				end
				Tween(MatchFrame, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(1,0,1,0)}):Play()
				Tween(workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {FieldOfView=70}):Play()
				wait(((60/Data[2])*4)/shared.BeatConfig[1])
			end

			game.Lighting.ClockTime = 14
			Tween(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Ambient = Color3.fromRGB(138,138,138), OutdoorAmbient = Color3.fromRGB(128,128,128)}):Play()

			_G.Settings.NoteSpeed = SaveSpeed
			workspace.CurrentCamera.CameraType = "Custom"
			Playing = false
			MatchFrame.Visible = false
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		end)()
	end)()
end

function module.AutoSong(Map, Data, Side)
	coroutine.wrap(function()

		local Speed = _G.Settings.NoteSpeed

		if _G.Settings.NoteSpeed <= 0 then
			Speed = Data[3]
		end

		local BeatMap = Map["GetNotes"..Side]()

		local Multi = 1

		if _G.Settings.ScrollType == "Middle" then
			Multi = 1.35
		end

		for i,v in pairs(BeatMap) do
			task.delay(v[1],function()
				if type(v[2]) == "number" then
					if _G.Settings.Direction == -1 then
						CreateAutoNote2(v[2], Speed*Multi, v[3], Side, i)
					else
						CreateAutoNote(v[2], Speed*Multi, v[3], Side, i)
					end
				end	
			end)
		end
	end)()
end

local UIS = game:GetService("UserInputService")

function NoteInput(Input, Side, Time)
	if _G.Settings.Direction == -1 then
		NoteKeys[Side][Input]:Reset()

		local KeySync = MatchFrame["KeySync"..Side]
		local Arrow = KeySync["Arrow"..Input].Notes
		local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Input].Hold.Hitbox

		local CT = nil
		local CN = nil
		local Range = math.clamp(2.4*CurrentSongSpeed,1,9)
		local Acc = nil
		local perf = false

		for i,v in pairs(Arrow:GetChildren()) do
			if v:GetAttribute("Type") == "Note" and -v.Position.Y.Scale < Range and -v.Position.Y.Scale > -Range then
				Range = -v.Position.Y.Scale
				Acc = (Vector3.new(0,v.Position.Y.Scale,0)-Vector3.new(0,0,0)).magnitude/(11*math.clamp(CurrentSongSpeed,0.8,5))
				CN = v
				CT = {v.Name, v:GetAttribute("T")}
			end
		end

		local function HoldScan()
			for i,v in pairs(Arrow:GetChildren()) do
				if v:GetAttribute("Type") == "Hold" and v.Position.Y.Scale > 0.5 then
					v.Parent = HArrow
				end
			end
		end

		if CT and CN and Acc then
			local ms = 2000-((1-Acc)*2000)

			if ms > 150 then
				MaxCombo = 0
				NoteKeys[Side][Input]:Tap()
			elseif ms <= 150 then
				if _G.NoteHit1 and Side == 1 then
					_G.NoteHit1()
				end
				Combo(workspace.CurrentCamera.CFrame*CFrame.new(0,1,-11).Position, Acc, workspace.CurrentCamera.CFrame*CFrame.new(0,3,-12).Position)
				CN.Parent = nil
				CN:Destroy()

				if Acc <= 35 then
					perf = true
				end

				NoteKeys[Side][Input]:Hit(perf)
				HoldScan()
			end
		else
		--[[	if _G.Settings["MissFX"] then
				local SFX = Instance.new("Sound", UI)
				SFX.SoundId = "rbxassetid://6417048819"
				SFX.Volume = 0.3
				SFX:Play()
				game.Debris:AddItem(SFX,0.75)
			end]]
			NoteKeys[Side][Input]:Tap()
		end

		-- while input is being held

		while holding[Input] == true do
			HoldScan()
			game:GetService("RunService").RenderStepped:Wait()
		end

		NoteKeys[Side][Input]:Release()
		
		for i,v in pairs(HArrow:GetChildren()) do

			local V1 = math.abs(v.Size.Y.Scale)
			local V2 = -v.Position.Y.Scale

			local Remains = (((V1-(math.clamp(v.Position.Y.Scale,-1000,0)))/2)/V1)

			if ((V1)+V2) <= 0.2 then
				v:Destroy()
			else
				v.Parent = Arrow
				v.Hold.Size = UDim2.new(1,0,1-Remains,0)
				v.Hold.Position = UDim2.new(0,0,0,0)
				v.Hold.End.Size = UDim2.new(1,0,-0.3/((V1)*(v.Hold.Size.Y.Scale)),0)
				MaxCombo = 0
			end
		end

	else --====================================== O R I G I N A L  S I D E ==================================================--
		NoteKeys[Side][Input]:Reset()

		local KeySync = MatchFrame["KeySync"..Side]
		local Arrow = KeySync["Arrow"..Input].Notes
		local HArrow = MatchFrame["KeySync"..Side]["Arrow"..Input].Hold.Hitbox

		local CT = nil
		local CN = nil
		local Range = math.clamp(2.4*CurrentSongSpeed,1,9)
		local Acc = nil
		local perf = false

		for i,v in pairs(Arrow:GetChildren()) do
			if v:GetAttribute("Type") == "Note" and v.Position.Y.Scale < Range and v.Position.Y.Scale > -Range then
				Range = v.Position.Y.Scale
				Acc = (Vector3.new(0,v.Position.Y.Scale,0)-Vector3.new(0,0,0)).magnitude/(11*math.clamp(CurrentSongSpeed,0.8,5))
				CN = v
				CT = {v.Name, v:GetAttribute("T")}
			end
		end

		local function HoldScan()
			for i,v in pairs(Arrow:GetChildren()) do
				if v:GetAttribute("Type") == "Hold" and v.Position.Y.Scale < 0.5 then
					v.Parent = HArrow
				end
			end
		end

		if CT and CN and Acc then
			local ms = 2000-((1-Acc)*2000)
			
			if ms > 150 then
				MaxCombo = 0
				NoteKeys[Side][Input]:Tap()
			elseif ms <= 150 then
				if _G.NoteHit1 and Side == 1 then
					_G.NoteHit1()
				end
				Combo(workspace.CurrentCamera.CFrame*CFrame.new(0,1,-11).Position, Acc, workspace.CurrentCamera.CFrame*CFrame.new(0,3,-12).Position)
				CN.Parent = nil
				CN:Destroy()

				if Acc <= 35 then
					perf = true
				end

				NoteKeys[Side][Input]:Hit(perf)
				HoldScan()
			end
		else
		--[[	if _G.Settings["MissFX"] then
				local SFX = Instance.new("Sound", UI)
				SFX.SoundId = "rbxassetid://6417048819"
				SFX.Volume = 0.3
				SFX:Play()
				game.Debris:AddItem(SFX,0.75)
			end]]
			NoteKeys[Side][Input]:Tap()
		end

		-- while input is being held

		while holding[Input] == true do
			HoldScan()
			game:GetService("RunService").RenderStepped:Wait()
		end

		NoteKeys[Side][Input]:Release()

		for i,v in pairs(HArrow:GetChildren()) do
			local Remains = (((v.Size.Y.Scale-(math.clamp(v.Position.Y.Scale,-1000,0)))/2)/v.Size.Y.Scale)

			if ((v.Size.Y.Scale)+v.Position.Y.Scale) <= 1.2 then
				v:Destroy()
			else
				v.Parent = Arrow
				v.Hold.Size = UDim2.new(1,0,1-Remains,0)
				v.Hold.Position = UDim2.new(0,0,Remains,0)
				v.Hold.End.Size = UDim2.new(1,0,0.3/((v.Size.Y.Scale)*(v.Hold.Size.Y.Scale)),0)
				MaxCombo = 0
			end
		end
	end
end

MatchFrame.MobileKeys.Left.MouseButton1Down:Connect(function()
	holding[1] = true
	MatchFrame.MobileKeys.Left.ImageTransparency = 0
	NoteInput(1, CurrentSide)
end)

MatchFrame.MobileKeys.Down.MouseButton1Down:Connect(function()
	holding[2] = true
	MatchFrame.MobileKeys.Down.ImageTransparency = 0
	NoteInput(2, CurrentSide)
end)

MatchFrame.MobileKeys.Up.MouseButton1Down:Connect(function()
	holding[3] = true
	MatchFrame.MobileKeys.Up.ImageTransparency = 0
	NoteInput(3, CurrentSide)
end)

MatchFrame.MobileKeys.Right.MouseButton1Down:Connect(function()
	holding[4] = true
	MatchFrame.MobileKeys.Right.ImageTransparency = 0
	NoteInput(4, CurrentSide)
end)

MatchFrame.MobileKeys.Left.MouseButton1Up:Connect(function()
	holding[1] = false
	Tween(MatchFrame.MobileKeys.Left, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {ImageTransparency=0.8}):Play()
end)

MatchFrame.MobileKeys.Down.MouseButton1Up:Connect(function()
	holding[2] = false
	Tween(MatchFrame.MobileKeys.Down, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {ImageTransparency=0.8}):Play()
end)

MatchFrame.MobileKeys.Up.MouseButton1Up:Connect(function()
	holding[3] = false
	Tween(MatchFrame.MobileKeys.Up, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {ImageTransparency=0.8}):Play()
end)

MatchFrame.MobileKeys.Right.MouseButton1Up:Connect(function()
	holding[4] = false
	Tween(MatchFrame.MobileKeys.Right, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {ImageTransparency=0.8}):Play()
end)

function NotePress(Inp)

end

function KeyPress(input, GPE)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if GPE or Playing == false then return end
		if input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][3]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][7]] or input.KeyCode == Enum.KeyCode.Up then
			holding[3] = true
			NoteInput(3, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][1]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][5]] or input.KeyCode == Enum.KeyCode.Left then
			holding[1] = true
			NoteInput(1, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][2]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][6]] or input.KeyCode == Enum.KeyCode.Down then
			holding[2] = true
			NoteInput(2, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][4]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][8]] or input.KeyCode == Enum.KeyCode.Right then
			holding[4] = true
			NoteInput(4, CurrentSide)
		end	
	elseif input.UserInputType == Enum.UserInputType.Gamepad1 then
		if Playing == false then return end
		if input.KeyCode == Enum.KeyCode.ButtonY or input.KeyCode == Enum.KeyCode.DPadUp then
			holding[3] = true
			NoteInput(3, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode.ButtonX or input.KeyCode == Enum.KeyCode.DPadLeft then
			holding[1] = true
			NoteInput(1, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.KeyCode.DPadDown then
			holding[2] = true
			NoteInput(2, CurrentSide)
		elseif input.KeyCode == Enum.KeyCode.ButtonB or input.KeyCode == Enum.KeyCode.DPadRight then
			holding[4] = true
			NoteInput(4, CurrentSide)
		end	
	end
end

UIS.WindowFocusReleased:Connect(function()
	holding[1] = false 
	holding[2] = false 
	holding[3] = false 
	holding[4] = false 
end)

function KeyLift(input, GPE)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if GPE or Playing == false then return end	
		if input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][3]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][7]] or input.KeyCode == Enum.KeyCode.Up then
			holding[3] = false
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][1]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][5]] or input.KeyCode == Enum.KeyCode.Left then
			holding[1] = false
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][2]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][6]] or input.KeyCode == Enum.KeyCode.Down then
			holding[2] = false
		elseif input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][4]] or input.KeyCode == Enum.KeyCode[_G.Settings["Inputs"][8]] or input.KeyCode == Enum.KeyCode.Right then
			holding[4] = false
		end	
	elseif input.UserInputType == Enum.UserInputType.Gamepad1 then
		if Playing == false then return end	
		if input.KeyCode == Enum.KeyCode.ButtonY or input.KeyCode == Enum.KeyCode.DPadUp then
			holding[3] = false
		elseif input.KeyCode == Enum.KeyCode.ButtonX or input.KeyCode == Enum.KeyCode.DPadLeft then
			holding[1] = false
		elseif input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.KeyCode.DPadDown then
			holding[2] = false
		elseif input.KeyCode == Enum.KeyCode.ButtonB or input.KeyCode == Enum.KeyCode.DPadRight then
			holding[4] = false
		end	
	end
end

UIS.InputBegan:Connect(KeyPress)
UIS.InputEnded:Connect(KeyLift)

return module
