if not game:IsLoaded() then game.Loaded:Wait() end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local InputManager = getvirtualinputmanager or game:GetService("VirtualInputManager")
loadstring(game:HttpGet"https://raw.githubusercontent.com/stavratum/lua/main/fnb/hooks.lua")()
local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local InputFolder = Client:WaitForChild("Input")
local Keybinds = InputFolder:WaitForChild("Keybinds")

local Marked = {}

local KeysTable = {
    ["4"] = {"Up", "Down", "Left", "Right"},
    ["6"] = {S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3"},
    ["7"] = {S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3"},
    ["8"] = {A = "L4", S = "L3", D = "L2", F = "L1", H = "R1", J = "R2", K = "R3", L = "R4"},
    ["9"] = {A = "L4", S = "L3", D = "L2", F = "L1", Space = "Space", H = "R1", J = "R2", K = "R3", L = "R4"}
}

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = Library:MakeWindow({IntroText = "robo sucks my dick 24/7",Name = "hello", HidePremium = true, SaveConfig = false})
local Folder = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local CreditsFolder = Window:MakeTab({Name = "Credits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local ExtrasFolder = Window:MakeTab({Name = "Extras", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Toggle = Folder:AddToggle({Name = "Autoplayer", Default = false, Flag = "Sus"})
Folder:AddBind({Name = "AP toggle", Default = Enum.KeyCode.Delete, Hold = false,Callback = function() Toggle:Set(not Toggle.Value) end})
local SpToggle = Folder:AddToggle({Name = "Hit gimmick notes", Default = false, Flag = "Special"})
Folder:AddBind({Name = "Thing above", Default = Enum.KeyCode.End, Hold = false,Callback = function() SpToggle:Set(not SpToggle.Value) end})
CreditsFolder:AddLabel("Original script by Kaiden#2444")
CreditsFolder:AddLabel("Tweaked by Mati278 & o5u3/Kiwi")
CreditsFolder:AddLabel("AC Bypass by stavratum")
CreditsFolder:AddLabel("UI Library by shlexware")
ExtrasFolder:AddButton({Name = "Unload script", Callback = function() Toggle:Set(false) SpToggle:Set(false) RunService:ClearAllChildren() Library:Destroy() end})
ExtrasFolder:AddButton({Name = "Instant Solo (useless atm)", Callback = function() game:GetService'Players'.LocalPlayer.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer() end})
ExtrasFolder:AddButton({Name = "Unload script", Callback = function() Toggle:Set(false) SpToggle:Set(false) RunService:ClearAllChildren() Library:Destroy() loadstring(game:HttpGet("https://raw.githubusercontent.com/Mati278/FNB-Autoplayer/main/main.lua"))() end})


RunService.Heartbeat:Connect(function()
    if not Library.Flags["Sus"].Value then return end
    if not Menu or not Menu.Parent then return end
    if Menu.Config.TimePast.Value <= 0 then return end
    
    local SideMenu = Menu.Game:FindFirstChild(Menu.PlayerSide.Value)
    local IncomingArrows = SideMenu.Arrows.IncomingNotes

    local Keys = KeysTable[tostring(#IncomingArrows:GetChildren())] or IncomingArrows:GetChildren()

    for Key, Direction in pairs(Keys) do
        Direction = tostring(Direction)

        local ArrowsHolder = IncomingArrows:FindFirstChild(Direction) or IncomingArrows:FindFirstChild(Key)
        if not ArrowsHolder then continue end

        for _, Object in ipairs(ArrowsHolder:GetChildren()) do
            if table.find(Marked, Object) then continue end
            local Keybind = Keybinds:FindFirstChild(Direction) and Keybinds[Direction].Value

            local Start = SideMenu.Arrows:FindFirstChild(Direction) and SideMenu.Arrows[Direction].AbsolutePosition.Y or SideMenu.Arrows[Key].AbsolutePosition.Y
            local Current = Object.AbsolutePosition.Y
            local Difference = not InputFolder.Downscroll.Value and (Current - Start) or (Start - Current)

            local IsHell = Object:FindFirstChild("HellNote") and Object:FindFirstChild("HellNote").Value
            local OnMiss = Object:FindFirstChild("GimmickNotes") and Object:FindFirstChild("GimmickNotes").Value

            if Difference <= 0.35 and not IsHell then
                Marked[#Marked + 1] = Object

                InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= -1
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
