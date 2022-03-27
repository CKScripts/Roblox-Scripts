-- 𝘊𝘰𝘯𝘧𝘪𝘨𝘶𝘳𝘢𝘵𝘪𝘰𝘯 --
local Config = {

}

-- 𝘎𝘢𝘮𝘦 𝘚𝘦𝘳𝘷𝘪𝘤𝘦𝘴 --
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedScriptService = game:GetService("ReplicatedScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local StarterPack = game:GetService("StarterPack")
local StarterPlayer = game:GetService("StarterPack")
local Teams = game:GetService("Teams")
local SoundService = game:GetService("SoundService")
local Chat = game:GetService("Chat")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 𝘝𝘢𝘭𝘶𝘦𝘴 --
local LPlayer = Players.LocalPlayer
local LMouse = LPlayer:GetMouse()
local LPlayerGui = LPlayer:FindFirstChildOfClass("PlayerGui")

-- 𝘉𝘶𝘪𝘭𝘥𝘪𝘯𝘨 𝘵𝘩𝘦 𝘜𝘐 --
-- 𝘎𝘦𝘵𝘵𝘪𝘯𝘨 𝘜𝘐 --
local MainUI
if not RunService:IsStudio() then
	MainUI = game:GetObjects("rbxassetid://9205678343")[1]
else
	MainUI = script:FindFirstChildOfClass("ScreenGui")
	MainUI.Parent = LPlayerGui
end

if not RunService:IsStudio() then
	local NewUI = game:GetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui")
	for i, v in pairs(MainUI:GetChildren()) do
		v.Parent = NewUI
	end
	MainUI = NewUI
end

-- 𝘗𝘢𝘯𝘦𝘭 --
local Panel = MainUI:FindFirstChild("Panel")
local AssetsFolder = Panel:FindFirstChild("Assets")
local Navigation = Panel:FindFirstChild("Navigation")
local Tabs = Panel:FindFirstChild("Tabs")
local Top = Panel:FindFirstChild("Top")

-- 𝘛𝘰𝘱 --
local Title = Top:FindFirstChild("Title")
local Close = Top:FindFirstChild("Close")

-- 𝘕𝘢𝘷𝘪𝘨𝘢𝘵𝘪𝘰𝘯 --
local Buttons = Navigation:FindFirstChild("Buttons")

-- 𝘛𝘢𝘣𝘴 --
local Home = Tabs:FindFirstChild("Home")
local Team = Tabs:FindFirstChild("Team")

-- 𝘛𝘦𝘢𝘮 --
local Fillbox = Team:FindFirstChild("Fillbox")
local FillExample = Fillbox:FindFirstChild("Fill")
local Teambox = Team:FindFirstChild("Teambox")
local Change = Team:FindFirstChild("Change")

-- 𝘏𝘰𝘮𝘦 --
local PlayerThumbnail = Home:FindFirstChild("PlayerThumbnail")
local PlayerName = Home:FindFirstChild("PlayerName")
PlayerThumbnail.Image = Players:GetUserThumbnailAsync(LPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)
PlayerName.Text = LPlayer.Name

-- 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯𝘴 --
function OpenTab(TabName)
	for _, Tab in pairs(Tabs:GetChildren()) do
		if Tab.Name ~= TabName then
			Tab.Visible = false
		else
			Tab.Visible = true
		end
	end
end

function ButtonAnimation(Button,Type,X,Y)
	if Type == "Hover" then
		local HoverColor = Color3.fromRGB(0,0,0)
		local ButtonAnimationInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine)
		local ButtonAnimationProperty = {
			TextColor3 = HoverColor
		}
		local ButtonAnimation = TweenService:Create(Button,ButtonAnimationInfo,ButtonAnimationProperty)
		ButtonAnimation:Play()
	elseif Type == "NoHover" then
		local OriginalColor = Color3.fromRGB(255, 255, 255)
		local ButtonAnimationInfo = TweenInfo.new(0.25,Enum.EasingStyle.Sine)
		local ButtonAnimationProperty = {
			TextColor3 = OriginalColor
		}
		local ButtonAnimation = TweenService:Create(Button,ButtonAnimationInfo,ButtonAnimationProperty)
		ButtonAnimation:Play()
	elseif Type == "CircleClick" then
		coroutine.resume(coroutine.create(function()
			Button.ClipsDescendants = true
			local Circle = Instance.new("ImageLabel")
			Circle.BackgroundColor3 = Color3.fromRGB(0,0,0)
			Circle.BackgroundTransparency = 1
			Circle.Name = "Circle"
			Circle.ZIndex = 10
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageTransparency = 0.5
			Circle.Parent = Button
			Circle.ImageColor3 = Color3.fromRGB(0,0,0)
			local NewX = X - Circle.AbsolutePosition.X
			local NewY = Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
			local Size = 0
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				Size = Button.AbsoluteSize.X*1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				Size = Button.AbsoluteSize.Y*1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																																																																														
				Size = Button.AbsoluteSize.X*1.5
			end
			local Time = 0.5
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy()
		end))
	end
end

