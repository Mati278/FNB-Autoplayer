if not game:IsLoaded() then game.Loaded:Wait() end
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
};
local spLimit = 12
local SplashIndex = math.random(1,spLimit)
local SplashText

if SplashIndex == 1 then SplashText = 'hi guys hows doin there' end
if SplashIndex == 2 then SplashText = 'Did u know that that in terms of male human and female pokemon breeding...' end
if SplashIndex == 3 then SplashText = 'They took everything from me: my voice, my freedom, my legacy; and they replaced me with some blue haired kid' end
if SplashIndex == 4 then SplashText = 'discord.gg/pizzahut worst place ever' end
if SplashIndex == 5 then SplashText = 'amogus ඞ' end --IT FINALLY LOADS THE AMOGUS SYMBOL LETS FUCKING GOOOOOO
if SplashIndex == 6 then SplashText = 'Go play PFN instead, there is a exploit-less botplay' end
if SplashIndex == 7 then SplashText = 'swish i fixed the autoplayer for u :)' end
if SplashIndex == 8 then SplashText = 'nah my man fq0e, kill urself instead u gigantic faggot' end
if SplashIndex == 9 then SplashText = 'Friday Night Funkin’: Vs. MX/Mario 85 - Game Over (ft. Kiwiquest) (+ FLP)' end
if SplashIndex == 10 then SplashText = 'you will to be silenced' end --credits to Oveja3928! (yt)
if SplashIndex == 11 then SplashText = 'Are u winning, son?' end --credits to Skeleton19!
if SplashIndex == 12 then SplashText = 'Now █████████████████-proof!' end

