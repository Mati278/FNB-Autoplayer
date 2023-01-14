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
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/stavratum/lua/main/fnb/uwuware.lua'))()
local Folder = Library:CreateWindow('fnb setting thing')
Folder:AddBox({ text = 'Setting value', value = 'true', flag = 'SValue' })
Folder:AddBox({ text = 'Setting value', value = 'Downscroll', flag = 'SName' })
Folder:AddLabel({text='Use Dex to see settings!'})
local function Apply()
    game:GetService'ReplicatedStorage'.Events.RemoteEvent:FireServer("Input", tostring(Library.flags.SValue), tostring(Library.flags.SName))
end        
Folder:AddButton({text = "Apply changes", callback = function() Apply() Library.notify("Changes applied. If changes didn't apply the game tried to ban u", 2) end})
Library:Init()
