--Green soul by Moofins21
--Expanded on/made more authentic by Crystalwarrior160
--To create new patterns, simply modify bullet_table and nothing else!
--Doesn't support any fancy-fartsy projectiles yet, just the basic "spear" with speed var.
Arena.Resize(130, 130)
bullets = {}
spawntimer = 0
hittimer = 0
shielddir = "up"
mask = CreateProjectile('/modded/greensoul/mask', Player.x, Player.y)
circle = CreateProjectile("/modded/greensoul/circle", 0, 0)
shield = CreateProjectile("/modded/greensoul/shieldup", 0, 20)
heart = CreateProjectile("/modded/greensoul/greenheart", 0, 0)
savedpx = Player.x
savedpy = Player.y
--This is where we grab the bullet pattern table
bullet_table = {
[2] = {dir = 'left', speed = 2}, [8] = {dir = 'left', speed = 3}, [10] = {dir = 'left', speed = 4},
[50] = {dir = 'up', speed = 1},
[60] = {dir = 'right', speed = 2}, [68] = {dir = 'right', speed = 3}, [70] = {dir = 'right', speed = 4},
[110] = {dir = 'down', speed = 1},
[120] = 'repeat'
}
function Update()
	spawntimer = spawntimer + 1
	local proj = bullet_table[spawntimer]
	if type(proj) == "table" then
		local dir = proj.dir
		if type(dir) == "table" then
			dir = dir[math.random(#dir)]
		end
		--Audio.PlaySound('pew') --debug
		if dir == 'down' then
			local bullet = CreateProjectile('/modded/greensoul/bullet', 0, -200)
			bullet.SetVar('velx', 0)
			bullet.SetVar('vely', proj.speed)
			table.insert(bullets, bullet)
		end
		if dir == 'up' then
			local bullet = CreateProjectile('/modded/greensoul/bullet', 0, 200)
			bullet.SetVar('velx', 0)
			bullet.SetVar('vely', -proj.speed)
			table.insert(bullets, bullet)
		end
		if dir == 'left' then
			local bullet = CreateProjectile('/modded/greensoul/bullet', -200, 0)
			bullet.SetVar('velx', proj.speed)
			bullet.SetVar('vely', 0)
			table.insert(bullets, bullet)
		end
		if dir == 'right' then
			local bullet = CreateProjectile('/modded/greensoul/bullet', 200, 0)
			bullet.SetVar('velx', -proj.speed)
			bullet.SetVar('vely', 0)
			table.insert(bullets, bullet)
		end
	end
	if proj == 'repeat' then
		spawntimer = 0
	end
	mask.MoveTo(Player.x, Player.y)

	hittimer = math.max(0, hittimer - 1)
	if savedpx < Player.x then
		shielddir = "right"
	elseif savedpx > Player.x then
		shielddir = "left"
	elseif savedpy < Player.y then
		shielddir = "up"
	elseif savedpy > Player.y then
		shielddir = "down"
	end
	shield.Remove()
	if shielddir == "right" then
		if hittimer > 0 then
			shield = CreateProjectile('/modded/greensoul/shieldright_hit', 20, 0)
		else
			shield = CreateProjectile('/modded/greensoul/shieldright', 20, 0)
		end
	elseif shielddir == "left" then
		if hittimer > 0 then
			shield = CreateProjectile('/modded/greensoul/shieldleft_hit', -20, 0)
		else
			shield = CreateProjectile('/modded/greensoul/shieldleft', -20, 0)
		end
	elseif shielddir == "up" then
		if hittimer > 0 then
			shield = CreateProjectile('/modded/greensoul/shieldup_hit', 0, 20)
		else
			shield = CreateProjectile('/modded/greensoul/shieldup', 0, 20)
		end
	elseif shielddir == "down" then
		if hittimer > 0 then
			shield = CreateProjectile('/modded/greensoul/shielddown_hit', 0, -20)
		else
			shield = CreateProjectile('/modded/greensoul/shielddown', 0, -20)
		end
	end
	savedpx = Player.x
	savedpy = Player.y
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			bullet.MoveTo(newposx, newposy)
			if bullet.x > -32 and bullet.x < -18 and bullet.GetVar('velx') > 0 and shielddir == "left" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.x < 32 and bullet.x > 18 and bullet.GetVar('velx') < 0 and shielddir == "right" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.y < 32 and bullet.y > 18 and bullet.GetVar('vely') < 0 and shielddir == "up" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.y > -32 and bullet.y < -18 and bullet.GetVar('vely') > 0 and shielddir == "down" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			end
			if bullet.x < 14 and bullet.x > -14 and bullet.GetVar('vely') == 0 then
				bullet.Remove()
				Player.Hurt(3)
			elseif bullet.y < 14 and bullet.y > -14 and bullet.GetVar('velx') == 0 then
				bullet.Remove()
				Player.Hurt(3)
			end
		end	
	end
end
 
function OnHit(bullet)
--jack shit
end
