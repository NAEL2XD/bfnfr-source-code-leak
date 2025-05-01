-- What's up?
-- Lookin through my scripts I see :(

function shared.Destroy(Obj,T)
	coroutine.wrap(function()
		task.wait(T)
		Obj:Destroy()
	end)()
end

workspace.CurrentCamera.CameraType = "Custom"

game.Lighting.Blur.Size = 0

game:GetService("ProximityPromptService").Enabled = true
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

require(script.Settings)

local Player = game.Players.LocalPlayer
local c = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = c:WaitForChild("Humanoid")
local mouse = Player:GetMouse()

local RS = game.ReplicatedStorage
local UIS = game:GetService("UserInputService")
local RunS = game:GetService("RunService")
local UI = script.Parent
local MatchFrame = UI.MatchFrame
local ExFrame = UI.ExFrame
local SongSelect = UI.SongSelect
local SongList = SongSelect.Songs.List

function Destroy(Obj, Time)
	coroutine.wrap(function()
		task.wait(Time)
		Obj:Destroy()
	end)()
end

function Tween(Obj,Info,Goals)
	local tween = game:GetService("TweenService"):Create(Obj,Info,Goals):Play()
	tween = nil
end

function PermaTween(Obj,Info,Goals)
	local tween = game:GetService("TweenService"):Create(Obj,Info,Goals)
	return tween
end

local Modules = {
	UIFX = require(script.uiEffects);
	sP = require(script.songPlay);
}

local Difficulty = "Normal"
local CurrentM = nil
local Device = "Computer"
local Playing = false
local SentSettings = true
local InGame = true

local CurrentMod = nil

--=======================================
-- Functions ===========================
--=======================================

function SFX(ID, Vol, TP)
	local Sound = Instance.new("Sound", UI)
	Sound.SoundId = "rbxassetid://"..ID
	Sound.Volume = Vol or 0.5
	Sound:Play()
	Sound.TimePosition = TP or 0
	game.Debris:AddItem(Sound,5)
end

Humanoid.WalkSpeed = 0
Humanoid.JumpPower = 0

MatchFrame.KeySync1.Visible = true
MatchFrame.KeySync2.Visible = true

-- OH BOY

function SongPreview(ID, Time, Vol, Spd)
	if UI.Preview.SoundId == "rbxassetid://"..ID and UI.Preview.Playing == true then return end
	coroutine.wrap(function()
		local T = 0
		UI.Preview.Volume = 0
		Tween(UI.Preview, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Volume=Vol})
		UI.Preview.SoundId = "rbxassetid://"..ID
		UI.Preview:Play()
		UI.Preview.TimePosition = Time
		UI.Preview.PlaybackSpeed = Spd
		repeat T = T + 1 task.wait(0.2) until UI.Preview.SoundId ~= "rbxassetid://"..ID or T >= 60
		if UI.Preview.SoundId == "rbxassetid://"..ID then
			Tween(UI.Preview, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Volume=0})
		end
	end)()
end