local Client = game:GetService'Players'.LocalPlayer
local Input = Client:WaitForChild"Input"
local PlayerGui = Client.PlayerGui
loadstring(game:HttpGet"https://raw.githubusercontent.com/stavratum/lua/main/fnb/hooks.lua")() -- robo sucks my dick rn
local Offsets = loadstring(game:HttpGet"https://raw.githubusercontent.com/Mati278/FNB-Autoplayer/main/Offsets.lua")()
local Keys = {
    [4] = { Left = "Left", Down = "Down", Up = "Up", Right = "Right" },
    [5] = { Left = "Left", Down = "Down", Space = "Space", Up = "Up", Right = "Right" },
    [6] = { S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3" },
    [7] = { S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3" },
    [8] = { A = "L4", S = "L3", D = "L2", F = "L1", H = "R1", J = "R2", K = "R3", L = "R4" },
    [9] = { A = "L4", S = "L3", D = "L2", Space = "Space", F = "L1", H = "R1", J = "R2", K = "R3", L = "R4" }
}

local yeah = Client.userId
local function GetFuckedLmao()
    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer("Input", "69420", "Points")
    task.wait(0.5)
    Client:Kick(string.format('You deserve it, dirty cheater. If the fnb devs cant do it , i will'))
end  
if id == 506813014 then
    GetFuckedLmao()
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
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = Library:MakeWindow({IntroText = tostring(SplashText),Name = "Friday Night Bloxxin' Autoplayer", HidePremium = true, SaveConfig = true, ConfigFolder = 'fnb ap probably'})
local Folder = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local CreditsFolder = Window:MakeTab({Name = "Credits", Icon = "rbxassetid://2484564290", PremiumOnly = false})
local KeybindFolder = Window:MakeTab({Name = "Keybinds", Icon = "rbxassetid://6472846460", PremiumOnly = false})
local ExtrasFolder = Window:MakeTab({Name = "Extras", Icon = "rbxassetid://7468828225", PremiumOnly = false})
local Toggle = Folder:AddToggle({Name = "Autoplayer", Default = true, Flag = "hello", Save = true})
KeybindFolder:AddBind({Name = "Autoplayer toggle", Default = Enum.KeyCode.End, Hold = false, Flag = 'helloT', Save = true, Callback = function() Toggle:Set(not Toggle.Value) end})
local OffsetToggle = Folder:AddSlider({Name = "Hit offset", Min = -50, Max = 50, Default = 0, Color = Color3.fromRGB(255,255,255), Increment = 0.1, Flag = "ms", Save = true})
Folder:AddTextbox({Name = "above", Default = "0", extDisappear = false, Callback = function(Value) OffsetToggle:Set(Value) end})
local Mode = Folder:AddDropdown({Name = "Hit mode", Default = "Virtual Input", Options = {"Virtual Input", "Fire Signal"}, Flag = "apMode", Save = true})
local function ModeSwitch()
    if Library.Flags["apMode"].Value == 'Fire Signal' then
        Mode:Set("Virtual Input")
        Library:MakeNotification({Name = "Input mode switch", Content = "Current mode:"..' '..tostring(Library.Flags["apMode"].Value), Image = "rbxassetid://8370951784", Time = 3})
    else
        Mode:Set("Fire Signal")
        Library:MakeNotification({Name = "Input mode switch", Content = "Current mode:"..' '..tostring(Library.Flags["apMode"].Value), Image = "rbxassetid://8370951784", Time = 3})
    end
end
KeybindFolder:AddBind({Name = "Switch input modes", Default = Enum.KeyCode.Home, Hold = false, Flag = 'apST', Save = true, Callback = function() ModeSwitch() end})
Folder:AddButton({Name = "Disable modcharts", Callback = function() loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/haha-hes-not-gonna-find-this/main/thing.lua')() Library:MakeNotification({Name = "Note", Content = "You need to rejoin in order to re-enable modcharts", Image = "rbxassetid://8370951784", Time = 5}) end})
KeybindFolder:AddBind({Name = "Reset", Default = Enum.KeyCode.PageUp, Hold = false, Flag = 'lmao', Save = true, Callback = function() Client.Character:BreakJoints() end})
CreditsFolder:AddLabel("Made by Mati278")
CreditsFolder:AddLabel("AC Bypass & extra help by stavratum")
CreditsFolder:AddLabel("UI Library by shlexware")
ExtrasFolder:AddButton({Name = "Unload script", Callback = function()
    Library:Destroy()
    set_identity(7);
    connections:disconnect();
    script:Destroy()
end})
ExtrasFolder:AddButton({Name = "Instant Solo", Callback = function() Client.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer() end})
KeybindFolder:AddBind({Name = "Instant Solo", Default = Enum.KeyCode.PageDown, Hold = false, Flag = 'SoloKey', Save = true, Callback = function() Client.PlayerGui:WaitForChild'SingleplayerUI'.ButtonPressed:FireServer() end})
ExtrasFolder:AddButton({Name = "TP To John Bomb (gives badge but not the anim)", Callback = function() game:GetService'TeleportService':Teleport(9229851010, Client) end})
ExtrasFolder:AddButton({Name = "Load old version", Callback = function() 
    Library:Destroy()
    set_identity(7);
    connections:disconnect();
    script:Destroy()
    loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/hello-again-lol/main/real.lua')() 
end})

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
            if Library.Flags["apMode"].Value == 'Fire Signal' then
                set_identity(2);
                    
                spawn(inputFunction, {
                    KeyCode = Input,
                    UserInputState = begin
                });
              
                local Bar = Arrow.Frame.Bar;
                while Bar.Size.Y.Scale >= 0.6 do
                    wait();
                end
                
                spawn(inputFunction, { KeyCode = Input });
            else  
                VirtualInputManager:SendKeyEvent(true, Input, false, nil);
                local Bar = Arrow.Frame.Bar;
                while Bar.Size.Y.Scale >= 0.6 do
                    wait();
                end
                VirtualInputManager:SendKeyEvent(false, Input, false, nil);
            end;
        end )
    end
end;

connections:add(PlayerGui.ChildAdded, onChildAdded);
task.spawn(onChildAdded, PlayerGui:FindFirstChild"FNFEngine")

for i,v in pairs(workspace:GetDescendants()) do
    if v.ClassName == "ProximityPrompt" then
        v.HoldDuration = 0;
    end
end

if Input.Keybinds.R4.Value == ";" then
    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer("Input", "Semicolon", "R4")
end
