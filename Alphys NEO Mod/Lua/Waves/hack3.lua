state = 1 -- State of player, 0 = Red, | 1 = Down, | 2 = Left, | 3 = Up, | 4 = Right
maxjump = 40 -- How high the player can jump.
jump = 0 -- Current jumping velocity. Can be set to any number within reason.
hurt = 1 -- If set to any number other than 0, then the player is invulnurable for 1 frame.
newpX = Player.x
newpY = Player.y

onPlatform = 0
platforms = {}

platSpawn = 50

mask = CreateProjectile("Red", newpX, newpY)
mask.setVar("canHit", false) -- Whenever you create a projectile, set this variable for said projectile.

function RenewMask()
	if state == 0 or state == 5 then
		hurt = 1
		mask.Remove()
		mask = CreateProjectile("./modded/Red", newpX, newpY)
		mask.setVar("canHit", false)
	elseif state == 1 then
		hurt = 1
		mask.Remove()
		mask = CreateProjectile("./modded/blue1", newpX, newpY)
		mask.setVar("canHit", false)
	elseif state == 2 then
		hurt = 1
		mask.Remove()
		mask = CreateProjectile("./modded/blue2", newpX, newpY)
		mask.setVar("canHit", false)
	elseif state == 3 then
		hurt = 1
		mask.Remove()
		mask = CreateProjectile("./modded/blue3", newpX, newpY)
		mask.setVar("canHit", false)
	elseif state == 4 then
		hurt = 1
		mask.Remove()
		mask = CreateProjectile("./modded/blue4", newpX, newpY)
		mask.setVar("canHit", false)
	end
end

RenewMask()

topedge = Arena.height/2 - 8
rightedge = Arena.width/2 - 8
bottomedge = -Arena.height/2 + 8
leftedge = -Arena.width/2 + 8

boneline = CreateProjectile("./modded/vboneline", 600, -49)
boneline.setVar("canHit", true)

