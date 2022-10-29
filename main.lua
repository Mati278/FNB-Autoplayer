if not game:IsLoaded() then game.Loaded:Wait() end

local Client = game:GetService'Players'.LocalPlayer
local RunService = game:GetService'RunService'
local ReplicatedStorage = game:GetService'ReplicatedStorage'
local broWTH = loadstring(game:HttpGet'https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Maid.lua')().new()
local test = Client.userId
loadstring(game:HttpGet"https://raw.githubusercontent.com/stavratum/lua/main/fnb/hooks.lua")()-- have fun lol

if test == 2674402052 then
    Client:Kick(string.format('ur mom fat lol'))
end

local ChildAdded
local Connected = {}

--Once a wise man said:

local VirtualInputManager = game:GetService'VirtualInputManager' -- I can freely use this service

    --This is impossible to patch
    --Suck my dick Robo


local ChildAdded
local Connected = {}

local function _require(_)
    return _ and require(_) or {}
end

local function FindDescendant(Inst,Excepted)
    for i,v in pairs(Inst:GetDescendants()) do
        if tostring(v) == Excepted then
            return v
        end
    end
    return nil
end

local uwuware = loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/gfx.lua')()
local Window = uwuware:CreateWindow"FNB Auto Play"
local FolderMain = Window:AddFolder("main") 

local CreditsFolder = Window:AddFolder("Credits")

local toggle = FolderMain:AddToggle({text = "AutoPlayer", flag = "yes", state = true})

FolderMain:AddBind({ text = 'Autoplayer toggle', flag = 'yes', key = Enum.KeyCode.End, callback = function() toggle:SetState(not toggle.state) end})
FolderMain:AddSlider({ text= 'Bot accuracy (ms)',flag = "ms", min = -1000, max = 1000, value = 0}) --discovered that this is ss dependant lol
FolderMain:AddBind({ text = 'commit kys', flag = 'lmao', key = Enum.KeyCode.PageDown, callback = function() Client.Character:BreakJoints() end})

Window:AddBind({ text = "Hide/show menu", key = Enum.KeyCode.Delete, callback = function() uwuware:Close() end})

CreditsFolder:AddLabel({text = "Tweaked by Mati278 & stavratum"})
CreditsFolder:AddLabel({text = "UI Library: Jan & Wally"})

Window:AddLabel({text= "me back after long break"})
Window:AddButton{text="Unload script",callback=function()
    for _,Function in pairs(Connected) do
        Function:Disconnect()
    end
    uwuware.base:Destroy()
    script:Destroy()
end}

FolderMain:AddButton{text="Disable modcharts",callback=function()
    loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/thing.lua')()
    game:GetService("StarterGui"):SetCore("SendNotification", { 
        Title = "Note";
        Text = "You need to rejoin to re-enable modcharts";
        Icon = "rbxthumb://type=Asset&id=8370951801&w=420&h=420"})
end} 

Window:AddButton{text="Instant Solo",callback=function()
    Client.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer()
end}

Window:AddLabel({text="^ useless now ^"})
Window:AddButton{text="Old ver (aka kiwi ver)",callback=function()
    for _,Function in pairs(Connected) do
        Function:Disconnect()
    end
    uwuware.base:Destroy()
    script:Destroy()
    loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/hello-again-lol/main/real.lua')()
end}     
uwuware:Init()
uwuware.cursor.Visible = false

