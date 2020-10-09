state = 1 -- State of player, 0 = Red, | 1 = Down, | 2 = Left, | 3 = Up, | 4 = Right
maxjump = 40 -- How high the player can jump.
jump = 0 -- Current jumping velocity. Can be set to any number within reason.
hurt = 1 -- If set to any number other than 0, then the player is invulnurable for 1 frame.
newpX = Player.x
newpY = Player.y

onPlatform = 0
platforms = {}

platSpawn = 50

mask = CreateProjectile("./modded/Red", newpX, newpY)
mask.setVar("canHit", false) -- Whenever you create a projectile, set this variable for said projectile.

speed = 3
moveDirection = 1
bullets = {}
warningSymbols = {}
fireRate = 60 -- Note: Be sure to set this to an even number
bulletSpeed = 7
require "Libraries/blaster"
flipFlop = false

blue = true

spawntimer = 0

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

tbone1 = CreateProjectile("./modded/vbonetiny", 100, -60)
sbone1 = CreateProjectile("./modded/vbonesmall", 130, -53)
mbone1 = CreateProjectile("./modded/vbonemedium", 160, -46)
sbone2 = CreateProjectile("./modded/vbonesmall", 190, -53)
tbone2 = CreateProjectile("./modded/vbonetiny", 220, -60)

tbone1.setVar("canHit", true)
sbone1.setVar("canHit", true)
tbone2.setVar("canHit", true)
sbone2.setVar("canHit", true)
mbone1.setVar("canHit", true)
Audio.PlaySound("Ding")

moved = false

bullet = false
bullet1 = false
bullet2 = false
bullet3 = false
bullet4 = false
bullet5 = false
bullet6 = false
bullet7 = false
bullet8 = false
bullet9 = false
bullet10 = false

