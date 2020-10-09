-- Based/shamelessly stolen on/from Roggentrolla's Toby Dog fight's gasterblasters
spawntimer = 0
bullets = {}
yoffset = 0
count = 0
c = 0
b = 0
Arena.resize(75,75)

function OnHit(bullet)
    Player.Hurt(5)
end

function Update()
    spawntimer = spawntimer + 1
    if spawntimer%60 == 0 then
		yplacing = math.random(3)
		if yplacing == 1 then
			cannonY = 40 - 13
		elseif yplacing == 2 then
			cannonY = 40 - 38
		else
			cannonY = 40 - 63
		end
		rightorleft = math.random(2)
		if rightorleft == 1 then
			cannonAppearR = CreateProjectile('./modded/blasteroffl', Arena.width/-2-300,cannonY) -- spawns the cannons along the left of the screen, with random y values
			cannonAppearR.SetVar('xspeed',-5)
			cannonAppearR.SetVar('shooting',false) -- so that count can begin increasing
			cannonAppearR.SetVar('count',0)
			cannonAppearR.SetVar('rightorleft',true)
			cannonAppearR.SetVar('ending',false)
			table.insert(bullets,cannonAppearR) --insert into table blah blah blah
		else
			cannonAppearR = CreateProjectile('./modded/blasteroffr', Arena.width/2+300,cannonY) -- spawns the cannons along the left of the screen, with random y values
			cannonAppearR.SetVar('xspeed',5)
			cannonAppearR.SetVar('shooting',false) -- so that count can begin increasing
			cannonAppearR.SetVar('count',0)
			cannonAppearR.SetVar('rightorleft',false)
			cannonAppearR.SetVar('ending',false)
			table.insert(bullets,cannonAppearR) --insert into table blah blah blah
		end
		Audio.PlaySound("sfx_BlasterEntry")
    end

	for i=1,#bullets do
		local bullet = bullets[i] -- convenience
		local count = bullet.GetVar('count')
		local shooting = bullet.GetVar('shooting')
		local ending = bullet.GetVar('ending')
		local RL = bullet.GetVar('rightorleft')
		if RL == true then
			if(shooting == false and ending == false)then
				local distancefromright = Arena.width/-2 -20 - bullet.x --so it slows down as it makes its way to the destination
				local rightspeed = bullet.GetVar('xspeed') / 2 + distancefromright / 20 --i stole this from the follow orb thingie
				if(bullet.x > Arena.width/-2-21 and bullet.y < 76)then
					bullet.SetVar('shooting',true)
					x = bullet.x
					y = bullet.y
					cannonFireR = CreateProjectile('./modded/blasteronl', x, y) --so i make this at the cannon to make it look like it is firing
					beamR = CreateProjectile('./modded/beamL', x + 324, y) -- and i set this up to be just in front of wherever the cannon i
					beamR.Move(0,-1) -- big thanks to crystalwarrior for figuring out how to fix this!
					Audio.PlaySound("blast")
					bullet.Move(0,999999)
				end
				bullet.Move(rightspeed,0) --for moving the cannon in the first place
				bullet.SetVar('xspeed',rightspeed) -- for something haha
			elseif(shooting == true and ending == false)then
				count = count + 1
				if(count == 30)then
					beamR.Move(0,99999) -- bye  cannon
					count = 0
					ending = true
					shooting = false
					stopmultiplying = 2
				end
				bullet.SetVar('count',count)
				bullet.SetVar('ending',ending)
				bullet.SetVar('shooting',shooting)
			elseif(shooting == false and ending == true)then
				cannonFireR.Move(-30,math.sin(count))
				count = count + 1
				if count == 30 then
					count = 0
					shooting = true
					ending = true
				end
				bullet.SetVar('count',count)
				bullet.SetVar('ending',ending)
				bullet.SetVar('shooting',shooting)
			end
		else
			if(shooting == false and ending == false)then
				local distancefromright = Arena.width/2 +20 - bullet.x --so it slows down as it makes its way to the destination
				local rightspeed = bullet.GetVar('xspeed') / 2 + distancefromright / 20 --i stole this from the follow orb thingie
				if(bullet.x < Arena.width/2+21 and bullet.y < 76)then
					bullet.SetVar('shooting',true)
					x = bullet.x
					y = bullet.y
					cannonFireR = CreateProjectile('./modded/blasteronr', x, y) --so i make this at the cannon to make it look like it is firing
					beamR = CreateProjectile('./modded/beamR', x - 324, y) -- and i set this up to be just in front of wherever the cannon i
					beamR.Move(0,1) -- big thanks to crystalwarrior for figuring out how to fix this!
					Audio.PlaySound("blast")
					bullet.Move(0,999999)
				end
				bullet.Move(rightspeed,0) --for moving the cannon in the first place
				bullet.SetVar('xspeed',rightspeed) -- for something haha
			elseif(shooting == true and ending == false)then
				count = count + 1
				if(count == 30)then
					beamR.Move(0,99999) -- bye  cannon
					count = 0
					ending = true
					shooting = false
					stopmultiplying = 2
				end
				bullet.SetVar('count',count)
				bullet.SetVar('ending',ending)
				bullet.SetVar('shooting',shooting)
			elseif(shooting == false and ending == true)then
				cannonFireR.Move(30,math.sin(count))
				count = count + 1
				if count == 30 then
					count = 0
					shooting = true
					ending = true
				end
				bullet.SetVar('count',count)
				bullet.SetVar('ending',ending)
				bullet.SetVar('shooting',shooting)
			end
		end
	end
end

