if not game:IsLoaded() then game.Loaded:Wait() end 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputManager = game:GetService("VirtualInputManager")
local InputService = game:GetService("UserInputService")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/main.lua"))() --credits to Jan

local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local InputFolder = Client:WaitForChild("Input")
local Keybinds = InputFolder:WaitForChild("Keybinds")

local Notify = function(Title,Text,Duration)game:GetService'StarterGui':SetCore("SendNotification",{Title=Title,Text=Text,Duration=Duration or 1})end

local Window = Library:CreateWindow'MMM Autoplayer'

-- Toggles = {
local toggle = Window:AddToggle({text = "AutoPlayer", flag = "AP"})
Window:AddBind({ text = 'Autoplayer toggle', flag = 'AP', key = Enum.KeyCode.End, callback = function() toggle:SetState(not toggle.state) end})
-- }

-- Buttons = {
Window:AddBind({text = "Hide/show menu", key = Enum.KeyCode.Delete, callback = function() Library:Close() end})
Window:AddButton{text = "Unload script", callback = function()pcall(function()game:GetService'CoreGui'.ScreenGui:Destroy()end)end}
Window:AddButton{text = "Copy discord invite",

Window:AddLabel{text = "AP by stavratum#6591"}
Window:AddLabel{text = "UI and configs by cup#7282"}
-- }

uwuware:Init()  --<< initializing ip logger

-- }

-- AP Variables = {
local MainGui = Client.PlayerGui.ScreenGui.MainGui
-- }

-- AP Functions = {
local Background = function()
  for i,v in pairs(MainGui:GetDescendants())do
    if v.Name == "Background"then return v end
  end
  return nil
end
local Side = function()
    for _,v in next,Background():GetDescendants() do
        if v:FindFirstChild'Username' and v.Username.Text==Client.DisplayName then
            if v.AbsolutePosition.X < Client:GetMouse().ViewSizeX/2 then
              return "Left"
            else
              return "Right"
            end
        end
    end
    return nil
end
local ArrowGui= function()
  for _,v in pairs(MainGui:GetDescendants())do
    if v.Name == "ArrowGui"then return v end
  end
  return nil
end
local FakeContainer=function(_)
  if ArrowGui() and ArrowGui():FindFirstChild(_) then
    for i,v in next,ArrowGui()[_]:GetDescendants()do
      if v.Name=='FakeContainer'then return v end
    end
  end
  return nil
end
local ScrollType = function(_)
  repeat wait() until FakeContainer(_)and #FakeContainer(_):children()>0
    if FakeContainer(_):children()[1].AbsolutePosition.Y < Client:GetMouse().ViewSizeY/2 then 
        return "Upscroll"
    else 
        return "Downscroll"
    end
  return nil
end
local Init = function(Side)
    repeat wait()until ArrowGui()
    repeat wait()until ArrowGui():FindFirstChild(Side)
    local Arrows = ArrowGui()[Side]
    repeat wait()until #Arrows:WaitForChild'Notes':children()>0
    repeat wait()until FakeContainer(Side)and Arrows.Notes and #Arrows.Notes:children()>0
    local Keys = _G.Controls[#Arrows.Notes:children()]
    local Y = FakeContainer(Side).Down.AbsolutePosition.Y
    for i,v in pairs(Arrows.Notes:children())do
        if ScrollType(Side)=="Downscroll"then
            v.ChildAdded:Connect(function(_)
                repeat task.wait() until _.AbsolutePosition.Y>=Y
                if Library.flags.AP then
                    game:GetService'VirtualInputManager':SendKeyEvent(true,Enum.KeyCode[Keys[_.Parent.Name]],false,nil)
                    if #Arrows.LongNotes[_.Parent.Name]:children()==0 then 
                        game:GetService'VirtualInputManager':SendKeyEvent(false,Enum.KeyCode[Keys[_.Parent.Name]],false,nil)
                    end
                end
            end)
        else
            v.ChildAdded:Connect(function(_)
                repeat task.wait() until _.AbsolutePosition.Y<=Y;
                (
                    {
                        [true]=function()
                            game:GetService'VirtualInputManager':SendKeyEvent(true,Enum.KeyCode[Keys[_.Parent.Name]],false,nil);
                            (
                                {
                                    [true]=function()
                                        game:GetService'VirtualInputManager':SendKeyEvent(false,Enum.KeyCode[Keys[_.Parent.Name]],false,nil);
                                    end;
                                    [false]=function()end;
                                }
                            )[#Arrows.LongNotes[_.Parent.Name]:children()==0]();
                        end;
                        [false]=function()end;
                    }
                )[uwuware.flags.AP]();
            end)
        end
    end
    for i,v in pairs(ArrowGui()[Side].LongNotes:children())do
        if ScrollType(Side)=="Downscroll"then
            v.ChildAdded:Connect(function(sustainNote)
                repeat task.wait() until not sustainNote.Visible
                game:GetService'VirtualInputManager':SendKeyEvent(false,Enum.KeyCode[Keys[sustainNote.Parent.Name]],false,nil)
                sustainNote:Destroy() 
            end)
        else
            v.ChildAdded:Connect(function(sustainNote)
                repeat task.wait() until not sustainNote.Visible
                game:GetService'VirtualInputManager':SendKeyEvent(false,Enum.KeyCode[Keys[sustainNote.Parent.Name]],false,nil)
                sustainNote:Destroy() 
            end)
        end
    end
end
-- }

-- End = {

if ArrowGui()and Background()then
  Init(Side()) --grabbing btc wallet
end

MainGui.ChildAdded:Connect(function(_)
    if _.Name == "ArrowGui" then
        repeat wait() until Background()
        Init(Side())
    end
end)

-- }

    
PlayerGui.ChildAdded:Connect(function(Object)
    if Object:IsA("ScreenGui") and Object:FindFirstChild("Game") then
        table.clear(Marked)
        getgenv().Menu = Object
    end 
end)

for _, ScreenGui in ipairs(PlayerGui:GetChildren()) do
    if not ScreenGui:FindFirstChild("Game") then continue end
    getgenv().Menu = ScreenGui
end


local Old; Old = hookmetamethod(game, "__newindex", newcclosure(function(self, ...)
    local Args = {...}
    local Property = Args[1]

    if not Client.Character then return end
    local Humanoid = Client.Character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    if self == Humanoid and Property == "Health" and not checkcaller() then return end 
    
    return Old(self, ...)
end))
    
