
for i,v in pairs(game:GetService("ReplicatedStorage").Events:GetDescendants()) do --anti ban 1
    if v:IsA('RemoteEvent') and v.Name == 'banPlayer' then
        v:Destroy()
    end
end

for i,v in pairs(game:GetService("ReplicatedStorage").Misc:GetDescendants()) do -- anti ban 2
    if v:IsA('Model') and v.Name == 'Exploiters' then
        v:Destroy()
    end
end
loadstring(game:HttpGet"https://raw.githubusercontent.com/stavratum/lua/main/fnb/hooks.lua")()
local SettingValue
local Setting
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = Library:MakeWindow({IntroText = 'yes' ,Name = "fnb setting thing", HidePremium = true})
local Folder = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
Folder:AddTextbox({Name = "Setting value", Default = "1", extDisappear = false, Callback = function(Value) SettingValue = Value end})
Folder:AddTextbox({Name = "Setting to change", Default = "ScrollSpeed", extDisappear = false, Callback = function(Value) Setting = Value end})
Folder:AddLabel('You can use Dex to see the available settings!')
local function Apply()
    game:GetService'ReplicatedStorage'.Events.RemoteEvent:FireServer("Input", tostring(SettingValue), tostring(Setting))
end        
Folder:AddButton({Name = "Apply changes", Callback = function() Apply() Library:MakeNotification({Name = "Done!", Content = "Changes applied. If changes didn't apply the game tried to ban u", Image = "rbxassetid://8370951784", Time = 3}) end})
Folder:AddButton({Name = "Load auto", Callback = function() 
    Library:Destroy()
    loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/hello-again-lol/main/main.lua')() 
end})
Library:Init()