local Init = function(Child)
    wait(1)
    repeat wait() until Child.Config.TimePast.Value >= -1
    if not uwuware.flags.yes then return end
    local Arrows = Child.Game[Child.PlayerSide.Value].Arrows
    local IncomingNotes = Arrows.IncomingNotes:children()
    
    local Song = FindDescendant(ReplicatedStorage.Songs,Child.LowerContainer.Credit.Text:split'\n'[1]:split' ('[1])
    local GimmickNotes
    print('Song: ' .. tostring(Song))
    if Song then
        GimmickNotes = Song:FindFirstChild'MultiplieGimmickNotes' and Song:FindFirstChild'MultiplieGimmickNotes'.Value == 'OnHit'  or 
        Song:FindFirstChildOfClass'ModuleScript' and Song:FindFirstChildOfClass'ModuleScript':FindFirstChild'GimmickNotes'
        or Song:FindFirstChild'GimmickNotes'
    end
    GimmickNotes = GimmickNotes and GimmickNotes.Value or nil
    
    local Keybinds,KeyCode = Client.Input.Keybinds,Enum.KeyCode
    local Keys = (
        {
            [4] = {
                Left = KeyCode[Keybinds.Left.Value],
                Down = KeyCode[Keybinds.Down.Value],
                Up = KeyCode[Keybinds.Up.Value],
                Right = KeyCode[Keybinds.Right.Value]
            },
            [5] = {
                Left = KeyCode[Keybinds.Left.Value],
                Down = KeyCode[Keybinds.Down.Value],
                Space = KeyCode[Keybinds.Space.Value],
                Up = KeyCode[Keybinds.Up.Value],
                Right = KeyCode[Keybinds.Right.Value]
            },
            [6] = {
                S = KeyCode[Keybinds.L3.Value],
                D = KeyCode[Keybinds.L2.Value],
                F = KeyCode[Keybinds.L1.Value],
                J = KeyCode[Keybinds.R1.Value],
                K = KeyCode[Keybinds.R2.Value],
                L = KeyCode[Keybinds.R3.Value],
            },
            [7] = {
                S = KeyCode[Keybinds.L3.Value],
                D = KeyCode[Keybinds.L2.Value],
                F = KeyCode[Keybinds.L1.Value],
                Space = KeyCode[Keybinds.Space.Value],
                J = KeyCode[Keybinds.R1.Value],
                K = KeyCode[Keybinds.R2.Value],
                L = KeyCode[Keybinds.R3.Value]
            },
            [8] = {
                A = KeyCode[Keybinds.L4.Value],
                S = KeyCode[Keybinds.L3.Value],
                D = KeyCode[Keybinds.L2.Value],
                F = KeyCode[Keybinds.L1.Value],
                H = KeyCode[Keybinds.R1.Value],
                J = KeyCode[Keybinds.R2.Value],
                K = KeyCode[Keybinds.R3.Value],
                L = KeyCode[Keybinds.R4.Value]
            },
            [9] = {
                A = KeyCode[Keybinds.L4.Value],
                S = KeyCode[Keybinds.L3.Value],
                D = KeyCode[Keybinds.L2.Value],
                F = KeyCode[Keybinds.L1.Value],
                Space = KeyCode[Keybinds.Space.Value],
                H = KeyCode[Keybinds.R1.Value],
                J = KeyCode[Keybinds.R2.Value],
                K = KeyCode[Keybinds.R3.Value],
                L = KeyCode[Keybinds.R4.Value]
            }
        }
    )[#IncomingNotes]
    
    Keybinds,KeyCode = nil
    
    for _,Holder in pairs(IncomingNotes) do
        broWTH:GiveTask(
            Holder.ChildAdded:Connect(
                function(Arrow)
                    local ModuleScript = Arrow:FindFirstChildOfClass'ModuleScript'
                    if not Arrow.HellNote.Value or Arrow.HellNote.Value and _require(ModuleScript).Type ~= 'OnHit' and GimmickNotes ~= 'OnHit' then
                        local Input = Keys[Holder.name]
                        task.wait(.4 + math.floor(uwuware.flags.ms)/1000)
                        if uwuware.flags.yes then
                            VirtualInputManager:SendKeyEvent(true,Input,false,nil)
                            repeat task.wait() until not Arrow or not Arrow:FindFirstChild'Frame' or Arrow.Frame.Bar.Size.Y.Scale <= 0.4
                            VirtualInputManager:SendKeyEvent(false,Input,false,nil)
                        end
                    end
                end
            )
        )
    end
    Child.Destroying:Wait()
    broWTH:DoCleaning()
end

ChildAdded = Client.PlayerGui.ChildAdded:Connect(
    function(Child)
        if Child.name == 'FNFEngine' then 
            Init(Child)
        end
    end
)

for i,v in pairs(game:GetService"Workspace":GetDescendants()) do
    if v:IsA'ProximityPrompt' then
        v.HoldDuration = 0
    end
end

if Client.PlayerGui:FindFirstChild'FNFEngine' then
    Init(Client.PlayerGui.FNFEngine)
end
