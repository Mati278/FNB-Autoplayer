--me when no moonsec v2
local uwuware = loadstring(game:HttpGet'https://raw.githubusercontent.com/stavratum/lua/main/fnb/uwuware.lua')()
local Connected = {}
local Window = uwuware:CreateWindow"Yet Another Funkin Night"

--loadstring(game:HttpGet'https://raw.githubusercontent.com/Mati278/what-im-doin-with-my-life/main/whitelist.lua')()

Window:AddLabel({text = "sorry for text being big"})
Window:AddLabel({text = "also made it a gui lol"})
Window:AddButton{text="Start",callback=function()
    local r = getsenv(game.Players.LocalPlayer.PlayerGui.GameUI.GameHandler)
    local oops = r.GoodHit
    local cond = require(game.ReplicatedStorage.Modules.Conductor)

    local bad = function(o)
        o.StrumTime = cond.AdjustedSongPos
        oops(o)
    end
    r.MissNote = bad
    r.GoodHit = bad
    local p
    p = hookmetamethod(Instance.new'BindableEvent',"__namecall",function(i,v,...)
    if v == "Death" then
    return
    end
    return p(i,v,...)
    end)
for _,Function in pairs(Connected) do
        Function:Disconnect()
    end
    uwuware.base:Destroy()
    script:Destroy()
end}
uwuware:Init()
uwuware.cursor.Visible = false


game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "done bro";
    Text = "the script load";
    Icon = "rbxthumb://type=Asset&id=8370951801&w=420&h=420"})
