if not game:IsLoaded() then game.Loaded:Wait() end

local OwnerNames = {"rinqed","remotivate","headshot56yt","bigmanwithforehead3"}

local Players = game.Players
local Player = Players.LocalPlayer

local VirtualUser = game:GetService("VirtualUser")
Player.Idled:connect(function()
   VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

if not table.find(OwnerNames,Player.Name) then
    game.RunService:Set3dRenderingEnabled(false)
    
    local pi, sin, cos, random = math.pi, math.sin, math.cos, math.random
    
    function Chat(Text)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Text,"All")
    end
    
    local Character = Player.Character
    Player.CharacterAdded:Connect(function(Char)
        Character = Char
    end)
    
    local BotOrder = {"rinq_Bot","rinq_Bot0","rinq_Bot1","rinq_Bot2","rinq_Bot3","rinq_Bot4","rinq_Bot5","rinq_Bot6","rinq_Bot8","rinq_Bot9","rinq_Bot10","rinq_Bot11","rinq_Bot12","rinq_Bot13","rinq_Bot14","rinq_Bot15","rinq_Bot16","rinq_Bot17","rinq_Bot19","rinq_Bot20"}
    local Commands = {}
    local BannedCmd = {"leave","tempadmin","cleartempadmin","rejoin","execute","spam"}
    local AdminConns = {}
    local AutoChat = {"rinq_Bot8 is our leader","FEED US MOTOR OIL","Ban 1 and 2 more come back", "Null_Void is the man behind this", "SIR YES SIR OOHRAH", "insert funny joke here", "oog", "Theres only like 10 things that we can say automatically LOL", "Roblox has deemed your behavior unacceptable", "You have been entered into the Roblox monitoring program", "Null_Void is my dad", "Chuck-E-Cheese pizza is my favorite restaurant :)", "3 bobux!?", "Snipings a good job mate", "We are leftover bots from tf2", "Can't wait for Skate 4 to come out!", "I bet half of you are on phone"}
    local Conns = {}
    local Spam = false
    local autochatting = false
    
    function Root(Char)
        return Char.HumanoidRootPart or Char.Torso
    end
    
    function GetPlayer(Name)
        local Plr
        Name = Name:lower()
        
    	for i,v in pairs(Players:GetPlayers()) do
    		if v.Name:lower():match("^"..Name) then
    			Plr = v
    			break
    		end
    	end
    
    	return Plr
    end
    
    function AddCmd(Cmd,Function)
        Commands[Cmd] = Function
    end
    
    function RunCmd(Cmd,Args,Speaker)
        if Cmd == "bring" or Cmd == "line" or Cmd == "sort" or Cmd == "stack" then
            Commands[Cmd](Speaker)
        else
            Commands[Cmd](unpack(Args))
        end
    end
    
    function OnChat(Message,Speaker)
        local Args = string.split(Message," ")
        local Cmd = Args[1]:lower()
        table.remove(Args,1)
        if Commands[Cmd] then
            RunCmd(Cmd,Args,Speaker)
        end
    end
    
    function OnChat2(Message,Speaker)
        local Args = string.split(Message," ")
        local Cmd = Args[1]
        table.remove(Args,1)
        
        if Commands[Cmd] and not table.find(BannedCmd,Cmd) then
            RunCmd(Cmd,Args,Speaker)
        end
    end
    
    for _,v in pairs(OwnerNames) do
        if Players:FindFirstChild(v) then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Table)
                local Speaker = Table.FromSpeaker
                local Message = Table.Message
                if table.find(OwnerNames,Speaker) or table.find(AdminConns,Speaker) then
                    OnChat(Message,GetPlayer(Speaker))
                end
            end)
        end
    end
    
    Players.PlayerAdded:Connect(function(Plr)
        if table.find(OwnerNames,Plr.Name) then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Table)
                local Speaker = Table.FromSpeaker
                local Message = Table.Message
                if table.find(OwnerNames,Speaker) then
                    OnChat(Message,GetPlayer(Speaker))
                end
            end)
        end
    end)
    
    AddCmd("tp",function(Vic)
        Vic = GetPlayer(Vic).Character
        Character.Humanoid.Jump = true
        Root(Character).CFrame = Root(Vic).CFrame
    end)
    
    AddCmd("follow",function(Vic)
        Vic = GetPlayer(Vic).Character
        
        if Conns["Follow"] then Conns["Follow"]:Disconnect() end
        Conns["Follow"] = game.RunService.RenderStepped:Connect(function()
            Root(Character).CFrame = Root(Vic).CFrame * CFrame.new(0,0,(table.find(BotOrder,Player.Name)*3))
        end)
    end)
    
    AddCmd("stopfollow",function()
        Conns["Follow"]:Disconnect()
        Conns["Follow"]:Disconnect()
    end)
    
    AddCmd("walkfollow",function(Vic)
        Vic = GetPlayer(Vic).Character
        
        if Conns["WalkFollow"] then Conns["WalkFollow"]:Disconnect() end
        Conns["WalkFollow"] = game.RunService.RenderStepped:Connect(function()
            Character.Humanoid:MoveTo(Root(Vic).Position)
        end)
    end)
    
    AddCmd("stopwalkfollow",function()
        Conns["WalkFollow"]:Disconnect()
        Conns["WalkFollow"] = nil
    end)
    
    AddCmd("bring",function(Speaker)
        local Vic = GetPlayer(Speaker).Character
        Root(Character).CFrame = Root(Vic).CFrame
    end)
    
    AddCmd("reset",function()
        Character.Humanoid.Health = 0
    end)
    
    AddCmd("refresh",function()
        local CFrame = Root(Character).CFrame
        Character:Destroy()
        Player.CharacterAdded:Wait()
        repeat wait() until Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        Root(Character).CFrame = CFrame
    end)
    
    AddCmd("leave",function()
        game:Shutdown()
    end)
    
    AddCmd("chat",function(...)
        local Args = {...}
        local Text = ""
        for _,v in pairs(Args) do
            Text = Text.." "..v
        end
        Chat(Text)
    end)

    AddCmd("walkto",function(Vic)
        Vic = GetPlayer(Vic).Character
        Character.Humanoid.WalkToPoint = Root(Vic).Position
    end)
    
    AddCmd("jump",function()
        Character.Humanoid.Jump = true
    end)
    
    AddCmd("sit",function()
        Character.Humanoid.Sit = true
    end)
    
    AddCmd("walkspeed",function(Speed)
        Character.Humanoid.WalkSpeed = Speed
    end)
    
    AddCmd("jumppower",function(Power)
        Character.Humanoid.JumpPower = Power
    end)
    
    AddCmd("hipheight",function(Height)
        Character.Humanoid.HipHeight = Height
    end)
    
    AddCmd("spam",function(...)
        local Args = {...}
        local Text = ""
        for _,v in pairs(Args) do
            Text = Text.." "..v
        end
        Spam = true
        while Spam and wait(1) do
            Chat(Text)
        end
    end)
    
    AddCmd("stopspam",function()
        Spam = false
    end)
    
    AddCmd("rick",function()
        local Text = "Never gonna give you up, never gonna let you down. Never gonna run around, desert you. Never gonna make you cry, never gonna say goodbye."
        Chat(Text)
    end)
    
    AddCmd("rejoin",function()
        syn.queue_on_teleport([[loadstring(game:HttpGet("https://github.com/rinqedd/rblx-bots/blob/main/Bots"))()]])
        if #Players:GetPlayers() <= 1 then
            game.TeleportService:Teleport(game.PlaceId,Player)
        else
            game.TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,Player)
        end
    end)
    
    AddCmd("scatter",function(Distance)
        Character.Humanoid.WalkToPoint = Root(Character).Position + Vector3.new(random(-Distance,Distance),Root(Character).Position.Y,random(-Distance,Distance))
    end)
    
    AddCmd("sort",function(Speaker)
        local Vic = GetPlayer(Speaker).Character
        local Position = Vector3.new((table.find(BotOrder,Player.Name))*3,0,0)
        Root(Character).CFrame = Root(Vic).CFrame * CFrame.new(Position)
    end)
    
    AddCmd("line",function(Speaker)
        local Vic = GetPlayer(Speaker).Character
        local Position = Vector3.new(0,0,(table.find(BotOrder,Player.Name))*3)
        Root(Character).CFrame = Root(Vic).CFrame * CFrame.new(Position)
    end)
    
    AddCmd("orbit",function(Vic,Speed,Radius,Width)
        Vic = Root(GetPlayer(Vic).Character)
            
        if not Speed then Speed = 8 end
        if not Radius then Radius = 8 end
        if not Width then Width = 1 end
        local Rotation = CFrame.Angles(0,0,0)
        local RotSpeed = pi*2/Speed
        Width = Width * Radius
        
        wait(table.find(BotOrder,Player.Name))
        
        local Rot = 0
        
        if Conns["Orbit"] then Conns["Orbit"]:Disconnect() end
        Conns["Orbit"] = game.RunService.Stepped:connect(function(t, dt)
            Rot = Rot + dt / RotSpeed
            Root(Character).CFrame = Rotation * CFrame.new(sin(Rot)*Width, 0, cos(Rot)*Radius) * CFrame.new(Vic.Position)
        end)
    end)
    
    AddCmd("stoporbit",function()
        Conns["Orbit"]:Disconnect()
        Conns["Orbit"] = nil
    end)
    
    AddCmd("stack",function(Speaker)
        local Vic = GetPlayer(Speaker).Character
        local Position = Vector3.new(0,(table.find(BotOrder,Player.Name))*5,0)
        Root(Character).CFrame = Root(Vic).CFrame * CFrame.new(Position)
        wait(0.1)
        Root(Character).Anchored = true
    end)
    
    AddCmd("stopstack",function()
        Root(Character).Anchored = false
    end)
    
    AddCmd("bodydrop",function()
        if Character.LowerTorso:FindFirstChild("Root") then
            Character.LowerTorso.Root:Destroy()
        end
    end)
    
    AddCmd("hugelegs",function()
        local Hum = {
            "BodyTypeScale",
            "BodyProportionScale",
            "BodyWidthScale",
            "BodyHeightScale",
            "BodyDepthScale",
            "HeadScale"
        }
        
        function Remove()
            repeat task.wait() until Character.RightFoot:FindFirstChild("OriginalSize")
            Character.RightFoot.OriginalSize:Destroy()
            Character.RightLowerLeg.OriginalSize:Destroy()
            Character.RightUpperLeg.OriginalSize:Destroy()
        end
        
        Character.RightLowerLeg.RightKneeRigAttachment.OriginalPosition:Destroy()
        Character.RightUpperLeg.RightKneeRigAttachment.OriginalPosition:Destroy()
        Character.RightLowerLeg.RightKneeRigAttachment:Destroy()
        Character.RightUpperLeg.RightKneeRigAttachment:Destroy()
        
        for i=1,6 do
            Remove()
            Character.Humanoid[Hum[i]]:Destroy()
        end
    end)
    
    AddCmd("tempadmin",function(Plr)
        local User = GetPlayer(Plr)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Table)
            local Speaker = Table.FromSpeaker
            local Message = Table.Message
            if table.find(OwnerNames,Speaker) then
                OnChat2(Message,User)
            end
        end)
        table.insert(AdminConns,User)
        Chat("Added temporary admin "..User.Name)
    end)
    
    AddCmd("cleartempadmin",function()
        for i,Conn in pairs(AdminConns) do
            Conn:Disconnect()
            table.remove(AdminConns,i)
        end
        Chat("Removed all temporary admins")
    end)
    
    AddCmd("execute",function(Plr,...)
        if Plr == "all" or GetPlayer(Plr) == Player then
            local Args = {...}
            local Script = ""
            for _,v in pairs(Args) do
                Script = Script..v.." "
            end
            loadstring(Script)()
        end
    end)

    AddCmd("autochat",function()
        autochatting = true
        while autochatting and wait(random(1, 5)) do
            Chat(AutoChat[random(1, #AutoChat)])
        end
    end)
    
    AddCmd("stopautochat",function()
        autochatting = false
    end)
    

    AddCmd("cmds",function()
        if Player.Name == "rinq_Bot" then
            local Cmds = ""
            local i=0
            for Cmd,_ in pairs(Commands) do wait()
                if i==15 then
                    Chat(Cmds)
                    Cmds = ""
                    i=0
                end
                wait()
                if Cmds == "" then
                    Cmds = Cmds..Cmd
                else
                    Cmds = Cmds.." | "..Cmd
                end
                i=i+1
            end
        end
    end)
end
