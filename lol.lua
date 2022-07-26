if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local InputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/fnb%20bypass%20lib.lua"))()

local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local InputFolder = Client:WaitForChild("Input")
local Keybinds = InputFolder:WaitForChild("Keybinds")

local Old
local LP = Players.LocalPlayer

local Marked = {}

local KeysTable = {
    ["4"] = {"Up", "Down", "Left", "Right"},
    ["6"] = {S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3"},
    ["7"] = {S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3"},
    ["9"] = {A = "L4", S = "L3", D = "L2", F = "L1", Space = "Space", H = "R1", J = "R2", K = "R3", L = "R4"}
}

local Window = Library:CreateWindow("hi") 
local Folder = Window:AddFolder("main") 

local CreditsFolder = Window:AddFolder("Credits")

RunService.Heartbeat:Connect(function()
    for i, v in pairs(LP.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") and v.Name == "xploitStuff" then 
            v:Destroy()
        end
    end
    for i, v in pairs(game:GetService("ReplicatedStorage").Modules.Util:GetDescendants()) do
        if v:IsA("ImageLabel") and v.Name == "boo" or v.Name == "otherboo" then
            v:Destroy()
        end
    end

    if not Library.flags.Sus then return end
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
            
            if Difference < 0.3 and Library.flags.SpecialNotes then
                Marked[#Marked + 1] = Object
                InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= 0
                InputManager:SendKeyEvent(false, Enum.KeyCode[Keybind], false, nil)  
            end
                            
            if Difference < 0.3 and not IsHell then
                if not Library.flags.SpecialNotes then
                    Marked[#Marked + 1] = Object
                    InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                    repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= 0
                    InputManager:SendKeyEvent(false, Enum.KeyCode[Keybind], false, nil)
                end
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

Old = hookmetamethod(game, "__newindex", newcclosure(function(self, ...)
    local Args = {...}
    local Property = Args[1]

    if not Client.Character then return end
    local Humanoid = Client.Character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    if self == Humanoid and Property == "Health" and not checkcaller() then return end
    
    return Old(self, ...)
end))

if Library.flags.Sus then
    Library.flags.SpecialNotes = false
end

local toggle = Folder:AddToggle({text = "AutoPlayer", flag = "Sus"})

Window:AddLabel({text= "Added version switcher"})
Folder:AddBind({ text = 'Autoplayer toggle', flag = 'Sus', key = Enum.KeyCode.Home, callback = function() toggle:SetState(not toggle.state) end})

local special = Folder:AddToggle({text = "Hit gimmick notes", flag = "SpecialNotes"})
Folder:AddBind({ text = 'Thing above', flag = 'SpecialNotes', key = Enum.KeyCode.PageDown, callback = function() special:SetState(not special.state) end})

Window:AddBind({text = "Hide/show menu", key = Enum.KeyCode.Delete, callback = function() Library:Close() end})

CreditsFolder:AddLabel({text = "Original Script: Kaiden#2444"})
CreditsFolder:AddLabel({text = "Thanks to KiwisASkid 4 help"})
CreditsFolder:AddLabel({text = "UI Library: Jan & Wally"})

Window:AddButton({ text = 'Unload script', callback = function() 
    toggle:SetState(false)
    special:SetState(false)
    HttpService:GenerateGUID(false)
    if Library.open then Library:Close() end
    pcall(function()
        RunService:ClearAllChildren()
        Library.base:ClearAllChildren()
        Library.base:Destroy()         
    end)
end })

Window:AddButton({ text = 'Load new version', callback = function()  
    toggle:SetState(false)
    special:SetState(false)
    HttpService:GenerateGUID(false)
    if Library.open then Library:Close() end
    pcall(function()
        RunService:ClearAllChildren()
        Library.base:ClearAllChildren()
        Library.base:Destroy()  
    end)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/main.lua"))()
end })

Library:Init() --hi guys:)
Library.cursor.Visible = false
