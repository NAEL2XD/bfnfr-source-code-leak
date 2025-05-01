local TweenService = game:GetService("TweenService")
local RS = game:GetService("RunService")

local function Tween(Obj,Info,Goals)
	local tween = TweenService:Create(Obj,Info,Goals)
	return tween
end

--> declare the 'base' class.
local NoteKey = {}
NoteKey.__index = NoteKey

--> create the constructor for the 'base' class.
function NoteKey.new(Note)
	local newNote = setmetatable({}, NoteKey)

	newNote.ui = Note
	newNote.splash = Note.Splash
	newNote.splashAnim = 0
	newNote.lastSplash = 0
	newNote.tapAnim = Tween(Note.Hit, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Size=UDim2.new(1,0,1,0);ImageTransparency=1})
	newNote.hitAnim = Tween(Note.Arrow, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {Size=UDim2.new(1,0,1,0);ImageColor3=Color3.new(1,1,1)})

	return newNote
end

function NoteKey:Reset()
	self.tapAnim:Cancel()
	self.hitAnim:Cancel()
	self.ui.Hit.Size=UDim2.new(1.2,0,1.2,0)
	self.ui.Arrow.Size=UDim2.new(1,0,1,0)
	self.ui.Arrow.ImageColor3=Color3.new(1,1,1)
end

function NoteKey:Hit(sick)
	self:Reset()
	self.ui.Hit.Size=UDim2.new(1.4,0,1.4,0)
	self.ui.Hit.ImageTransparency = 0
	if sick then
		if self.splashAnim > 0 then
			self.splashAnim = 5
		else
			self.splashAnim = 5
			task.spawn(function()
				self.lastSplash = tick()
				local last = self.lastSplash
				while self.splashAnim > 0 and last == self.lastSplash do
					task.wait(0.03)
					self.splash.Inner.Position = UDim2.new(self.splashAnim-1,0,0,0)
					self.splash.Outer.Position = UDim2.new(self.splashAnim-1,0,0,0)
					self.splashAnim = self.splashAnim - 1
				end
			end)
		end
	end
end

function NoteKey:Tap()
	self:Reset()
	self.ui.Arrow.Size=UDim2.new(0.9,0,0.9,0)
	self.ui.Arrow.ImageColor3=Color3.new(0.8,0.8,0.8)
end

function NoteKey:Release()
	self.tapAnim:Play()
	self.hitAnim:Play()
end

return NoteKey