function Update()
	
	boneline.move(-1, 0)

    onPlatform = onPlatform - 1
    if Input.Confirm == 1 then
	state = state + 1
	if state == 5 then
		state = 0
	end
	RenewMask()
    end
    if Input.Cancel == 1 then
	if state == 0 then
		state = 5
	end
	state = state - 1
	RenewMask()
    end
    if Input.Menu == 1 then
	jump = - 75
    end
	hurt = 0
    if state == 0 then
	newpX = newpX
	newpY = newpY
	if Input.Right > 0 then
	    newpX = Player.x + 0.4
	end
	if Input.Left > 0 then
            newpX = Player.x - 0.4
	end
	if Input.Up > 0 then
	    newpY = Player.y + 0.4
	end
	if Input.Down > 0 then
            newpY = Player.y - 0.4
	end
	Player.MoveTo(newpX, newpY, false)
	mask.MoveTo(Player.x, Player.y)
    end
    if state == 1 then -- Down
	newpX = newpX
	newpY = newpY
	if Input.Right > 0 then
	    newpX = Player.x + 0.5
	end
	if Input.Left > 0 then
            newpX = Player.x - 0.5
	end
	if onPlatform >= 1 then
	    newpX = newpX + platXV
	    newpY = newpY + platYV
	    if Input.Up > 0 then
	    	jump = maxjump
	    end
	end
	if newpY > topedge then
		if jump > 0 then
			jump = 0
		end
	end
	if Player.y < bottomedge + 2 then
		if jump < -50 then
			Audio.PlaySound("slam")
		end
	    if Input.Up > 0 then
	    	jump = maxjump
	    else
		newpY = bottomedge
		jump = 0
	    end
	elseif jump < 3 and jump > -3 then
	    jump = jump - 0.5
	elseif jump < -3 and jump > -10 then
	    jump = -10
	elseif jump < -3 then
	    jump = jump - 1.5
	else
	    jump = (jump/1.001) - 1
	end
	if Input.Up < 0 and jump > 3 then
	    jump = 2
	end
	newpY = newpY + (jump/10)
	Player.MoveTo(newpX, newpY, false)
	mask.MoveTo(Player.x, Player.y)
    end
    if state == 2 then -- Left
	newpX = newpX
	newpY = newpY
	if Input.Up > 0 then
	    newpY = Player.y + 0.5
	end
	if Input.Down > 0 then
            newpY = Player.y - 0.5
	end
	if onPlatform >= 1 then
	    newpX = newpX + platXV
	    newpY = newpY + platYV
	    if Input.Right > 0 then
	    	jump = maxjump
	    end
	end
	if newpX > rightedge then
		if jump > 0 then
			jump = 0
		end
	end
	if Player.x < leftedge + 2 then
		if jump < -50 then
			Audio.PlaySound("slam")
		end
	    if Input.Right > 0 then
	    	jump = maxjump
	    else
		newpX = leftedge
		jump = 0
	    end
	elseif jump < 3 and jump > -3 then
	    jump = jump - 0.5
	elseif jump < -3 and jump > -10 then
	    jump = -10
	elseif jump < -3 then
	    jump = jump - 1.5
	else
	    jump = (jump/1.001) - 1
	end
	if Input.Right < 0 and jump > 3 then
	    jump = 2
	end
	newpX = newpX + (jump/10)
	Player.MoveTo(newpX, newpY, false)
	mask.MoveTo(Player.x, Player.y)
    end
    if state == 3 then -- Up
	newpX = newpX
	newpY = newpY
	if Input.Right > 0 then
	    newpX = Player.x + 0.5
	end
	if Input.Left > 0 then
            newpX = Player.x - 0.5
	end
	if onPlatform >= 1 then
	    newpX = newpX + platXV
	    newpY = newpY + platYV
	    if Input.Down > 0 then
	    	jump = maxjump
	    end
	end
	if newpY < bottomedge then
		if jump > 0 then
			jump = 0
		end
	end
	if Player.y > topedge - 2 then
		if jump < -50 then
			Audio.PlaySound("slam")
		end
	    if Input.Down > 0 then
	    	jump = maxjump
	    else
		newpY = topedge
		jump = 0
	    end
	elseif jump < 3 and jump > -3 then
	    jump = jump - 0.5
	elseif jump < -3 and jump > -10 then
	    jump = -10
	elseif jump < -3 then
	    jump = jump - 1.5
	else
	    jump = (jump/1.001) - 1
	end
	if Input.Down < 0 and jump > 3 then
	    jump = 2
	end
	newpY = newpY - (jump/10)
	Player.MoveTo(newpX, newpY, false)
	mask.MoveTo(Player.x, Player.y)
    end
    if state == 4 then -- Right
	newpX = newpX
	newpY = newpY
	if Input.Up > 0 then
	    newpY = Player.y + 0.5
	end
	if Input.Down > 0 then
            newpY = Player.y - 0.5
	end
	if onPlatform >= 1 then
	    newpX = newpX + platXV
	    newpY = newpY + platYV
	    if Input.Left > 0 then
	    	jump = maxjump
	    end
	end
	if newpX < leftedge then
		if jump > 0 then
			jump = 0
		end
	end
	if Player.x > rightedge - 2 then
		if jump < -50 then
			Audio.PlaySound("slam")
		end
	    if Input.Left > 0 then
	    	jump = maxjump
	    else
		newpX = rightedge
		jump = 0
	    end
	elseif jump < 3 and jump > -3 then
	    jump = jump - 0.5
	elseif jump < -3 and jump > -10 then
	    jump = -10
	elseif jump < -3 then
	    jump = jump - 1.5
	else
	    jump = (jump/1.001) - 1
	end
	if Input.Left < 0 and jump > 3 then
	    jump = 2
	end
	newpX = newpX - (jump/10)
	Player.MoveTo(newpX, newpY, false)
	mask.MoveTo(Player.x, Player.y)
    end

    if platSpawn < 100 then
	platSpawn = platSpawn + 1
    else
	platSpawn = 0
    if state == 1 then

        local posx = (Arena.width/2) + 50
        local posy = (-Arena.height/2) + 50
	plat = CreateProjectile("./modded/1platformS", posx, posy)
	Audio.PlaySound("Ding")
        plat.SetVar('velx', -2.8) -- The platforms X velocity, required
        plat.SetVar('vely', 0) -- The platforms Y velocity, required
	plat.setVar("canHit", false)
	plat.setVar("canStand", 1) -- This number is equal to the state you can stand on it, required
        table.insert(platforms, plat) -- required

    elseif state == 2 then

        local posx = (-Arena.width/2) + 50
        local posy = (Arena.height/2) + 50
	plat = CreateProjectile("./modded/2platformS", posx, posy)
        plat.SetVar('velx', 0) -- The platforms X velocity
        plat.SetVar('vely', -1.25) -- The platforms Y velocity
	plat.setVar("canHit", false)
	plat.setVar("canStand", 2) -- This number is equal to the state you can stand on it.
        table.insert(platforms, plat)

    elseif state == 3 then

        local posx = (-Arena.width/2) - 50
        local posy = (Arena.height/2) - 50
	plat = CreateProjectile("./modded/3platformS", posx, posy)
        plat.SetVar('velx', 1.25) -- The platforms X velocity
        plat.SetVar('vely', 0) -- The platforms Y velocity
	plat.setVar("canHit", false)
	plat.setVar("canStand", 3) -- This number is equal to the state you can stand on it.
        table.insert(platforms, plat)

    elseif state == 4 then

        local posx = (Arena.width/2) - 50
        local posy = (-Arena.height/2) - 50
	plat = CreateProjectile("./modded/4platformS", posx, posy)
        plat.SetVar('velx', 0) -- The platforms X velocity
        plat.SetVar('vely', 1.25) -- The platforms Y velocity
	plat.setVar("canHit", false)
	plat.setVar("canStand", 4) -- This number is equal to the state you can stand on it.
        table.insert(platforms, plat)

    end
    end

    for i=1,#platforms do
        local plat = platforms[i]
        local velx = plat.GetVar('velx')
        local vely = plat.GetVar('vely')
        local newposx = plat.x + velx
        local newposy = plat.y + vely
        plat.MoveTo(newposx, newposy)
    end