function Update()

	spawntimer = spawntimer + 1
	
	if spawntimer > 15 and spawntimer < 90 then
		tbone1.move(-5, 0)
		sbone1.move(-5, 0)
		tbone2.move(-5, 0)
		sbone2.move(-5, 0)
		mbone1.move(-5, 0)
		if moved == false then
			moved = true
			Audio.PlaySound("Blaster1")
		end
	end
	
	if spawntimer > 100 and spawntimer < 140 then
		vbone1.move(0, -5)
		vbone2.move(0, -5)
		vbone3.move(0, -5)
		vbone4.move(0, -5)
		vbone5.move(0, -5)
		vbone6.move(0, -5)
		if bullet == false then
			bullet = true
			Audio.PlaySound("Blaster1")
		end
	end
	
	if spawntimer > 150 and spawntimer < 190 then
		vbone1.move(0, -5)
		vbone2.move(0, -5)
		vbone3.move(0, -5)
		vbone4.move(0, -5)
		vbone5.move(0, -5)
		vbone6.move(0, -5)
		if bullet == false then
			bullet = true
			Audio.PlaySound("Blaster1")
		end
	end
	
	if spawntimer == 90 then
		Audio.PlaySound("Ding")
		tbone1.Remove()
		sbone1.Remove()
		tbone2.Remove()
		sbone2.Remove()
		mbone1.Remove()
		state = 2
		jump = -75
		RenewMask()
		vbone1 = CreateProjectile("./modded/vbonesmall", -70, Arena.height)
		vbone2 = CreateProjectile("./modded/vbonesmall", -60, Arena.height)
		vbone3 = CreateProjectile("./modded/vbonesmall", -50, Arena.height)
		vbone4 = CreateProjectile("./modded/vbonesmall", -40, Arena.height)
		vbone5 = CreateProjectile("./modded/vbonesmall", -30, Arena.height)
		vbone6 = CreateProjectile("./modded/vbonesmall", -20, Arena.height)
		vbone1.setVar("canHit", true)
		vbone2.setVar("canHit", true)
		vbone3.setVar("canHit", true)
		vbone4.setVar("canHit", true)
		vbone5.setVar("canHit", true)
		vbone6.setVar("canHit", true)
	end
	
	if spawntimer == 140 then
		Audio.PlaySound("Ding")
		bullet = false
		state = 4
		jump = -75
		RenewMask()
		vbone1.Remove()
		vbone2.Remove()
		vbone3.Remove()
		vbone4.Remove()
		vbone5.Remove()
		vbone6.Remove()
		vbone1 = CreateProjectile("./modded/vbonesmall", 70, Arena.height)
		vbone2 = CreateProjectile("./modded/vbonesmall", 60, Arena.height)
		vbone3 = CreateProjectile("./modded/vbonesmall", 50, Arena.height)
		vbone4 = CreateProjectile("./modded/vbonesmall", 40, Arena.height)
		vbone5 = CreateProjectile("./modded/vbonesmall", 30, Arena.height)
		vbone6 = CreateProjectile("./modded/vbonesmall", 20, Arena.height)
		vbone1.setVar("canHit", true)
		vbone2.setVar("canHit", true)
		vbone3.setVar("canHit", true)
		vbone4.setVar("canHit", true)
		vbone5.setVar("canHit", true)
		vbone6.setVar("canHit", true)
	end
	
	if spawntimer == 190 then
		Audio.PlaySound("Ding")
		state = 0
		jump = -75
		mask.Remove()
		blue = false
		vbone1.Remove()
		vbone2.Remove()
		vbone3.Remove()
		vbone4.Remove()
		vbone5.Remove()
		vbone6.Remove()
	end
	
	if spawntimer == 200 then
		bone1 = CreateProjectile("./modded/hbonemedium", Arena.width, -60)
		bone1.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 205 then
		bone6 = CreateProjectile("./modded/hbonemedium", Arena.width * (-1), -75)
		bone6.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 210 then
		bone2 = CreateProjectile("./modded/hbonemedium", Arena.width, -30)
		bone2.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 215 then
		bone7 = CreateProjectile("./modded/hbonemedium", Arena.width * (-1), -45)
		bone7.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 220 then
		bone3 = CreateProjectile("./modded/hbonemedium", Arena.width, 0)
		bone3.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 225 then
		bone8 = CreateProjectile("./modded/hbonemedium", Arena.width * (-1), -15)
		bone8.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 230 then
		bone4 = CreateProjectile("./modded/hbonemedium", Arena.width, 30)
		bone4.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 235 then
		bone9 = CreateProjectile("./modded/hbonemedium", Arena.width * (-1), 15)
		bone9.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 240 then
		bone5 = CreateProjectile("./modded/hbonemedium", Arena.width, 60)
		bone5.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 245 then
		bone10 = CreateProjectile("./modded/hbonemedium", Arena.width * (-1), 45)
		bone10.setVar("canHit", true)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer > 250 then
		bone1.move(-5,0)
		if bullet1 == false then
			bullet1 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 255 then
		bone6.move(5,0)
		if bullet6 == false then
			bullet6 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 260 then
		bone2.move(-5,0)
		if bullet2 == false then
			bullet2 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 265 then
		bone7.move(5,0)
		if bullet7 == false then
			bullet7 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 270 then
		bone3.move(-5,0)
		if bullet3 == false then
			bullet3 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 275 then
		bone8.move(5,0)
		if bullet8 == false then
			bullet8 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 280 then
		bone4.move(-5,0)
		if bullet4 == false then
			bullet4 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 285 then
		bone9.move(5,0)
		if bullet9 == false then
			bullet9 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 290 then
		bone5.move(-5,0)
		if bullet5 == false then
			bullet5 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 295 then
		bone10.move(5,0)
		if bullet10 == false then
			bullet10 = true
			Audio.PlaySound("Blaster1")
		end
	end

if blue == true then
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
end
end


function OnHit(bullet)
	if not bullet.getVar("canHit") == false then
		if hurt == 0 then
			Player.Hurt(3,0)
		end
	end
end