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