end


function OnHit(bullet)
	if not bullet.getVar("canHit") == false then
		if hurt == 0 then
			Player.Hurt(3,0)
		end
	end
	if bullet.getVar("canStand") == state then
		if jump < 0.1 and state == 1 then
			if Player.y >= bullet.y + 4 and Player.y <= bullet.y + 12 then -- You might want to adjust this if you have issues with custom platform sprites.
				if jump < -50 then
					Audio.PlaySound("slam")
				end
				if Input.Up > 0 then
	    				jump = maxjump
				else
					newpY = bullet.y + 8
		        		platXV = bullet.getVar("velx")
		        		platYV = bullet.getVar("vely")
		        		jump = 0
		        		onPlatform = 2
				end
			end
		end
		if jump < 0.1 and state == 2 then
			if Player.x >= bullet.x + 4 and Player.x <= bullet.x + 12 then -- and this one
				if jump < -50 then
					Audio.PlaySound("slam")
				end
				if Input.Right > 0 then
	    				jump = maxjump
				else
					newpX = bullet.x + 8
		        		platXV = bullet.getVar("velx")
		        		platYV = bullet.getVar("vely")
		        		jump = 0
		        		onPlatform = 2
				end
			end
		end
		if jump < 0.1 and state == 3 then
			if Player.y <= bullet.y - 4 and Player.y >= bullet.y - 12 then -- and this one too.
				if jump < -50 then
					Audio.PlaySound("slam")
				end
				if Input.Down > 0 then
	    				jump = maxjump
				else
					newpY = bullet.y - 8
		        		platXV = bullet.getVar("velx")
		        		platYV = bullet.getVar("vely")
		        		jump = 0
		        		onPlatform = 2
				end
			end
		end
		if jump < 0.1 and state == 4 then
			if Player.x <= bullet.x - 4 and Player.x >= bullet.x - 12 then -- and this...
				if jump < -50 then
					Audio.PlaySound("slam")
				end
				if Input.Left > 0 then
	    				jump = maxjump
				else
					newpX = bullet.x - 8
		        		platXV = bullet.getVar("velx")
		        		platYV = bullet.getVar("vely")
		        		jump = 0
		        		onPlatform = 2
				end
			end
		end
	end
end