bullets = {}
bHoles = {}
spawned = false
pMoved = false
canBMove = false
spawntimer = 0
movetimer = 30

function Update()
  Arena.Resize(240, 240)
  if pMoved == false then
    Player.MoveTo(0, 60, false)
    pMoved = true
  end
  spawntimer = 1 + spawntimer
  if spawntimer%2 == 0 then
    local heightOrWidth = math.random(4)
    if heightOrWidth == 1 then
      local posx = math.random(360) - 180
      local posy = -Arena.height / 2 - 30
      local bullet = CreateProjectile('./modded/lapislazuli/bullet', posx, posy)
      table.insert(bullets, bullet)
    elseif heightOrWidth == 2 then
      local posx = math.random(360) - 180
      local posy = Arena.height / 2 + 30
      local bullet = CreateProjectile('./modded/lapislazuli/bullet', posx, posy)
      table.insert(bullets, bullet)
    elseif heightOrWidth == 3 then
      local posx = -Arena.width / 2 - 30
      local posy = math.random(360) - 180
      local bullet = CreateProjectile('./modded/lapislazuli/bullet', posx, posy)
      table.insert(bullets, bullet)
    elseif heightOrWidth == 4 then
      local posx = Arena.width / 2 + 30
      local posy = math.random(360) - 180
      local bullet = CreateProjectile('./modded/lapislazuli/bullet', posx, posy)
      table.insert(bullets, bullet)
    end
  end
  
  if spawned == false then
    local heightOrWidth = 4
    if heightOrWidth == 1 then
      local posx = math.random(360) - 180
      local posy = -Arena.height / 2 + 16
      local bHole = CreateProjectile('./modded/lapislazuli/bHole', posx, posy)
      table.insert(bHoles, bHole)
    elseif heightOrWidth == 2 then
      local posx = math.random(360) - 180
      local posy = Arena.height / 2 + 96
      local bHole = CreateProjectile('./modded/lapislazuli/bHole', posx, posy)
      table.insert(bHoles, bHole)
    elseif heightOrWidth == 3 then
      local posx = -Arena.width / 2 - 32
      local posy = math.random(360) - 180
      local bHole = CreateProjectile('./modded/lapislazuli/bHole', posx, posy)
      table.insert(bHoles, bHole)
    elseif heightOrWidth == 4 then
      local posx = Arena.width / 2 + 32
      local posy = math.random(360) - 180
      local bHole = CreateProjectile('./modded/lapislazuli/bHole', posx, posy)
      table.insert(bHoles, bHole)
    end
    spawned = true
  end
  
  movetimer = movetimer - 1
  
  for i=1,#bullets do
    local bullet = bullets[i]
    local angle = math.atan2(bullet.y - bHoles[1].y, bullet.x - bHoles[1].x)
    local velx = 2 * math.cos(angle)
    local vely = 2 * math.sin(angle)
    
    if movetimer <= 0 then
      local newPosX = bullet.x - velx
      local newPosY = bullet.y - vely
      bullet.MoveTo(newPosX, newPosY)
    end
  end
end