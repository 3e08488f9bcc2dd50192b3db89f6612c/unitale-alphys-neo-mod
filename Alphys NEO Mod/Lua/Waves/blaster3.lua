timer = 0
circles = {}
startRadius = 150

function Update()
    timer = timer + 1
    if timer < 600 then
        if timer % 60 == 0 then
            CreateCircle()
        end
    end
    MoveBullets()
    if timer == 750 then
        Encounter.Call("InvertPlayer")
    elseif timer >= 810 then
        EndWave()
    end
end

function CreateCircle()
    local circle = {}
    circle['active'] = true
    circle['radius'] = startRadius
    local speed = 2 * math.pi / 60 / 4
    if timer % 120 == 0 then
        speed = speed * -1
    end
    circle['speed'] = speed
    local bullets = {}
    for i = 1, 8 do
        local angle = 2 * math.pi / 8 * i
        local x = startRadius * math.cos(angle)
        local y = startRadius * math.sin(angle)
        local bullet = CreateProjectile('./modded/pellet', x, y)
        bullet.SetVar('angle', angle)
        bullet.sprite.SetAnimation({'pellet', 'pellet2'}, 1 / 12)
        bullet.sprite.color = {64/255, 252/255, 64/255}
        table.insert(bullets, bullet)
    end
    circle['bullets'] = bullets
    table.insert(circles, circle)
end

function MoveBullets()
    for i = 1, #circles do
        local circle = circles[i]
        local active = circle['active']
        if active then
            local radius = circle['radius']
            radius = radius - 1
            circle['radius'] = radius
            local speed = circle['speed']
            local bullets = circle['bullets']
            if radius <= 0 then
                circle['active'] = false
                for i = 1, #bullets do
                    local bullet = bullets[i]
                    if bullet.isactive then
                        bullet.Remove()
                    end
                end
            else
                for j = 1, #bullets do
                    local bullet = bullets[j]
                    if bullet.isactive then
                        local angle = bullet.GetVar('angle')
                        angle = angle + speed
                        bullet.SetVar('angle', angle)
                        local x = radius * math.cos(angle)
                        local y = radius * math.sin(angle)
                        bullet.MoveTo(x, y)
                    end
                end
            end
        end
    end
end

function OnHit(bullet)
    Player.Heal(5)
    bullet.Remove()
end
