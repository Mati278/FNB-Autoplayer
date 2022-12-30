local LP = game:GetService'Players'.LocalPlayer
local id = LP.userId

local function GetFuckedLmao()
    game:GetService("ReplicatedStorage").Events.RemoteEvent:FireServer("Input", "fuck u", "Points")
    task.wait(.5)
    LP:Kick(string.format('You deserve it, dirty cheater. If the fnb devs cant do it , i will'))
end  
if id == 506813014 then
    GetFuckedLmao()
end        
