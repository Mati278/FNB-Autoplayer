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

local framework, scrollHandler, network
local counter = 0

while true do
    for _, obj in next, getgc(true) do
        if type(obj) == 'table' then 
            if rawget(obj, 'GameUI') then
                framework = obj;
            elseif type(rawget(obj, 'Server')) == 'table' then
                network = obj;     
            end
        end

        if network and framework then break end
    end

    for _, module in next, getloadedmodules() do
        if module.Name == 'ScrollHandler' then
            scrollHandler = module;
            break;
        end
    end 

    if (type(framework) == 'table' and typeof(scrollHandler) == 'Instance' and type(network) == 'table') then
        break
    end

    counter = counter + 1
    if counter > 6 then
        fail(string.format('Failed to load game dependencies. Details: %s, %s, %s', type(framework), typeof(scrollHandler), type(network)))
    end
    wait(1)
end

local fireSignal, rollChance do
    -- updated for script-ware or whatever
    -- attempted to update for krnl

    function fireSignal(target, signal, ...)
        -- getconnections with InputBegan / InputEnded does not work without setting Synapse to the game's context level
        set_identity(2)
        local didFire = false
        for _, signal in next, getconnections(signal) do
            if type(signal.Function) == 'function' and islclosure(signal.Function) then
                local scr = rawget(getfenv(signal.Function), 'script')
                if scr == target then
                    didFire = true
                    pcall(signal.Function, ...)
                end
            end
        end
        -- if not didFire then fail"couldnt fire input signal" end
        set_identity(7)
    end
end

local toggle = Folder:AddToggle({text = "AutoPlayer", flag = "AutoPlayer"})

Window:AddLabel({text = "Bypassed tash anti!"})
Folder:AddBind({ text = 'Autoplayer toggle', flag = 'AutoPlayer', key = Enum.KeyCode.End, callback = function() toggle:SetState(not toggle.state) end})

local Special = Folder:AddToggle({text = "Hit gimmick notes", flag = "SpecialNotes"})

Folder:AddBind({ text = 'Thing above', flag = 'SpecialNotes', key = Enum.KeyCode.PageDown, callback = function() Special:SetState(not Special.state) end})
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
