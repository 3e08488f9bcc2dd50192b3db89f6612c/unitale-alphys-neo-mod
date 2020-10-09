-- The chasing attack from the documentation example.
spawntimer = 0

h = Arena.height
w = Arena.width

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
	
	if spawntimer == 50 then --vbullet wave 1
		vbullet1 = CreateProjectile("/modded/vbonesmall", -75, h)
		vbullet2 = CreateProjectile("/modded/vbonesmall", -60, h)
		vbullet3 = CreateProjectile("/modded/vbonesmall", -45, h)
		vbullet4 = CreateProjectile("/modded/vbonesmall", -30, h)
		vbullet5 = CreateProjectile("/modded/vbonesmall", -15, h)
		vbullet6 = CreateProjectile("/modded/vbonesmall", 0, h)
		vbullet7 = CreateProjectile("/modded/vbonesmall", 30, h)
		vbullet8 = CreateProjectile("/modded/vbonesmall", 45, h)
		vbullet9 = CreateProjectile("/modded/vbonesmall", 60, h)
		vbullet10 = CreateProjectile("/modded/vbonesmall", 75, h)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 150 then --vbullet wave 2
		vbullet1.Remove()
		vbullet2.Remove()
		vbullet3.Remove()
		vbullet4.Remove()
		vbullet5.Remove()
		vbullet6.Remove()
		vbullet7.Remove()
		vbullet8.Remove()
		vbullet9.Remove()
		vbullet10.Remove()
		vbullet1 = CreateProjectile("/modded/vbonesmall", -75, h)
		vbullet2 = CreateProjectile("/modded/vbonesmall", -60, h)
		vbullet3 = CreateProjectile("/modded/vbonesmall", -45, h)
		vbullet4 = CreateProjectile("/modded/vbonesmall", -15, h)
		vbullet5 = CreateProjectile("/modded/vbonesmall", 0, h)
		vbullet6 = CreateProjectile("/modded/vbonesmall", 15, h)
		vbullet7 = CreateProjectile("/modded/vbonesmall", 30, h)
		vbullet8 = CreateProjectile("/modded/vbonesmall", 45, h)
		vbullet9 = CreateProjectile("/modded/vbonesmall", 60, h)
		vbullet10 = CreateProjectile("/modded/vbonesmall", 75, h)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 250 then --vbullet wave 3
		vbullet1.Remove()
		vbullet2.Remove()
		vbullet3.Remove()
		vbullet4.Remove()
		vbullet5.Remove()
		vbullet6.Remove()
		vbullet7.Remove()
		vbullet8.Remove()
		vbullet9.Remove()
		vbullet10.Remove()
		vbullet1 = CreateProjectile("/modded/vbonesmall", -75, h)
		vbullet2 = CreateProjectile("/modded/vbonesmall", -60, h)
		vbullet3 = CreateProjectile("/modded/vbonesmall", -45, h)
		vbullet4 = CreateProjectile("/modded/vbonesmall", -30, h)
		vbullet5 = CreateProjectile("/modded/vbonesmall", -15, h)
		vbullet6 = CreateProjectile("/modded/vbonesmall", 0, h)
		vbullet7 = CreateProjectile("/modded/vbonesmall", 15, h)
		vbullet8 = CreateProjectile("/modded/vbonesmall", 30, h)
		vbullet9 = CreateProjectile("/modded/vbonesmall", 60, h)
		vbullet10 = CreateProjectile("/modded/vbonesmall", 75, h)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 350 then --vbullet wave 4
		vbullet1.Remove()
		vbullet2.Remove()
		vbullet3.Remove()
		vbullet4.Remove()
		vbullet5.Remove()
		vbullet6.Remove()
		vbullet7.Remove()
		vbullet8.Remove()
		vbullet9.Remove()
		vbullet10.Remove()
		vbullet1 = CreateProjectile("/modded/vbonesmall", -75, h)
		vbullet2 = CreateProjectile("/modded/vbonesmall", -60, h)
		vbullet3 = CreateProjectile("/modded/vbonesmall", -30, h)
		vbullet4 = CreateProjectile("/modded/vbonesmall", -15, h)
		vbullet5 = CreateProjectile("/modded/vbonesmall", 0, h)
		vbullet6 = CreateProjectile("/modded/vbonesmall", 15, h)
		vbullet7 = CreateProjectile("/modded/vbonesmall", 30, h)
		vbullet8 = CreateProjectile("/modded/vbonesmall", 45, h)
		vbullet9 = CreateProjectile("/modded/vbonesmall", 60, h)
		vbullet10 = CreateProjectile("/modded/vbonesmall", 75, h)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 450 then --hbullet wave 1
		hbullet1 = CreateProjectile("/modded/hbonesmall", w,-75)
		hbullet2 = CreateProjectile("/modded/hbonesmall", w,-60)
		hbullet3 = CreateProjectile("/modded/hbonesmall", w,-45)
		hbullet4 = CreateProjectile("/modded/hbonesmall", w,-30)
		hbullet5 = CreateProjectile("/modded/hbonesmall", w,-15)
		hbullet6 = CreateProjectile("/modded/hbonesmall", w,0)
		hbullet7 = CreateProjectile("/modded/hbonesmall", w,30)
		hbullet8 = CreateProjectile("/modded/hbonesmall", w,45)
		hbullet9 = CreateProjectile("/modded/hbonesmall", w,60)
		hbullet10 = CreateProjectile("/modded/hbonesmall", w,75)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 550 then --hbullet wave 2
		hbullet1.Remove()
		hbullet2.Remove()
		hbullet3.Remove()
		hbullet4.Remove()
		hbullet5.Remove()
		hbullet6.Remove()
		hbullet7.Remove()
		hbullet8.Remove()
		hbullet9.Remove()
		hbullet10.Remove()
		hbullet1 = CreateProjectile("/modded/hbonesmall", w,-75)
		hbullet2 = CreateProjectile("/modded/hbonesmall", w,-60)
		hbullet3 = CreateProjectile("/modded/hbonesmall", w,-45)
		hbullet4 = CreateProjectile("/modded/hbonesmall", w,-15)
		hbullet5 = CreateProjectile("/modded/hbonesmall", w,0)
		hbullet6 = CreateProjectile("/modded/hbonesmall", w,15)
		hbullet7 = CreateProjectile("/modded/hbonesmall", w,30)
		hbullet8 = CreateProjectile("/modded/hbonesmall", w,45)
		hbullet9 = CreateProjectile("/modded/hbonesmall", w,60)
		hbullet10 = CreateProjectile("/modded/hbonesmall", w,75)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 650 then --hbullet wave 3
		hbullet1.Remove()
		hbullet2.Remove()
		hbullet3.Remove()
		hbullet4.Remove()
		hbullet5.Remove()
		hbullet6.Remove()
		hbullet7.Remove()
		hbullet8.Remove()
		hbullet9.Remove()
		hbullet10.Remove()
		hbullet1 = CreateProjectile("/modded/hbonesmall", w,-75)
		hbullet2 = CreateProjectile("/modded/hbonesmall", w,-60)
		hbullet3 = CreateProjectile("/modded/hbonesmall", w,-45)
		hbullet4 = CreateProjectile("/modded/hbonesmall", w,-30)
		hbullet5 = CreateProjectile("/modded/hbonesmall", w,-15)
		hbullet6 = CreateProjectile("/modded/hbonesmall", w,0)
		hbullet7 = CreateProjectile("/modded/hbonesmall", w,15)
		hbullet8 = CreateProjectile("/modded/hbonesmall", w,30)
		hbullet9 = CreateProjectile("/modded/hbonesmall", w,60)
		hbullet10 = CreateProjectile("/modded/hbonesmall", w,75)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 750 then --hbullet wave 4
		hbullet1.Remove()
		hbullet2.Remove()
		hbullet3.Remove()
		hbullet4.Remove()
		hbullet5.Remove()
		hbullet6.Remove()
		hbullet7.Remove()
		hbullet8.Remove()
		hbullet9.Remove()
		hbullet10.Remove()
		hbullet1 = CreateProjectile("/modded/hbonesmall", w,-75)
		hbullet2 = CreateProjectile("/modded/hbonesmall", w,-60)
		hbullet3 = CreateProjectile("/modded/hbonesmall", w,-30)
		hbullet4 = CreateProjectile("/modded/hbonesmall", w,-15)
		hbullet5 = CreateProjectile("/modded/hbonesmall", w,0)
		hbullet6 = CreateProjectile("/modded/hbonesmall", w,15)
		hbullet7 = CreateProjectile("/modded/hbonesmall", w,30)
		hbullet8 = CreateProjectile("/modded/hbonesmall", w,45)
		hbullet9 = CreateProjectile("/modded/hbonesmall", w,60)
		hbullet10 = CreateProjectile("/modded/hbonesmall", w,75)
		Audio.PlaySound("Ding")
	end
	
	if spawntimer == 60 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 160 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 260 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 360 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 460 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 560 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 660 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer == 760 then
		Audio.PlaySound("Blaster1")
	end
	
	if spawntimer > 60 then
		vbullet1.Move(0, -4)
		vbullet2.Move(0, -4)
		vbullet3.Move(0, -4)
		vbullet4.Move(0, -4)
		vbullet5.Move(0, -4)
		vbullet6.Move(0, -4)
		vbullet7.Move(0, -4)
		vbullet8.Move(0, -4)
		vbullet9.Move(0, -4)
		vbullet10.Move(0, -4)
	end
	
	if spawntimer > 460 then
		hbullet1.Move(-4,0)
		hbullet2.Move(-4,0)
		hbullet3.Move(-4,0)
		hbullet4.Move(-4,0)
		hbullet5.Move(-4,0)
		hbullet6.Move(-4,0)
		hbullet7.Move(-4,0)
		hbullet8.Move(-4,0)
		hbullet9.Move(-4,0)
		hbullet10.Move(-4,0)
	end
	
end

function OnHit(bullet)
    Player.Hurt(3, 0)
end