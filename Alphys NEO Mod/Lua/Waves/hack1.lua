-- The bouncing bullets attack from the documentation example.
-- Sets a bullet's color as a string, then checks it in OnHit to achieve different types of bullet effects in one wave.
spawntimer = 0
bullets = {}
colors = {"regular", "cyan", "orange", "green"}

function Update()
    spawntimer = spawntimer + 1
    if spawntimer%30 == 0 then
        local posx = 30 - math.random(60)
        local posy = Arena.height/2

        local bulletType = colors[math.random(#colors)]
        local bullet = CreateProjectile("bullet", posx, posy)
        bullet.sprite.SetAnimation({'bullet', 'bullet'}, 1 / 12)
        if bulletType == "cyan" then
        elseif bulletType == "orange" then
        elseif bulletType == "green" then
        end

        bullet.SetVar('color', bulletType)
        bullet.SetVar('velx', 1 - 2*math.random())
        bullet.SetVar('vely', 0)
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
    local damage = 5
    if color == "regular" then
        Player.Hurt(1,0.01)
        bullet.Remove()
    elseif color == "cyan" and Player.isMoving then
        Player.Hurt(1,0.01)
        bullet.Remove()
    elseif color == "orange" and not Player.isMoving then
        Player.Hurt(1,0.01)
        bullet.Remove()
    elseif color == "green" then
        Player.Heal(1)
        bullet.Remove()
    end
end