function CountDown(BPM)
	coroutine.wrap(function()
		task.wait(120/BPM)
		UI.CountDown.Image = "rbxassetid://6421152562"
		UI.CountDown.ImageTransparency = 0
		Tween(UI.CountDown, TweenInfo.new(60/BPM, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
		task.wait(60/BPM)
		UI.CountDown.Image = "rbxassetid://6421153341"
		UI.CountDown.ImageTransparency = 0
		Tween(UI.CountDown, TweenInfo.new(60/BPM, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})	
		task.wait(60/BPM)
		UI.CountDown.Image = "rbxassetid://6421153580"
		UI.CountDown.ImageTransparency = 0
		Tween(UI.CountDown, TweenInfo.new(60/BPM, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0), {ImageTransparency=1})
		print('Start now in ', 60/BPM, ' seconds!')
	end)()
end

local ProgressBarTween = PermaTween(MatchFrame.ProgressBar.Bar.Bar, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {Size=UDim2.new(1,0,1,0)})
	
function Battle(SSong, SSongMap, Side)
	SongSelect.Visible = false
	Playing = true
	
	_G.NoteHit1 = nil
	_G.NoteHit2 = nil
	
	shared.BeatConfig[1] = 1
	shared.BeatConfig[2] = 1
	
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
	
	Tween(game.Lighting.Blur, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Size=24})
	Tween(UI.Preview, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Volume=0})
	
	MatchFrame.Rotation = 0
	
	local siz = _G.Settings.NoteSize
	
	if _G.Settings.Direction == -1 then
		MatchFrame.DuelScore.AnchorPoint = Vector2.new(0,0)
		MatchFrame.SingleScore.AnchorPoint = Vector2.new(0,0)
		MatchFrame.SingleScore.Position = UDim2.new(0,0,0,0)
		MatchFrame.DuelScore.Position = UDim2.new(0,0,0.05,0)
		MatchFrame.ProgressBar.Position = UDim2.new(0.25,0,0.955,0)
		
		for i,v in pairs(MatchFrame.KeySync1:GetChildren()) do
			if v:findFirstChild("Hold") then
				v.Hold.Position = UDim2.new(0,0,-8.1,0)
				v.Hold.Hitbox.Position = UDim2.new(0,0,0.94,0)
			end
		end
		for i,v in pairs(MatchFrame.KeySync2:GetChildren()) do
			if v:findFirstChild("Hold") then
				v.Hold.Position = UDim2.new(0,0,-8.1,0)
				v.Hold.Hitbox.Position = UDim2.new(0,0,0.94,0)
			end
		end

	else
		MatchFrame.DuelScore.AnchorPoint = Vector2.new(0,1)
		MatchFrame.SingleScore.AnchorPoint = Vector2.new(0,1)
		MatchFrame.SingleScore.Position = UDim2.new(0,0,1,0)
		MatchFrame.DuelScore.Position = UDim2.new(0,0,1,0)
		MatchFrame.ProgressBar.Position = UDim2.new(0.25,0,0.03,0)
		
		for i,v in pairs(MatchFrame.KeySync1:GetChildren()) do
			if v:findFirstChild("Hold") then
				v.Hold.Position = UDim2.new(0,0,0.5,0)
				v.Hold.Hitbox.Position = UDim2.new(0,0,-0.058,0)
			end
		end
		for i,v in pairs(MatchFrame.KeySync2:GetChildren()) do
			if v:findFirstChild("Hold") then
				v.Hold.Position = UDim2.new(0,0,0.5,0)
				v.Hold.Hitbox.Position = UDim2.new(0,0,-0.058,0)
			end
		end

	end
	
	MatchFrame.KeySync1.AnchorPoint = Vector2.new(0,0)
	MatchFrame.KeySync2.AnchorPoint = Vector2.new(0,0)
	
	if _G.Settings.ScrollType == "Middle" and _G.Settings.Direction == -1 then
		if Side == 1 then
			MatchFrame.KeySync1.AnchorPoint = Vector2.new(0.5,0)
			MatchFrame.KeySync1.Position = UDim2.new(0.5,0,0.845-0.063*siz,0)
			MatchFrame.KeySync1.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
			MatchFrame.KeySync2.Position = UDim2.new(0.78,0,0.45,0)
			MatchFrame.KeySync2.Size = UDim2.new(0.19,0,0.12,0)	
		else
			MatchFrame.KeySync2.AnchorPoint = Vector2.new(0.5,0)
			MatchFrame.KeySync1.Position = UDim2.new(0.045,0,0.45,0)
			MatchFrame.KeySync1.Size = UDim2.new(0.19,0,0.12,0)
			MatchFrame.KeySync2.Position = UDim2.new(0.5,0,0.845-0.063*siz,0)
			MatchFrame.KeySync2.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
		end
	elseif _G.Settings.ScrollType == "Middle" and _G.Settings.Direction == 1 then
		if Side == 1 then
			MatchFrame.KeySync1.AnchorPoint = Vector2.new(0.5,0)
			MatchFrame.KeySync1.Position = UDim2.new(0.5,0,0.08,0)
			MatchFrame.KeySync1.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
			MatchFrame.KeySync2.Position = UDim2.new(0.78,0,0.45,0)
			MatchFrame.KeySync2.Size = UDim2.new(0.19,0,0.12,0)	
		else
			MatchFrame.KeySync2.AnchorPoint = Vector2.new(0.5,0)
			MatchFrame.KeySync1.Position = UDim2.new(0.045,0,0.45,0)
			MatchFrame.KeySync1.Size = UDim2.new(0.19,0,0.12,0)
			MatchFrame.KeySync2.Position = UDim2.new(0.5,0,0.08,0)
			MatchFrame.KeySync2.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
		end
	elseif _G.Settings.Direction == -1 and _G.Settings.ScrollType ~= "Middle" then
		MatchFrame.KeySync1.Position = UDim2.new(0.12-0.075*siz,0,0.845-0.063*siz,0)
		MatchFrame.KeySync1.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
		MatchFrame.KeySync2.Position = UDim2.new(0.664-0.046*siz,0,0.845-0.063*siz,0)
		MatchFrame.KeySync2.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)	
	elseif _G.Settings.Direction == 1 and _G.Settings.ScrollType ~= "Middle" then
		MatchFrame.KeySync1.Position = UDim2.new(0.12-0.075*siz,0,0.08,0)
		MatchFrame.KeySync1.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
		MatchFrame.KeySync2.Position = UDim2.new(0.664-0.046*siz,0,0.08,0)
		MatchFrame.KeySync2.Size = UDim2.new(0.217+0.113*siz,0,0.075+0.063*siz,0)
	end
	
	if _G.Settings.Notes == 2 then
		MatchFrame.KeySync1.Arrow1.Image = "rbxassetid://6880051938"
		MatchFrame.KeySync1.Arrow2.Image = "rbxassetid://6880051990"
		MatchFrame.KeySync1.Arrow3.Image = "rbxassetid://6880051824"
		MatchFrame.KeySync1.Arrow4.Image = "rbxassetid://6880051880"
		MatchFrame.KeySync2.Arrow1.Image = "rbxassetid://6880051938"
		MatchFrame.KeySync2.Arrow2.Image = "rbxassetid://6880051990"
		MatchFrame.KeySync2.Arrow3.Image = "rbxassetid://6880051824"
		MatchFrame.KeySync2.Arrow4.Image = "rbxassetid://6880051880"
	else
		MatchFrame.KeySync1.Arrow1.Image = "rbxassetid://6664707428"
		MatchFrame.KeySync1.Arrow2.Image = "rbxassetid://6664707764"
		MatchFrame.KeySync1.Arrow3.Image = "rbxassetid://6664708322"
		MatchFrame.KeySync1.Arrow4.Image = "rbxassetid://6664708031"
		MatchFrame.KeySync2.Arrow1.Image = "rbxassetid://6664707428"
		MatchFrame.KeySync2.Arrow2.Image = "rbxassetid://6664707764"
		MatchFrame.KeySync2.Arrow3.Image = "rbxassetid://6664708322"
		MatchFrame.KeySync2.Arrow4.Image = "rbxassetid://6664708031"	
	end
	
	local Song = require(SSong)
	local SongMap = require(SSongMap)
	
	local FMData = Song.GetDetails()
	local MusicData = SongMap.GetDetails()
	
	local Dif = SSongMap.Name
	local DifN = 1
	if Dif == "Easy" then
		DifN = 1
	elseif Dif == "Normal" then
		DifN = 2
	elseif Dif == "Hard" then
		DifN = 3
	elseif Dif == "Expert" then
		DifN = 4
	end
	
	for i,v in pairs(UI:GetChildren()) do
		if v.Name == "IGMusic" then
			v:Destroy()
		end
	end
	
	local s = Instance.new("Sound", UI)
	s.Name = "IGMusic"
	s.Volume = MusicData[4] or 0.5
	s.PlaybackSpeed = MusicData[7] or 1
	s.SoundId = "rbxassetid://"..MusicData[1]
	
	_G.CurrentSong = s
	
	ExFrame.Song.Frame.Position = UDim2.new(1,0,0,0)
	ExFrame.Song.Frame:TweenPosition(UDim2.new(0,0,0,0), Enum.EasingDirection.Out,Enum.EasingStyle.Sine, 1, true)

	local DifData = FMData[7][DifN]
	
	if DifData[3] then
		ExFrame.Song.Frame.ImageLabel.Image = "rbxassetid://"..DifData[6]
		ExFrame.Song.Frame.SongName.Text = DifData[4]
		ExFrame.Song.Frame.Difficulty.Text = SSongMap.Name
		ExFrame.Song.Frame.Publisher.Text = DifData[5]
	else
		ExFrame.Song.Frame.ImageLabel.Image = "rbxassetid://"..FMData[5]
		ExFrame.Song.Frame.SongName.Text = FMData[2]
		ExFrame.Song.Frame.Difficulty.Text = SSongMap.Name
		ExFrame.Song.Frame.Publisher.Text = FMData[3]
	end
	
	if SSongMap.Name == "Easy" then
		ExFrame.Song.Frame.Difficulty.TextColor3 = Color3.fromRGB(0, 170, 255)
	elseif SSongMap.Name == "Normal" then
		ExFrame.Song.Frame.Difficulty.TextColor3 = Color3.fromRGB(225, 10, 10)
	elseif SSongMap.Name == "Hard" then
		ExFrame.Song.Frame.Difficulty.TextColor3 = Color3.fromRGB(255, 0, 221)
	end
	
	local Music = script.Parent:WaitForChild("Music")
	
	local Content = game:GetService("ContentProvider") 
	local Assets = {s.SoundId, Music.SoundId}
	Content:PreloadAsync(Assets) 

	print("Song Loaded")
	
	Tween(UI.Preview, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Volume=0})
	
	task.wait(1)
	
	local OtherSide = 1
	
	if Side == 1 then
		OtherSide = 2
	end
	
	--repeat task.wait() until Music.IsLoaded == true and Music.TimeLength > 0 and s.TimeLength > 0 and s.IsLoaded == true
	
	print("Client Ready!")
	
	Tween(game.Lighting.Blur, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Size=0})
	

		MatchFrame.ProgressBar.TextLabel.Text = FMData[2]
		ProgressBarTween:Cancel()
		ProgressBarTween = PermaTween(MatchFrame.ProgressBar.Bar.Bar, TweenInfo.new(s.TimeLength, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {Size=UDim2.new(1,0,1,0)})
		MatchFrame.ProgressBar.Bar.Bar.Size = UDim2.new(0,0,1,0)
		
		CountDown(MusicData[2])
		
		local TotalWait = ((60/MusicData[2])*4)-2

		task.wait(TotalWait)
		
		if Song.ModChart and _G.Settings.Distractions == true then
			Song.ModChart(s, MusicData[2])
		end
		
		Modules.sP.PlaySong(SongMap, MusicData, Side, OtherSide)
		Modules.sP.AutoSong(SongMap, MusicData, OtherSide)
		
		coroutine.wrap(function()
			task.wait(2+_G.Settings.NoteOffset/1000)
			s:Play()
			ProgressBarTween:Play()

		end)()

		ExFrame.Song.Frame:TweenPosition(UDim2.new(-1,0,0,0), Enum.EasingDirection.Out,Enum.EasingStyle.Sine, 1, true)

		if _G.Settings.EnableChat == false then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		end	
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
		

		local Arrows = {
			[1] = MatchFrame.KeySync1.Arrow1;
			[2] = MatchFrame.KeySync1.Arrow2;
			[3] = MatchFrame.KeySync1.Arrow3;
			[4] = MatchFrame.KeySync1.Arrow4;
			[5] = MatchFrame.KeySync2.Arrow1;
			[6] = MatchFrame.KeySync2.Arrow2;
			[7] = MatchFrame.KeySync2.Arrow3;
			[8] = MatchFrame.KeySync2.Arrow4;
		}

		Arrows[1].Position = UDim2.new(0.12,0,0.5,0)
		Arrows[2].Position = UDim2.new(0.372,0,0.5,0)
		Arrows[3].Position = UDim2.new(0.63,0,0.5,0)
		Arrows[4].Position = UDim2.new(0.883,0,0.5,0)
		Arrows[5].Position = UDim2.new(0.12,0,0.5,0)
		Arrows[6].Position = UDim2.new(0.372,0,0.5,0)
		Arrows[7].Position = UDim2.new(0.63,0,0.5,0)
		Arrows[8].Position = UDim2.new(0.883,0,0.5,0)
			
		MatchFrame.Visible = true
end

--===================================================================================================
--==== Song Browser ================================================================================
--===================================================================================================

local ListData = {}
local CurrentList = nil
local SelectedSong = nil

function DFShiny(DB, Dif)
	coroutine.wrap(function()
		DB.Shadow.Visible = false
		while Difficulty == Dif do
			Tween(DB.Gradient, TweenInfo.new(0.03, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {Rotation=DB.Gradient.Rotation+6})	
			task.wait(0.03)
		end
		DB.Shadow.Visible = true
	end)()
end

function CreateDifButton(Dif, Gradient, Color)
	local DifN = 1
	
	local DB = script.DifBaton:Clone()
	DB.DifN.Text = Dif
	DB.DifN.TextColor3 = Color
	DB.Dif.TextColor3 = Color
	DB.Gradient.Color = Gradient
	
	DB.Shadow.Visible = true
	
	if Difficulty == Dif then
		DFShiny(DB,Dif)
	end
	
	if Dif == "Easy" then
		DifN = 1
	elseif Dif == "Normal" then
		DifN = 2
	elseif Dif == "Hard" then
		DifN = 3
	elseif Dif == "Expert" then
		DifN = 4
	end
	
	DB.MouseButton1Click:Connect(function()
		if Difficulty ~= Dif then				
			local SFX = Instance.new("Sound", UI)
			SFX.SoundId = "rbxassetid://187269831"
			SFX:Play()
			game.Debris:AddItem(SFX,1)
			SongSelect.SongDetails.Difficulty.Text = Dif
			
			Difficulty = Dif
			
			DFShiny(DB,Dif)
			
			local MusicData = ListData[SelectedSong.Name][1]
			local DifData = MusicData[7][DifN]
			
			if DifData[3] then
				SongSelect.SongDetails.SongIcon.Image = "rbxassetid://"..DifData[6]
				SongSelect.SongDetails.SongTitle.Text = DifData[4]
				SongSelect.SongDetails.Author.Text = DifData[5]
				SongPreview(DifData[3], MusicData[6], MusicData[9] or 1, MusicData[10] or 1)
			else
				SongSelect.SongDetails.SongIcon.Image = "rbxassetid://"..MusicData[5]
				SongSelect.SongDetails.SongTitle.Text = MusicData[2]
				SongSelect.SongDetails.Author.Text = MusicData[3]
				SongPreview(MusicData[1], MusicData[6], MusicData[9] or 1, MusicData[10] or 1)
			end
		end
	end)
	
	return DB
end

local C1 = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,170,225)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0,170,225)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(121,225,224)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0,170,225)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,170,225))
}

