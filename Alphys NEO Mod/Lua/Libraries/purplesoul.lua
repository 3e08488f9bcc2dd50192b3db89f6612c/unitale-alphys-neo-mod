--[[
----------------
PURPLE SOUL v1.0
by Joms or /u/Jomy582 on reddit
----------------
Library for the purple soul by Joms
Also includes Muffet's 3 attacks (not the muffin pet since we can't move the arena yet without major hacks)
Screw donuts. Donuts are satan

README!!!!!!!!
FUNCTIONS MARKED WITH "**CU**" ARE FUNCTIONS THAT ARE SAFE FOR YOU TO USE (Can Use). EVERYTHING ELSE IS AUTOMATED BY THE LIBRARY!
feel fiddle with the, though. But there will probably be bugs if you do that

THINGS TO ADD LATER:
1. Webs go under the player. This will be fixed when proper bullet layering comes out. Nothing can go behind the player except if a bullet mask is put over the player and that creates enough bugs by itself so I'll just wait it out.
2. Invincibility frames turn to a darker shade of purple. This will also be fixed when this feature is implemented into Unitale.
Pet attack. I have a prototype in the works already.
3. Maybe animate Muffet's sprite and package it with this library
4. I'll also work on general improvements as well. Something could probably be done about the smooth animation
IF YOU FIND ANY BUGS (heh) LET ME KNOW!


How to activate
----
Outside of your wave update function put:
require "Libraries/purplesoul"
If you changed the file location of this library, replace "Libraries/purplesoul" with whatever your filepath is.
Make sure to keep the sprites!

Example wave shown here: http://hastebin.com/yuvezefexo.lua

------------------------------------------DOCUMENTATION----------------------------------------

TERMS
----
web - One of the purple lines on the arena.

SOUL FUNCTIONS
----
PurpleSoul() - Main function that makes the player restricted to three webs. Put this in your wave update function.
CreatePurpleSoulArena() - Creates the arena and draws webs onto said arena. Put this OUTSIDE your wave update function, or whenever you want the arena to be made.

SPIDER TERMS AND FUNCTIONS
----
CreateSpiderProjectile(sprite, sideNum, rowNum, speed) - Creates a spider projectile that moves in a straight line on one web. Put this in your wave update function when you want the bullet to spawn.

sprite - The name of your sprite (in quotes!).
sideNum - An int from 1 to 2 (1 is left, 2 is right).
rowNum - An int from 1 to 3 (1 is top, 2 is mid, 3 is bot).
speed - How fast you want it to go in terms of pixels/frame.
EXAMPLE: CreateSpiderProjectile("purplesoul/spiderbullet", 2, 1, 3)

DONUT TERMS AND FUNCTIONS
----
CreateDonutProjectile(sprite, sideNum, rowNum, speed, squishSprite) - Creates a donut projectile that bounces off of either the top or bottom of the arena based on where it was created. Put this in your wave update function when you want the bullet to spawn

sprite - The name of your sprite (in quotes!)
sideNum - An int from 1 to 2 (1 is left, 2 is right)
rowNum - An int from 1 to 3 (1 is top, 2 is mid, 3 is bot). Top and bot bounce but mid is just a straight line
speed - How fast you want it to go in terms of pixels/frame
squishSprite - The name of your your sprite when the donut gets squished(in quotes!).
EXAMPLE: CreateDonutProjectile("purplesoul/donutbullet", 1, 3, 3, "purplesoul/donutbulletsquish")
Developer's note: Screw donuts they were hell to code for varying speeds

CROISSANT TERMS AND FUNCTIONS
----
CreateCroissantProjectile(sprite, sideNum, rowNum) - Creates a croissant projectile that moves in a straight line on one web like a boomerang. It'll move across the entire web, slow dow and turn around, then accelerate in the opposite direction. Put this in your wave update function when you want the bullet to spawn.

sprite - The name of your sprite (in quotes!). Croissants use a different sprite for each direction. Make sure to remember that!
sideNum - An int from 1 to 2 (1 is left, 2 is right).
rowNum - An int from 1 to 3 (1 is top, 2 is mid, 3 is bot).
EXAMPLE: CreateCroissantProjectile("purplesoul/croissantr", 2, 3)
Developer's note: Croissants in Undertale only have one speed. If you want the code to factor in speed, you'll have to figure it out yourself.
]]--

