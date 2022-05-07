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

local KeysTable = {
    ["4"] = {"Up", "Down", "Left", "Right"},
    ["6"] = {S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3"},
    ["7"] = {S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3"},
    ["9"] = {A = "L4", S = "L3", D = "L2", F = "L1", Space = "Space", H = "R1", J = "R2", K = "R3", L = "R4"}
}

local Marked = {}

local Window = Library:CreateWindow("FNB Auto Play") 
local Folder = Window:AddFolder("Autoplayer") 

local CreditsFolder = Window:AddFolder("Credits")

RunService.Heartbeat:Connect(function()
    if not Library.flags.AutoPlayer then return end
    if not Menu or not Menu.Parent then return end
    if Menu.Config.TimePast.Value <= 0 then return end
    
    local SideMenu = Menu.Game:FindFirstChild(Menu.PlayerSide.Value)
    local IncomingNotes = SideMenu.Arrows.IncomingNotes
    
    local Keys = KeysTable[tostring(#IncomingNotes:GetChildren())] or IncomingNotes:GetChildren()
    
    for Key, Direction in pairs(Keys) do 
        Direction = tostring(Direction)
        
        local Holder = IncomingNotes:FindFirstChild(Direction) or IncomingNotes:FindFirstChild(Key)
        if not Holder then continue end
        
        for _, Object in ipairs(Holder:GetChildren()) do 
            if table.find(Marked, Object) then continue end
            
            local Keybind = Keybinds:FindFirstChild(Direction) and Keybinds[Direction].Value
            if not Keybind then warn("Couldn't find bind!") continue end
            
            local Start = SideMenu.Arrows:FindFirstChild(Direction) and SideMenu.Arrows[Direction].AbsolutePosition.Y or SideMenu.Arrows[Key].AbsolutePosition.Y
            local Current = Object.AbsolutePosition.Y
            local Difference = not InputFolder.Downscroll.Value and (Current - Start) or (Start - Current)
            
            local IsHell = Object:FindFirstChild("HellNote") and Object:FindFirstChild("HellNote").Value
            
            if Difference <= 0.35 and not IsHell then
                Marked[#Marked + 1] = Object
                InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= 0
                InputManager:SendKeyEvent(false, Enum.KeyCode[Keybind], false, nil)
            end
        end
    end 
end)

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

local OldNameCall; OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if getnamecallmethod() == "FireServer" and tostring(self) == "RemoteEvent" and self:IsDescendantOf(game:GetService("ReplicatedStorage").Events) then
        return wait(9e9)
    end
    
    return OldNameCall(self, ...)
end))

Window:AddLabel({text = "Bypassed tash anti!"})
Folder:AddToggle({text = "AutoPlayer", flag = "AutoPlayer"})
Window:AddBind({text = "Hide/show menu", key = Enum.KeyCode.Delete, callback = function() Library:Close() end})

CreditsFolder:AddLabel({text = "Original Script: Kaiden#2444"})
CreditsFolder:AddLabel({text = "UI Library: Jan"})

Window:AddButton({text = "Instant Solo", callback = function()
    pcall(function()
        PlayerGui.SingleplayerUI.ButtonPressed:FireServer()
    end)
end})

Library:Init()

warn("Loaded script!")
