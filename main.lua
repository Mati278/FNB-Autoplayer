if not game:IsLoaded() then game.Loaded:Wait() end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/o5u3/Friday-Night-Bloxxin-Autoplayer/main/uwuware-ui-edit"))()

local _,_00 = loadstring(game:HttpGet'https://raw.githubusercontent.com/stavratum/lua-script/main/fnb/_.lua')()

local Client = game:GetService'Players'.LocalPlayer
local VirtualInputManager = game:GetService'VirtualInputManager'
local RunService = game:GetService'RunService'
local ReplicatedStorage = game:GetService'ReplicatedStorage'
local PlayerGui = Client:WaitForChild'PlayerGui' --accidentally fucked instant solo
local HttpService = game:GetService'HttpService'

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

local Window = Library:CreateWindow("hi") 
local Folder = Window:AddFolder("main") 

local Updates = Window:AddFolder'Changelogs'
local CreditsFolder = Window:AddFolder("Credits")

local Autoplay = function(Child)
    repeat wait() until Child.Config.TimePast.Value >= -1
    
    local Arrows = Child.Game[Child.PlayerSide.Value].Arrows
    local IncomingNotes = Arrows.IncomingNotes:children()
    
    local Song = FindDescendant(ReplicatedStorage.Songs,Child.LowerContainer.Credit.Text:split'\n'[1])
    local GimmickNotes = _['G'..'immic'..'kNo'..'tes'](_)
    print('Song: ' .. tostring(Song))
    if Song then
        GimmickNotes = Song:FindFirstChild'MultiplieGimmickNotes' and Song:FindFirstChild'MultiplieGimmickNotes'.Value == 'OnHit'  or 
        Song:FindFirstChildOfClass'ModuleScript' and Song:FindFirstChildOfClass'ModuleScript':FindFirstChild'GimmickNotes'
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
        Connected[#Connected + 1] = Holder.ChildAdded:Connect(
            function(Arrow)
                local ModuleScript = Arrow:FindFirstChildOfClass'ModuleScript'
                if not Arrow.HellNote.Value or Arrow.HellNote.Value and _require(ModuleScript).Type ~= 'OnHit' and not GimmickNotes then
                    local Input = Keys[Holder.name]

                    task.wait(.4 + math.floor(Library.flags.BAcc)/1000)
                    --i feel like smth is missing
                    if Library.flags.Sus then
                        VirtualInputManager:SendKeyEvent(true,Input,false,nil)
                        repeat RunService.RenderStepped:Wait() until not Arrow or not Arrow:FindFirstChild'Frame' or Arrow.Frame.Bar.Size.Y.Scale <= 0.3
                        VirtualInputManager:SendKeyEvent(false,Input,false,nil)
                    end
                end
            end
        )
    end
end

Connected[#Connected + 1] =
Client.PlayerGui.ChildAdded:Connect(
    function(Child)
        if Child.name == 'FNFEngine' then 
            Autoplay(Child)
        end
    end
)

for i,v in pairs(game:GetService"Workspace":GetDescendants()) do
    if v:IsA'ProximityPrompt' then
        v.HoldDuration = 0
    end
end

if Client.PlayerGui:FindFirstChild'FNFEngine' then
    Autoplay(Client.PlayerGui.FNFEngine)
end

local toggle = Folder:AddToggle({text = "AutoPlayer", flag = "Sus", state = true})

Folder:AddBind({ text = 'Autoplayer toggle', flag = 'Sus', key = Enum.KeyCode.End, callback = function() toggle:SetState(not toggle.state) end})

Window:AddSlider{text="Bot Accuracy (ms)",flag = "BAcc",min = -75, max = 75,value = -45.7}

Window:AddBind({text = "Hide/show menu", key = Enum.KeyCode.Delete, callback = function() Library:Close() end})

CreditsFolder:AddLabel({text = "Original Script: Kaiden#2444"})
CreditsFolder:AddLabel({text = "Thanks to stavratum 4 help"})
CreditsFolder:AddLabel({text = "UI Library: Jan & Wally"})

Updates:AddLabel({text = "Basically code overhaul lol"})
Updates:AddLabel({text = "HI stav :)"})

Window:AddButton({ text = 'Unload script', callback = function() 
    toggle:SetState(false)
    HttpService:GenerateGUID(false)
    if Library.open then Library:Close() end
    pcall(RunService.UnbindFromRenderStep, RunService, shared._id)
    Library.base:ClearAllChildren()
    Library.base:Destroy()
    script:Destroy()
end })

Window:AddButton({text = "Instant Solo", callback = function()
    pcall(function()
        PlayerGui.SingleplayerUI.ButtonPressed:FireServer()
    end)
end})

Library:Init()
Library.cursor.Visible = false