local C2 = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(243, 19, 19)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(243, 19, 19)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 119, 119)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(243, 19, 19)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 19, 19))
}

local C3 = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 58, 239)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 58, 239)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 119, 253)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 58, 239)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 58, 239))
}

local C4 = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 127)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(133, 255, 211)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 255, 127)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 127))
}

local DB1 = CreateDifButton("Easy", C1, Color3.fromRGB(0, 222, 225))
local DB2 = CreateDifButton("Normal", C2, Color3.fromRGB(255, 21, 21))
local DB3 = CreateDifButton("Hard", C3, Color3.fromRGB(255, 78, 247))
local DB4 = CreateDifButton("Expert", C4, Color3.fromRGB(3, 255, 159))

local CSP = nil -- Current Song Page

function LoadSongs(ModC,ModName,Search)
	SongSelect.Songs.List.Visible = true
	
	for i,v in pairs(SongSelect.Songs.List:GetChildren()) do
		if v:IsA("ImageButton") then
			v:Destroy()
		end
	end

	for i,v in ipairs(game.ReplicatedStorage["Nael's Converted Spam Songs!"]:GetChildren()) do
		
		local SongFound = v
		local MusicData = require(SongFound).GetDetails()
		local DifData = nil
		local Song = script.Song:Clone()
		Song.Name = SongFound.Name
		Song.SongTitle.Text = SongFound.Name
		Song.Parent = SongSelect.Songs.List
		Song.HeadIcon.Image = "rbxassetid://"..MusicData[8]
		
		ListData[SongFound.Name] = {MusicData, SongFound}
		
		Song.MouseButton1Click:Connect(function()
			SongSelect.SongDetails.SongIcon.Image = "rbxassetid://"..MusicData[5]
			SongSelect.SongDetails.SongTitle.Text = MusicData[2]
			SongSelect.SongDetails.Author.Text = MusicData[3]
			SongSelect.SongDetails.Visible = true
			
			SelectedSong = SongFound
			
			for i2,v2 in pairs(SongSelect.SongDetails.DifficultyFrame:GetChildren()) do
				if v2:IsA("ImageButton") then
					v2.Parent = nil
				end	
			end

			if MusicData[7][1] and MusicData[7][1][1] then
				DB1.Dif.Text = MusicData[7][1][2]
				DB1.DifN.Text = MusicData[7][1][1]
				DB1.Parent = SongSelect.SongDetails.DifficultyFrame
				if Difficulty == "Easy" then
					DFShiny(DB1,Difficulty)
				end
			end
			
			if MusicData[7][2] and MusicData[7][2][1] then
				DB2.Dif.Text = MusicData[7][2][2]
				DB2.DifN.Text = MusicData[7][2][1]
				DB2.Parent = SongSelect.SongDetails.DifficultyFrame	
				if Difficulty == "Normal" then
					DFShiny(DB2,Difficulty)
				end
			end
			
			if MusicData[7][3] and MusicData[7][3][1] then
				DB3.Dif.Text = MusicData[7][3][2]
				DB3.DifN.Text = MusicData[7][3][1]
				DB3.Parent = SongSelect.SongDetails.DifficultyFrame
				if Difficulty == "Hard" then
					DFShiny(DB3,Difficulty)
				end
			end

			if MusicData[7][4] and MusicData[7][4][1] then
				DB4.Dif.Text = MusicData[7][4][2]
				DB4.DifN.Text = MusicData[7][4][1]
				DB4.Parent = SongSelect.SongDetails.DifficultyFrame
				if Difficulty == "Expert" then
					DFShiny(DB4,Difficulty)
				end
				
				DifData = MusicData[7][4]
			end
			
			-- Reset Difficulty if it doesn't exist
			if not MusicData[7][4] and MusicData[7][3] and Difficulty == "Expert" then
				Difficulty = "Hard"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB3,Difficulty)
			elseif not MusicData[7][4] and MusicData[7][2] and Difficulty == "Normal" then
				Difficulty = "Normal"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB2,Difficulty)	
			elseif not MusicData[7][4] and MusicData[7][1] and Difficulty == "Expert" then
				Difficulty = "Easy"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB1,Difficulty)	
			end

			if not MusicData[7][3] and MusicData[7][2] and Difficulty == "Hard" then
				Difficulty = "Normal"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB2,Difficulty)
			elseif not MusicData[7][3] and MusicData[7][4] and Difficulty == "Hard" then
				Difficulty = "Expert"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB4,Difficulty)		
			elseif not MusicData[7][3] and MusicData[7][1] and Difficulty == "Hard" then
				Difficulty = "Easy"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB1,Difficulty)		
			end

			if not MusicData[7][2] and MusicData[7][1] and Difficulty == "Normal" then
				Difficulty = "Easy"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB1,Difficulty)
			elseif not MusicData[7][2] and MusicData[7][3] and Difficulty == "Normal" then
				Difficulty = "Hard"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB3,Difficulty)
			end
			
			if not MusicData[7][1] and MusicData[7][2] and Difficulty == "Easy" then
				Difficulty = "Normal"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB2,Difficulty)
			elseif not MusicData[7][1] and MusicData[7][3] and Difficulty == "Easy" then
				Difficulty = "Hard"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB3,Difficulty)
			elseif not MusicData[7][1] and MusicData[7][4] and Difficulty == "Easy" then
				Difficulty = "Expert"
				SongSelect.SongDetails.Difficulty.Text = Difficulty
				DFShiny(DB4,Difficulty)
			end
			
			if DifData and DifData[3] and Difficulty == "Expert" then
				SongSelect.SongDetails.SongIcon.Image = "rbxassetid://"..DifData[6]
				SongSelect.SongDetails.SongTitle.Text = DifData[4]
				SongSelect.SongDetails.Author.Text = DifData[5]
				SongPreview(DifData[3], MusicData[6], MusicData[9] or 1, MusicData[10] or 1)
			else
				SongPreview(MusicData[1], MusicData[6], MusicData[9] or 1, MusicData[10] or 1)
			end
		end)
		
	end