---------------------------------REGULAR SOUL MOVING AND ARENA---------------------------------

moveUp = false
moveDown = false
moveTimerV = 0
moveCount = 0
playery = 0

--**CU**
--put this in your wave update function
--main function that makes the player restricted to three lines
function PurpleSoul()
  if Input.Up == 1 and Player.y < tWeb.y and moveDown == false then
    moveUp = true
    playery = Player.y
  end
  if Input.Down == 1 and Player.y > bWeb.y and moveUp == false then
    moveDown = true
    playery = Player.y
  end
  UpDownController()
  
  if Input.Left > 0 and Player.x > -100 then
    Player.MoveTo(Player.x-2, Player.y, false)
  end
  if Input.Right > 0 and Player.x < 100 then
    Player.MoveTo(Player.x+2, Player.y, false)
  end
end

--**CU**
--put this OUTSIDE of your encounter update function. Probably right after you require the library
--creates the arena and draws webs onto said arena
function CreatePurpleSoulArena()
  Arena.Resize(240, Arena.height)
  
  --top web
  tWeb = CreateProjectile("/modded/purplesoul/arenaweb", 0, 40)
  
  --mid web
  mWeb = CreateProjectile("/modded/purplesoul/arenaweb", 0, 0)
  
  --bot web
  bWeb = CreateProjectile("/modded/purplesoul/arenaweb", 0, -40)
  
  SetPurpleSoul()
end

--sets the soul to a purple color and creates lines
function SetPurpleSoul()
  Player.sprite.color = {213/255, 53/255, 217/255}
  Player.SetControlOverride(true)
end

--controls the smooth animation for moving up and down
function UpDownController()
  if moveUp == true then
    MoveTimer()
    if moveTimerV > 0.000001 and moveCount < 4 then
      moveTimerV = moveTimerV - 0.000001
      Player.MoveTo(Player.x, Player.y+10, false)
      moveCount = moveCount + 1
    elseif moveCount > 3 then
      moveTimerV = 0
      moveCount = 0
      moveUp = false 
      Player.MoveTo(Player.x, playery+40, false) --ensures that no matter what the player gets to the web
    end
  end
  if moveDown == true then
    MoveTimer()
    if moveTimerV > 0.000001 and moveCount < 4 then
      moveTimerV = moveTimerV - 0.000001
      Player.MoveTo(Player.x, Player.y-10, false)
      moveCount = moveCount + 1
    elseif moveCount > 3 then
      moveTimerV = 0
      moveCount = 0
      moveDown = false 
      Player.MoveTo(Player.x, playery-40, false) --ensures that no matter what the player gets to the web
    end
  end
end

--a timer for controlling smooth animation
function MoveTimer()
  moveTimerV = moveTimerV + Time.dt
end

---------------------------------SPIDER BULLET---------------------------------

--spider bullet table
spiderBullets = {}

--**CU**
--put this in your wave update function when you want the bullet to spawn
--creates a spider projectile.
--sprite is the name of your sprite (in quotes!)
--sideNum is an int from 1 to 2 (1 is left, 2 is right)
--rowNum is an int from 1 to 3 (1 is top, 2 is mid, 3 is bot)
--speed is how fast you want it to go in terms of pixels/frame
--IF YOU DON'T USE THESE GUIDELINES THEN IT WILL BUG OUT (heh. bugs. spiders. hehehehe)
function CreateSpiderProjectile(sprite, sideNum, rowNum, speed)
  --side
  local x = 0
  if sideNum == 1 then
    x = (-Arena.width/2)-100
  else
    x = (Arena.width/2)+100
    speed = -speed
  end
  --row
  local y = 0
  if rowNum == 1 then
    y = tWeb.y
  elseif rowNum == 2 then
    y = mWeb.y
  else
    y = bWeb.y
  end
  local spider = CreateProjectile(sprite, x, y)
  spider.SetVar("speed", speed)
  spider.SetVar("deadly", true)
  spider.SetVar("side", sideNum)
  spider.SetVar("y", y)
  table.insert(spiderBullets, spider)
