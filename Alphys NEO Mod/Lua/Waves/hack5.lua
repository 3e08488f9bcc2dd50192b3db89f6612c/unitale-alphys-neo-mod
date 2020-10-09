speed = 3
moveDirection = 1
bullets = {}
warningSymbols = {}
fireRate = 60 -- Note: Be sure to set this to an even number
bulletSpeed = 7
spawntimer = 0
require "Libraries/blaster"
flipFlop = false

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
	
	if spawntimer > 60 then
		if spawntimer < 70 then
			CreateBlasters(2, "gasterBlaster")
		end
	end
		
	if spawntimer == 100 then
		FireBlasters(2, "blast", "blastY", {"gasterBlasterFire1", "gasterBlasterFire2", "gasterBlasterFire3"}, 0.1, {"blast2", "blast3"}, 0.05, {"blastY1", "blastY2", "blastY3"}, 0.07)
	end
	
	if spawntimer == 110 then
		bone1 = CreateProjectile("/modded/hbonemedium", Arena.width, -60)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 115 then
		bone6 = CreateProjectile("/modded/hbonemedium", Arena.width * (-1), -75)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 120 then
		bone2 = CreateProjectile("/modded/hbonemedium", Arena.width, -30)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 125 then
		bone7 = CreateProjectile("/modded/hbonemedium", Arena.width * (-1), -45)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 130 then
		bone3 = CreateProjectile("/modded/hbonemedium", Arena.width, 0)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 135 then
		bone8 = CreateProjectile("/modded/hbonemedium", Arena.width * (-1), -15)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 140 then
		bone4 = CreateProjectile("/modded/hbonemedium", Arena.width, 30)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 145 then
		bone9 = CreateProjectile("/modded/hbonemedium", Arena.width * (-1), 15)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 150 then
		bone5 = CreateProjectile("/modded/hbonemedium", Arena.width, 60)
		Audio.PlaySound("Ding")
	end
	if spawntimer == 155 then
		bone10 = CreateProjectile("/modded/hbonemedium", Arena.width * (-1), 45)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer > 160 then
		bone1.move(-5,0)
		if bullet1 == false then
			bullet1 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 165 then
		bone6.move(5,0)
		if bullet6 == false then
			bullet6 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 170 then
		bone2.move(-5,0)
		if bullet2 == false then
			bullet2 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 175 then
		bone7.move(5,0)
		if bullet7 == false then
			bullet7 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 180 then
		bone3.move(-5,0)
		if bullet3 == false then
			bullet3 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 185 then
		bone8.move(5,0)
		if bullet8 == false then
			bullet8 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 190 then
		bone4.move(-5,0)
		if bullet4 == false then
			bullet4 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 195 then
		bone9.move(5,0)
		if bullet9 == false then
			bullet9 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 200 then
		bone5.move(-5,0)
		if bullet5 == false then
			bullet5 = true
			Audio.PlaySound("Blaster1")
		end
	end
	if spawntimer > 205 then
		bone10.move(5,0)
		if bullet10 == false then
			bullet10 = true
			Audio.PlaySound("Blaster1")
		end
	end
end

function OnHit(bullet)
	Player.Hurt(3,0)
end