end

-- Song Categories --

SongSelect.SongDetails.Select.MouseButton1Click:Connect(function()
	if SongSelect.Visible then
		Battle(SelectedSong,SelectedSong:FindFirstChild(Difficulty),2)
		SFX(6816415531, 1)
	end
end)

--[[SongSelect.SearchBar.FocusLost:Connect(function(e)
	if e then
		LoadCategories(SongSelect.SearchBar.Text)
	end
end)]]

function DetectInput(Button)
	
	local oldbutton = Button.Text
	local r = nil
	local sent = nil
	
	r = UIS.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode then
			sent = input.KeyCode
			r:Disconnect()
		else
			sent = "none"
			r:Disconnect()
		end
	end)

	return sent
end

-- Keybinds --------------------------------------------------------------------------------------------------------------------------------------------------------

UIS.WindowFocused:Connect(function() InGame = true end)
UIS.WindowFocusReleased:Connect(function() InGame = false end)

function ConsoleDisplay(val)
	if val == true then
		SongSelect.Console.Visible = true
	else
		SongSelect.Console.Visible = false
	end
end

UIS.InputBegan:Connect(function(input, GPE)
	if GPE then return end
	if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
		ConsoleDisplay(false)
	end
end)

-- connecting functions n whatnot

LoadSongs()

RunS.RenderStepped:Connect(function()
	local Pwr = (UI.Preview.PlaybackLoudness/10000)*UI.Preview.Volume
	SongSelect.SongDetails.SongIcon.Position = UDim2.new(-0.002-Pwr/2,0,0.188-Pwr/2,0)
	SongSelect.SongDetails.SongIcon.Size = UDim2.new(0.6+Pwr,0,0.6+Pwr,0)
end)