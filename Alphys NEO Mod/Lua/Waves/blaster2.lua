-- The bouncing bullets attack from the documentation example.
-- Sets a bullet's color as a string, then checks it in OnHit to achieve different types of bullet effects in one wave.
spawntimer = 0
bullets = {}
colors = {"regular", "cyan"}
sprites = {"bullet", "bulletcyan"}

function Update()
    spawntimer = spawntimer + 2
    if spawntimer%20 == 0 then
        local posx = 30 - math.random(60)
        local posy = Arena.height/2
        local bulletTypeNumber = math.random(#colors)
        local bulletType = colors[bulletTypeNumber]
        local bulletSprite = sprites[bulletTypeNumber]
        local bullet = CreateProjectile(bulletSprite, posx, posy)
        bullet.SetVar('color', bulletType)
        bullet.SetVar('velx', 1 - 2*math.random())
        bullet.SetVar('vely', -1)
        table.insert(bullets, bullet)
    end
    
    for i=1,#bullets do
        local bullet = bullets[i]
        -- Note this new if check. We're going to remove bullets, and we can't move bullets that were removed.
        if bullet.isactive then
            local velx = bullet.GetVar('velx')
            local vely = bullet.GetVar('vely')
            local newposx = bullet.x + velx
            local newposy = bullet.y + vely
            if(bullet.x > -Arena.width/2 and bullet.x < Arena.width/2) then
                if(bullet.y < -Arena.height/2 + 8) then 
                    newposy = -Arena.height/2 + 8
                    vely = 4
                end
            end
           vely = vely - 0.04
            bullet.MoveTo(newposx, newposy)
            bullet.SetVar('vely', vely)
        end
    end
end

function OnHit(bullet) 
    local color = bullet.GetVar("color")
    local damage = 3
    if color == "regular" then
        Player.Hurt(damage)
    elseif color == "cyan" and Player.isMoving then
		Player.Hurt(damage)
    end
end