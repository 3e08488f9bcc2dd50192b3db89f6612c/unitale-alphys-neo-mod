spawntimer = 0
lasers = {}
olasers = {}
missiles = {}

Arena.Resize(350,350)

function Update()
    spawntimer = spawntimer + 1
    if spawntimer%160 == 0 then
        local posx = -320
        local posy = -20
        local laser = CreateProjectile('./modded/lasers/blue laser', posx, posy)
	       	 laser.SetVar('color', 'blue')
                 laser.SetVar('velx', 4.0)
                 laser.SetVar('vely', 0)
                 table.insert(lasers, laser)
        local posx = 320
        local posy = -20
        local laser2 = CreateProjectile('./modded/lasers/blue laser', posx, posy)
                 laser2.SetVar('color', 'blue')
                 laser2.SetVar('velx', -4.0)
                 laser2.SetVar('vely', 0)
                 table.insert(lasers, laser2)
        local posx = 0
        local posy = 320
        local laser3 = CreateProjectile('./modded/lasers/blue laser2', posx, posy)
                 laser3.SetVar('color', 'blue')
                 laser3.SetVar('velx', 0)
                 laser3.SetVar('vely', -4.0)
                 table.insert(lasers, laser3)
        local posx = 0
        local posy = -320
        local laser4 = CreateProjectile('./modded/lasers/blue laser2', posx, posy)
                 laser4.SetVar('color', 'blue')
                 laser4.SetVar('velx', 0)
                 laser4.SetVar('vely', 4.0)
                 table.insert(lasers, laser4)

        end

        for i=1,#lasers do
        local laser = lasers[i]
        local velx = laser.GetVar('velx')
        local vely = laser.GetVar('vely')
        local newposx = laser.x + velx
        local newposy = laser.y + vely
        laser.MoveTo(newposx, newposy)
        laser.SetVar('vely', vely)
        
	end
	if spawntimer == 1 then
        local olaser = CreateProjectile('./modded/lasers/orange laser2', -320, 85)
        local olaser2 = CreateProjectile('./modded/lasers/orange laser', 0, 600)
                 olaser.SetVar('color', 'orange')
                 olaser.SetVar('xspeed', 1)
                 olaser.SetVar('yspeed', 0)
                 olaser2.SetVar('color', 'orange')
                 olaser2.SetVar('xspeed', 0)
                 olaser2.SetVar('yspeed', 1)
                 table.insert(olasers, olaser)
                 table.insert(olasers, olaser2)
                 Audio.PlaySound("lasershot")
        end

        for i=1,#olasers do
        local olaser = olasers[i]
        local xdifference = Player.x - olaser.x
        local ydifference = Player.y - olaser.y
        local newposx = olaser.x + (olaser.GetVar('xspeed') * xdifference / 80)
        local newposy = olaser.y + (olaser.GetVar('yspeed') * ydifference / 80)
        olaser.MoveTo(newposx, newposy)
        end

	if spawntimer %35 == 0 then
        local posx = 320
        local posy = math.random(-Arena.height/2,Arena.height/2)
        local missile = CreateProjectile('bullet', posx, posy)
        missile.SetVar('velx', -5)
        missile.SetVar('vely', 0)
        missile.SetVar('color', 'white')
	table.insert(missiles, missile)
        end

        for i=1,#missiles do
        local missile = missiles[i]
        local velx = missile.GetVar('velx')
        local vely = missile.GetVar('vely')
        local newposx = missile.x + velx
        local newposy = missile.y + vely
        missile.MoveTo(newposx, newposy)
        missile.SetVar('vely', vely)
        
	end
if spawntimer >= 720 then
	EndWave()
end

function OnHit(bullet) 
	if bullet.getVar('color') == 'white' then
	    Player.Hurt(6,0.15)
	elseif (bullet.getVar('color') == 'blue') and Player.isMoving then
	    Player.Hurt(6,0.15)
	elseif (bullet.getVar('color') == 'orange') and not Player.isMoving then
	    Player.Hurt(6,0.15)
            end
end
end

