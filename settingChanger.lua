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

local SettingValue
local Setting
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = Library:MakeWindow({IntroText = yes,Name = "fnb setting thing", HidePremium = true})
local Folder = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
Folder:AddTextbox({Name = "Setting value", Default = "1", extDisappear = false, Callback = function(Value) SettingValue = Value end})
Folder:AddTextbox({Name = "Setting to change", Default = "ScrollSpeed", extDisappear = false, Callback = function(Value) SettingValue = Value end})
Folder:AddButton({Name = "Apply changes", Callback = function() game:GetService'ReplicatedStorage'.Events.RemoteEvent:FireServer("Input", tostring(SettingValue), tostring(Setting)) Library:MakeNotification({Name = "Done!", Content = "Changes applied. If changes didn't apply the game tried to ban u", Image = "rbxassetid://8370951784", Time = 3}) end})
Library:Init()