function drag(b)
	local a = game:GetService("UserInputService")
	local dragToggle
	local dragSpeed
	local dragInput
	local dragStart
	local dragPos
	local Delta
	local Position
	local startPos

	dragToggle = nil
	dragSpeed = 0.23
	dragInput = nil
	dragStart = nil
	dragPos = nil

	local function updateInput(a)
		Delta = a.Position-dragStart
		Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+Delta.X,startPos.Y.Scale,startPos.Y.Offset+Delta.Y)
		game:GetService("TweenService"):Create(b,TweenInfo.new(0.25),{Position=Position}):Play()
	end 
	b.InputBegan:Connect(function(c)
		if(c.UserInputType == Enum.UserInputType.MouseButton1 or c.UserInputType == Enum.UserInputType.Touch)and a:GetFocusedTextBox()==nil then
			dragToggle = true 
			dragStart = c.Position 
			startPos = b.Position 
			c.Changed:Connect(function()
				if c.UserInputState == Enum.UserInputState.End then
					dragToggle=false
				end 
			end)
		end 
	end)

	b.InputChanged:Connect(function(a)
		if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then
			dragInput = a 
		end 
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(a)
		if a==dragInput and dragToggle then
			updateInput(a)
		end 
	end)
end

-- 𝘌𝘹𝘦𝘤𝘶𝘵𝘪𝘰𝘯 --
drag(Panel)

for _, TabButton in pairs(Buttons:GetChildren()) do
	if TabButton.ClassName == "TextButton" then
		TabButton.MouseButton1Click:Connect(function()
			ButtonAnimation(TabButton,"CircleClick",LMouse.X,LMouse.Y)
			OpenTab(TabButton.Text)
		end)
		TabButton.MouseEnter:Connect(function()
			ButtonAnimation(TabButton,"Hover",LMouse.X,LMouse.Y)
		end)
		TabButton.MouseLeave:Connect(function()
			ButtonAnimation(TabButton,"NoHover",LMouse.X,LMouse.Y)
		end)
	end
end

Close.MouseButton1Click:Connect(function()
	ButtonAnimation(Close,"CircleClick",LMouse.X,LMouse.Y)
	Panel:Destroy()
end)
Close.MouseEnter:Connect(function()
	ButtonAnimation(Close,"Hover",LMouse.X,LMouse.Y)
end)
Close.MouseLeave:Connect(function()
	ButtonAnimation(Close,"NoHover",LMouse.X,LMouse.Y)
end)

for _, SelectedTeam in pairs(Teams:GetChildren()) do
	local TeamButton = FillExample:Clone()
	TeamButton.Parent = Fillbox
	TeamButton.Name = SelectedTeam.Name
	TeamButton.Text = SelectedTeam.Name
	TeamButton.MouseButton1Click:Connect(function()
		ButtonAnimation(TeamButton,"CircleClick",LMouse.X,LMouse.Y)
		Teambox.Text = TeamButton.Name
	end)
	TeamButton.MouseEnter:Connect(function()
		ButtonAnimation(TeamButton,"Hover",LMouse.X,LMouse.Y)
	end)
	TeamButton.MouseLeave:Connect(function()
		ButtonAnimation(TeamButton,"NoHover",LMouse.X,LMouse.Y)
	end)
end
FillExample:Destroy()

Teambox:GetPropertyChangedSignal("Text"):connect(function()
	for _,v in pairs(Fillbox:GetChildren()) do
		if v.ClassName == "TextButton" then
			if string.match(string.lower(v.Text),string.lower(Teambox.Text)) then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end
end)

local ButtonSize = 22
local ButtonAmount = 0

function Rescale()
	ButtonAmount = 0
	for _,v in pairs(Fillbox:GetChildren()) do
		if v.ClassName == "TextButton" and v.Visible == true then
			ButtonAmount = ButtonAmount + 1
		end
	end
	Fillbox.CanvasSize = UDim2.new(Fillbox.CanvasSize.X.Scale,Fillbox.CanvasSize.X.Offset,Fillbox.CanvasSize.Y.Scale,ButtonAmount * ButtonSize + 2)
end

Teambox.Changed:Connect(function()
	Rescale()
end)

Change.MouseButton1Click:Connect(function()
	ButtonAnimation(Change,"CircleClick",LMouse.X,LMouse.Y)
	if Teams[Teambox.Text] then
		local Team = Teams[Teambox.Text]
		local TeamEventScript = Workspace:FindFirstChild("TeamEventScript")
		local TeamChangeEvent = TeamEventScript:FindFirstChild("TeamChangeEvent")
		Teambox:ReleaseFocus()
		TeamChangeEvent:FireServer(Team.TeamColor.Name)
	end
end)
Change.MouseEnter:Connect(function()
	ButtonAnimation(Change,"Hover",LMouse.X,LMouse.Y)
end)
Change.MouseLeave:Connect(function()
	ButtonAnimation(Change,"NoHover",LMouse.X,LMouse.Y)
end)

LPlayer.CharacterAdded:Connect(function(LCharacter)
	PlayerThumbnail.Image = Players:GetUserThumbnailAsync(LPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)
end)