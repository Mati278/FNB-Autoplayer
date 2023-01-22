local Song = "RUN"
local Mod = "Bob's Onslaught"
local Diff = "Hard"

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = Library:MakeWindow({IntroText = 'its real now' ,Name = "Autofarm GUI Edition (original by stavratum)", HidePremium = true})
local AFolder = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
AFolder:AddTextbox({Name = "Song", Default = "RUN", extDisappear = false, Callback = function(Value) Song = Value end})
AFolder:AddTextbox({Name = "Mod", Default = "Bob's Onslaught", extDisappear = false, Callback = function(Value) Mod = Value end})      
AFolder:AddTextbox({Name = "Difficulty", Default = "Hard", extDisappear = false, Callback = function(Value) Diff = Value end})
AFolder:AddDropdown({Name = "Play on side:", Default = "Right", Options = {"Left", "Right"}, Flag = "Side"})
local stage do 
    local stages = workspace.Stages:GetChildren()
    stage = stages[15]
end
--auto copy, will not work without this
local connections = {
    add = function(self, signal, onFire)
        self[#self + 1] = signal:Connect(onFire);
    end,
    disconnect = function(self)
        for i,v in pairs(self) do
            if type(v) == "userdata" and v.Connected then
                v:Disconnect()
            end
        end
        table.clear(self)
    end
}
local RunService = game:GetService'RunService'
local Client = game:GetService'Players'.LocalPlayer
local Input = Client:WaitForChild"Input"
local PlayerGui = Client.PlayerGui
local Offsets = loadstring(game:HttpGet"https://raw.githubusercontent.com/Mati278/FNB-Autoplayer/main/Offsets.lua")()
local Keys = {
    [4] = { Left = "Left", Down = "Down", Up = "Up", Right = "Right" },
    [5] = { Left = "Left", Down = "Down", Space = "Space", Up = "Up", Right = "Right" },
    [6] = { S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3" },
    [7] = { S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3" },
    [8] = { A = "L4", S = "L3", D = "L2", F = "L1", H = "R1", J = "R2", K = "R3", L = "R4" },
    [9] = { A = "L4", S = "L3", D = "L2", Space = "Space", F = "L1", H = "R1", J = "R2", K = "R3", L = "R4" }
}

local id = Client.userId
local function GetFuckedLmao()
    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer("Input", "69420", "Points")
    task.wait(0.5)
    Client:Kick(string.format('You deserve it, dirty cheater. If the fnb devs cant do it , i will'))
end  
if id == 506813014 or id == 2253330791 then
    GetFuckedLmao()
else
    loadstring(game:HttpGet"https://raw.githubusercontent.com/stavratum/lua/main/fnb/hooks.lua")() -- robo sucks my dick rn
end
local oldhmmi
local oldhmmnc
oldhmmi = hookmetamethod(game, "__index", function(self, method)
    if self == Client and method:lower() == "kick" then
        return error("Expected ':' not '.' calling member function Kick", 2)
    end
    return oldhmmi(self, method)
end)
oldhmmnc = hookmetamethod(game, "__namecall", function(self, ...)
    if self == Client and getnamecallmethod():lower() == "kick" then
        return
    end
    return oldhmmnc(self, ...)
end)

local set_identity = (syn and syn.set_thread_identity or setidentity or setthreadcontext);
local Folder = Window:MakeTab({Name = "AP settings", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Toggle = Folder:AddToggle({Name = "Autoplayer", Default = true, Flag = "hello"})
Folder:AddBind({Name = "Autoplayer toggle", Default = Enum.KeyCode.End, Hold = false, Callback = function() Toggle:Set(not Toggle.Value) end})
local OffsetToggle = Folder:AddSlider({Name = "Hit offset", Min = -100, Max = 100, Default = 0, Color = Color3.fromRGB(255,255,255), Increment = 0.1, Flag = "ms"})
Folder:AddTextbox({Name = "above", Default = "0", extDisappear = false, Callback = function(Value) OffsetToggle:Set(Value) end})
Folder:AddButton({Name = "Disable modcharts", Callback = function() loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/thing.lua')() Library:MakeNotification({Name = "Note", Content = "You need to rejoin in order to re-enable modcharts", Image = "rbxassetid://8370951784", Time = 5}) end})
Folder:AddButton({Name = "Unload script", Callback = function()
    Library:Destroy()
    set_identity(7);
    connections:disconnect();
    script:Destroy()
end})
Folder:AddButton({Name = "Instant Solo", Callback = function() Client.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer() end})

Library:Init()

local VirtualInputManager = (getvirtualinputmanager or game.GetService)(game, "VirtualInputManager")
local InputService = game:GetService "UserInputService";
local HttpService = game:GetService "HttpService";
local task    = task;
local type    = type;

local function onChildAdded(Object)
    if (not Object) then return end;
    if (Object.Name ~= "FNFEngine") then return end;
    local require = require
    local function IsOnHit(_) return (_ ~= nil and require(_).Type == "OnHit") end;
    
    local function GetInputFunction()
        local inputFunction;
        set_identity(2);
        for _, v in pairs(getconnections(InputService.InputBegan)) do
            if getfenv(v.Function).script.Name == "Client" then
                inputFunction = v.Function;
            end;
        end;
        set_identity(7);
        return inputFunction;
    end;
    
    local function Filter(iter, method)
        local returns = {};
        for i,v in pairs(iter) do 
            returns[#returns + 1] = method(v);
        end;
        return returns;
    end;

    local Stage = Object.Stage.Value;
    while (not Stage.Config.Song.Value) do
        Object.Config.TimePast.Changed:Wait();
    end;
    
    local Song = Stage.Config.Song.Value;
    local PoisonNotes;
    
    local ScrollSpeed = Input.ScrollSpeedChange.Value and Input.ScrollSpeed.Value or HttpService:JSONDecode( require(Song) ).song.speed;
    local Offset = Offsets[string.format("%.1f", ScrollSpeed)] / 1000 + 0.4;
    
    local Arrows = Object.Game[Object.PlayerSide.Value].Arrows;
    local IncomingNotes = Filter(Arrows.IncomingNotes:GetChildren(), function(v)
        return not string.find(v.Name, "|") and v or nil;
    end );
      
    if Song then
        PoisonNotes =
            (Song.Parent:FindFirstChild"MultiplieGimmickNotes" or Song:FindFirstChild"GimmickNotes" or
            Song.Parent:FindFirstChild"GimmickNotes" or
            Song:FindFirstChild"MineNotes" or {} ).Value == "OnHit";
        print(tostring(Song))
    end;
    
    local Keybinds = Input.Keybinds;
    local Session = {};
    
    if Keys[#IncomingNotes] == nil then
        print(("note count: %d"):format(#IncomingNotes))
        warn("No keys were loaded, report to owner of the script!")
    end;
    
    for kn, kv in pairs(Keys[#IncomingNotes]) do 
        Session[kn] = Enum.KeyCode[ Keybinds[kv].Value ];
    end;


    local inputFunction = GetInputFunction();
    local begin = Enum.UserInputState.Begin;
    local spawn = task.spawn;
    local wait = task.wait;
    
    for _, connection in pairs(getconnections(Object.Events.UserInput.OnClientEvent)) do 
        connection:Disable();
    end;
    
    for _, Holder in pairs(IncomingNotes) do
        connections:add(Holder.ChildAdded, function(Arrow)
            if (Arrow.HellNote.Value) and (PoisonNotes) or IsOnHit(Arrow:FindFirstChildOfClass"ModuleScript") or (not Arrow.Visible) then return; end;
            local Input = Session[Holder.Name];
          
            wait(Offset + Library.Flags["ms"].Value / 1000);
            if not Library.Flags["hello"].Value then return end                
            
            VirtualInputManager:SendKeyEvent(true, Input, false, nil);
            local Bar = Arrow.Frame.Bar;
            while Bar.Size.Y.Scale >= 0.6 do
                wait();
            end
            VirtualInputManager:SendKeyEvent(false, Input, false, nil);
        end )
    end
end;

connections:add(PlayerGui.ChildAdded, onChildAdded);
task.spawn(onChildAdded, PlayerGui:FindFirstChild"FNFEngine")

local virtualUser = game:GetService'VirtualUser'
local awc = { }

local function delay(w, f, ...)
    wait(w);
    (f or function() end)(...);
end

local function enterStage()
    local stem
    if Library.Flags["Side"].Value == 'Left' then
    	stem = stage.MicrophoneA.Stem
    else
    	stem = stage.MicrophoneB.Stem
    end
    Client.Character.HumanoidRootPart.CFrame = CFrame.new(stem.Position.X, stem.Position.Y, stem.Position.Z)
    delay(1, fireproximityprompt, stem.Enter, 0)
end

local function pickSong()
    stage.Events.PlayerSongVote:FireServer(tostring(Song), tostring(Diff), tostring(Mod));
end

local function update()
    delay(1, enterStage)
    Client.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer()
    delay(2, pickSong)
end

--
Client.Idled:connect(function()
	virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	wait(1)
	virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
	
local ccts = Client.PlayerGui.ChildRemoved:Connect(function(object)
	if object.name == "FNFEngine" then
	    update() 
	end
end)


    update()


function _G:Clear()
    ccts:Disconnect()
    
    client.CameraMode = "Classic"
    _G.Clear = nil
end