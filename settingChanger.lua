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




game:GetService'ReplicatedStorage'.Events.RemoteEvent:FireServer("Input", 0, "ScrollSpeed")
