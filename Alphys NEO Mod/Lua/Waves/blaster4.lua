Knifecount = 0
slices = {}
Knifes = {}
Arena.Resize(120,Arena.height)
spawntimer = 0
istop = false
istop2 = true
Svar1 = nil
Svar2 = nil
Moving = false
Svar3 = nil
Timer = nil
SetGlobal("ArenaMove", 1)

function SpawnKnife(Rotation,Position,Speed1,Speed2)
		local startposx = math.random(-400,400)
        local startposy = 400
        local Knife = CreateProjectile('Knife'..Rotation, startposx,startposy)
		Knife.SetVar('Position', Position)
		Knife.SetVar('Rotation', Rotation)
		Knife.SetVar('XVelo', Speed1)
		Knife.SetVar('IsBullet', true)
		Knife.SetVar('YVelo', Speed2)
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "False")
		Knife.SetVar('Frame', 0)
		Knife.SetVar('Startx', startposx)
		Knife.SetVar('Starty', startposy)
		Knife.SetVar('Played1', 0)
		Knife.SetVar('Played2', 0)
		Knife.sprite.alpha = 0
		Knife.sprite.rotation = math.random(0,360)
        table.insert(Knifes, Knife)
end

function Update()
spawntimer = spawntimer + 1
if spawntimer%60 == 0 then
SpawnKnife("Right", "Player", 14, 0)
elseif spawntimer%90 == 0 then
SpawnKnife("Left", "Player", -14, 0)
end