end

--**CU**
--put this in your wave update function
--a for loop that controls the spider bullets. Put this method in your Update() function
function SpiderProjectileController()
  for i=1, #spiderBullets do
    local bullet = spiderBullets[i]
    if bullet.isactive then
      local speed = bullet.GetVar("speed")
      local side = bullet.GetVar("side")
      local y = bullet.GetVar("y")
      bullet.MoveTo(bullet.x+(speed*Time.mult), y)
      if bullet.x >(Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
    end
  end
end

---------------------------------DONUT BULLET---------------------------------

--donut bullet table
donutBullets = {}

--**CU**
--put this in your wave update function when you want the bullet to spawn
--creates a donut projectile.
--sprite is the name of your sprite (in quotes!)
--sideNum is an int from 1 to 2 (1 is left, 2 is right)
--rowNum is an int from 1 to 3 (1 is top, 2 is mid, 3 is bot). Top and bot bounce but mid is just a straight line
--speed is how fast you want it to go in terms of pixels/sec.
--squishSprite is the name of your your sprite when the donut gets squished(in quotes!)
--IF YOU DON'T USE THESE GUIDELINES THEN IT WILL BUG OUT (heh. bugs. spiders. hehehehe)
--screw donuts they were hell to code
function CreateDonutProjectile(sprite, sideNum, rowNum, speed, squishSprite)
  --side
  local x = 0
  local xspeed
  if sideNum == 1 then
    x = (-Arena.width/2)-100
    xspeed = speed
  else
    x = (Arena.width/2)+100
    xspeed = -speed
  end
  --row
  local y = 0
  local yspeed = 0
  if rowNum == 1 then
    y = tWeb.y
    local ydifference = -Arena.height/2 - y
    local length = math.abs(math.sqrt(220^2 + ydifference^2))
    yspeed = (ydifference/length)*speed
  elseif rowNum == 2 then
    y = mWeb.y
    yspeed = 0
  elseif rowNum == 3 then
    y = bWeb.y
    local ydifference = Arena.height/2 - y
    local length = math.abs(math.sqrt(220^2 + ydifference^2))  
    yspeed = (ydifference/length)*speed
  end
  local donut = CreateProjectile(sprite, x, y)
  donut.SetVar("xspeed", xspeed)
  donut.SetVar("yspeed", yspeed)
  donut.SetVar("speed", speed)
  donut.SetVar("deadly", true)
  donut.SetVar("bounce", false)
  donut.SetVar("setBounce", false)
  donut.SetVar("bounceTimer", 0)
  donut.SetVar("squishSprite", squishSprite)
  donut.SetVar("sprite", sprite)
  table.insert(donutBullets, donut)
  --x is 220
end

--**CU**
--put this in your wave update function
--a for loop that controls the donut bullets. Put this method in your Update() function
function DonutProjectileController()
  for i=1, #donutBullets do
    local bullet = donutBullets[i]
    if bullet.isactive then
      local xspeed = bullet.GetVar("xspeed")
      local speed = bullet.GetVar("speed")
      local yspeed = bullet.GetVar("yspeed")
      local bounce = bullet.GetVar("bounce")
      local upperBound = Arena.height/2 - 12
      local lowerBound = -Arena.height/2 + 12
      
      bullet.MoveTo(bullet.x+(xspeed*Time.mult), bullet.y+(yspeed*Time.mult))
      if bullet.y > Arena.height/2 - 12 then
        local newy =(lowerBound-bullet.y)
        local ydifference = newy - bullet.y
        local length = math.abs(math.sqrt(220^2 + ydifference^2))  
        yspeed = (ydifference/length)*speed
        bullet.SetVar("bounce", true)
        bullet.SetVar("yspeed", yspeed)
      elseif bullet.y < (-Arena.height/2) + 12 then
        local newy =(upperBound-bullet.y)
        local ydifference = newy - bullet.y
        local length = math.abs(math.sqrt(220^2 + ydifference^2))  
        yspeed = (ydifference/length)*speed
        bullet.SetVar("bounce", true)
        bullet.SetVar("yspeed", yspeed)
      end
      
      if bounce == true then
        local setBounce = bullet.GetVar("setBounce")
        local bounceTimer = bullet.GetVar("bounceTimer")
        BounceTimer(bullet)
        if setBounce == false then
          local squishSprite = bullet.GetVar("squishSprite")
          bullet.sprite.Set(squishSprite)
          bullet.SetVar("setBounce", true)
        elseif bounceTimer > 0.1 and setBounce == true then
          local sprite = bullet.GetVar("sprite")
          bullet.sprite.Set(sprite)
          bullet.SetVar("setBounce", false)
          bullet.SetVar("bounce", false)
          bullet.SetVar("bounceTimer", 0)
        end
      end
      
      if bullet.x >(Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
    end
  end
end

--simple timer for the bounces
function BounceTimer(bullet)
  local bounceTimer = bullet.GetVar("bounceTimer")
  bullet.SetVar("bounceTimer", bounceTimer + Time.dt)
end

---------------------------------CROISSANT BULLET---------------------------------

--croissant bullet table
croissantBullets = {}

--**CU**
--put this in your wave update function when you want the bullet to spawn
--creates a croissant projectile.
--sprite is the name of your sprite (in quotes!)
--sideNum is an int from 1 to 2 (1 is left, 2 is right)
--rowNum is an int from 1 to 3 (1 is top, 2 is mid, 3 is bot)
--IF YOU DON'T USE THESE GUIDELINES THEN IT WILL BUG OUT (heh. bugs. spiders. hehehehe)
--NOTE: Croissants in Undertale only have one speed. If you want the code to factor in speed, you'll have to figure it out yourself
function CreateCroissantProjectile(sprite, sideNum, rowNum)
  --side
  local x = 0
  if sideNum == 1 then
    x = (-Arena.width/2)-100
  else
    x = (Arena.width/2)+100
  end
  --row
  local y = 0
  if rowNum == 1 then
    y = tWeb.y
  elseif rowNum == 2 then
    y = mWeb.y
  else
    y = bWeb.y
  end
  local croissant = CreateProjectile(sprite, x, y)
  croissant.SetVar("deadly", true)
  croissant.SetVar("side", sideNum)
  croissant.SetVar("timer", 0)
  croissant.SetVar("spriteTimer", 0)
  croissant.SetVar("y", y)
  table.insert(croissantBullets, croissant)
end

--**CU**
--put this in your wave update function
--a for loop that controls the spider bullets. Put this method in your Update() function
function CroissantProjectileController()
  for i=1, #croissantBullets do
    local bullet = croissantBullets[i]
    if bullet.isactive then
      local side = bullet.GetVar("side")
      local timer = bullet.GetVar("timer")
      local spriteTimer = bullet.GetVar("spriteTimer")
      local y = bullet.GetVar("y")
      if side == 1 then
        bullet.MoveTo(bullet.x+((5.1*math.cos(timer))*Time.mult), y)
        bullet.sprite.rotation = (spriteTimer*360)/2
      end
      if side == 2 then
        bullet.MoveTo(bullet.x-((5.2*math.cos(timer))*Time.mult), y)
        bullet.sprite.rotation = -(spriteTimer*360)/2
      end
      bullet.SetVar("timer", timer+Time.dt)
      bullet.SetVar("spriteTimer", spriteTimer+Time.dt)
      
      if bullet.x >(Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
    end
  end
end

function Bullet()
    spawntimer = spawntimer + 1
    if spawntimer%25 == 0 then
        local posx = -(Arena.width/2) + 8
        local posy = Player.y
        local bullet = CreateProjectile('/modded/bullet',posx,posy)
		bullet.SetVar('velx',0.1*math.random(15,25))
        table.insert(bullets,bullet)
    end

	for i=1,#bullets do
		local bullet = bullets[i]
		local newposx = bullet.x + (bullet.GetVar('velx'))

		if (bullet.x < -(Arena.width/2) + 8) then
			newposx = -(Arena.width/2) + 8 -- Lets it catch up when the arena shrinks down (when using the Check command w/ low spawn timer)
		end

		if (bullet.x > (Arena.width/2) - 8) then
			newposx = 650 -- Basically deletes the bullet when it hits the other side!
		end

		bullet.MoveTo(newposx, bullet.y)
	end
end