if spawntimer%180 == 0 then
SpawnKnife("Up", "Player", 0, 14)
SpawnKnife("Down", "Player", 0, -14)
end

	if #Knifes > 0 then
    for i=1,#Knifes do
        local Knife = Knifes[i]
		if Knife.isactive then
		local SoundPlayed = false
		local SoundPlayed2 = false
		local Played1 = Knife.GetVar('Played1')
		local Played2 = Knife.GetVar('Played2')
		local Position = Knife.GetVar('Position')
		local SpeedX = Knife.GetVar('XVelo')
		local SpeedY = Knife.GetVar('YVelo')
		local Rotation = Knife.GetVar('Rotation')
		local InPosition = Knife.GetVar('InPosition')
		local Frame = Knife.GetVar('Frame')
		local startx = Knife.GetVar('Startx')
		local starty = Knife.GetVar('Starty')
		local IsFiring = Knife.GetVar('IsFiring')
		if InPosition == "False" and IsFiring == "False" then
		if Played1 == 0 then
		Knife.SetVar('Played1', 1)
		end
		if Rotation == "Down" then
		local Goalx = nil
		if Position == "Player" then
		Goalx = Player.x
		else
		Goalx = - Arena.width/2 + Position
		end
		local Goaly = Arena.height/2 + Knife.sprite.height/2 + Knife.sprite.height/4
		local currentx = Knife.x
		local currenty = Knife.y
		local RotGoal = 0
		local currentrot = Knife.sprite.rotation
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/10
		local newposy = movevary/10
		local rot = RotGoal - currentrot
		local newrot = Knife.sprite.rotation + rot/10
		Knife.sprite.rotation = newrot
		Knife.sprite.alpha = Knife.sprite.alpha + 1/30
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 40 then
		Knife.SetVar('Frame', 0)
		Knife.SetVar('InPosition', "True")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Up" then
		local Goalx = nil
		if Position == "Player" then
		Goalx = Player.x
		else
		Goalx = - Arena.width/2 + Position
		end
		local Goaly = - Arena.height/2 - Knife.sprite.height/2 - Knife.sprite.height/4
		local RotGoal = 0
		local currentx = Knife.x
		local currenty = Knife.y
		local currentrot = Knife.sprite.rotation
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local rot = RotGoal - currentrot
		local newposx = movevarx/10
		local newposy = movevary/10
		local newrot = Knife.sprite.rotation + rot/10
		Knife.sprite.rotation = newrot
		Knife.sprite.alpha = Knife.sprite.alpha + 1/30
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 40 then
		Knife.SetVar('InPosition', "True")
		Knife.SetVar('IsFiring', "True")
		Knife.SetVar('Frame', 0)
		end
		elseif Rotation == "Right" then
		local Goalx = - Arena.width/2 - Knife.sprite.width/2 - Knife.sprite.width/4
		local Goaly = nil
		if Position == "Player" then
		Goaly = Player.y
		else
		Goaly = -Arena.height/2 + Position
		end
		local RotGoal = 0
		local currentx = Knife.x
		local currenty = Knife.y
		local currentrot = Knife.sprite.rotation
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local rot = RotGoal - currentrot
		local newposx = movevarx/10
		Knife.sprite.alpha = Knife.sprite.alpha + 1/30
		local newposy = movevary/10
		local newrot = Knife.sprite.rotation + rot/10
		Knife.sprite.rotation = newrot
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 40 then
		Knife.SetVar('InPosition', "True")
		Knife.SetVar('IsFiring', "True")
		Knife.SetVar('Frame', 0)
		end
		elseif Rotation == "Left" then
		local Goalx = Arena.width/2 + Knife.sprite.width/2 + Knife.sprite.width/4
		local Goaly = nil
		if Position == "Player" then
		Goaly = Player.y
		else
		Goaly = -Arena.height/2 + Position
		end
		local RotGoal = 0
		local currentx = Knife.x
		local currenty = Knife.y
		local currentrot = Knife.sprite.rotation
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local rot = RotGoal - currentrot
		local newposx = movevarx/10
		Knife.sprite.alpha = Knife.sprite.alpha + 1/30
		local newposy = movevary/10
		local newrot = Knife.sprite.rotation + rot/10
		Knife.sprite.rotation = newrot
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 40 then
		Knife.SetVar('Frame', 0)
		Knife.SetVar('InPosition', "True")
		Knife.SetVar('IsFiring', "True")
		end
		end
		end
		
		if InPosition == "True" and IsFiring == "True" then
		if Rotation == "Down" then
		local Goalx = Knife.x
		local Goaly = Knife.y + 20
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Up" then
		local Goalx = Knife.x
		local Goaly = Knife.y - 20
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Right" then
		local Goalx = Knife.x - 20
		local Goaly = Knife.y
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		elseif Rotation == "Left" then
		local Goalx = Knife.x + 20
		local Goaly = Knife.y
		local currentx = Knife.x
		local currenty = Knife.y
		local movevarx = Goalx - currentx
		local movevary = Goaly - currenty
		local newposx = movevarx/5
		local newposy = movevary/5
		Knife.SetVar('Frame', Frame + 1)
		Knife.Move(newposx,newposy)
		if Frame == 8 then
		Knife.SetVar('InPosition', "False")
		Knife.SetVar('IsFiring', "True")
		end
		end
		end
		
		if InPosition == "False" and IsFiring == "True" then
		if Rotation == "Down" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.y - Knife.sprite.height/2 <= -Arena.height/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('IsBullet', false)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
		else
		Knife:Remove()
		end
		end
		elseif Rotation == "Up" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.y + Knife.sprite.height/2 >= Arena.height/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('IsBullet', false)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
		else
		Knife:Remove()
		end
		end
		elseif Rotation == "Right" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.x + Knife.sprite.height/2 >= Arena.width/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('IsBullet', false)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
		else
		Knife:Remove()
		end
		end
		elseif Rotation == "Left" then
		Knife.Move(SpeedX,SpeedY)
		if Knife.x - Knife.sprite.height/2 <= -Arena.width/2 then
		Knife.SetVar('XVelo', 0)
		Knife.SetVar('IsBullet', false)
		Knife.SetVar('YVelo', 0)
		if Knife.sprite.alpha > 0 then
		Knife.sprite.alpha = Knife.sprite.alpha - 0.075
		else
		Knife:Remove()
		end
		end
		end
		end
		
		end
		end
		end
	
	if #slices > 0 then
	for i=1,#slices do
	local blast = slices[i]
	if blast.isactive then
	local Rotation = blast.GetVar('Rotation')
	local startx = blast.GetVar('IntX')
	local starty = blast.GetVar('IntY')
	local InPositionBlast = blast.GetVar('InPosition')
	local Frame = blast.GetVar('Frame')
	local Knifew = blast.GetVar('KnifeWidth')
	local Knifeh = blast.GetVar('KnifeHeight')
	if InPositionBlast == "True" then
	if blast.sprite.alpha > 0 then
	blast.sprite.alpha = blast.sprite.alpha - 0.07
	else
	blast:Remove()
	end
	else
	blast.sprite.alpha = 1
	if Rotation == "Down" then
	blast.Move(0,-blast.sprite.height/2 - Knifeh/4)
	elseif Rotation == "Up" then
	blast.Move(0, blast.sprite.height/2 + Knifeh/4)
	elseif Rotation == "Left" then
	blast.Move(-blast.sprite.width/2 - Knifew/4, 0)
	elseif Rotation == "Right" then
	blast.Move(blast.sprite.width/2 + Knifew/4, 0)
	end
	blast.SetVar('InPosition', "True")
	end
	end
	end
	end
	
	if GetGlobal("Soul") == 1 then
	local newplayerposx = Player.x - 0
	local newplayerposy = Player.y - 0
	
	if Input.Left > 0 then
	newplayerposx = Player.x - 2.5
	Moving = true
	elseif Input.Right > 0 then
	newplayerposx = Player.x + 2.5
	Moving = true
	else
	Moving = false
	end
	
	if Input.Up == 1 then
	if Svar1 == false then
	Svar1 = true
	if Svar2 == false then
	Player.sprite.rotation = 180
	Svar2 = true
	else
	Player.sprite.rotation = 0
	Svar2 = false
	end
	end
	end
	
	if Player.y == - Arena.height/2 + 8 and Svar1 == true and Svar2 == false then
	Svar1 = false
	end
	
	if Player.y == Arena.height/2 - 8 and Svar1 == true and Svar2 == true then
	Svar1 = false
	end
	
	if not Svar2 then
	newplayerposy = newplayerposy - 4
	else
	newplayerposy = newplayerposy + 4
	end
	
	Player.MoveTo(newplayerposx, newplayerposy, false)
	elseif GetGlobal("Soul") == 2 then
	local newplayerposx = Player.x - 0
	local newplayerposy = Player.y + Svar1
	
	if Input.Up == 1 then
	if Svar3 == false and Svar2 == false then
	Svar2 = true
	Svar3 = true
	end
	end
	
	if Svar2 == true and Timer + 1 <= 8 then
	Timer = Timer + 1
	elseif Timer + 1 > 8 then
	Timer = 0
	Svar2 = false
	end
	
	if Input.Left > 0 then
	newplayerposx = Player.x - 2.5
	Moving = true
	elseif Input.Right > 0 then
	newplayerposx = Player.x + 2.5
	Moving = true
	else
	Moving = false
	end
	
	if Player.y == - Arena.height/2 + 8 and Svar2 == false then
	Svar3 = false
	Svar1 = 0
	end
	
	if Svar2 then
	Svar1 = Svar1 + 0.8
	end
	
	Svar1 = Svar1 - 0.25
	Player.MoveTo(newplayerposx, newplayerposy, false)
	end
	end
	
function OnHit(blast)
    local damage = 1
	local timer = 0.00001
	if blast.GetVar('IsBullet') == true then
        Player.Hurt(damage,timer)
		end
end