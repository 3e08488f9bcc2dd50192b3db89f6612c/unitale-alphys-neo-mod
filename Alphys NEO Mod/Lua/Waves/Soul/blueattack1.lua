stageOneTimer = 0
stageOne = true

spiderTimer1 = 0
spiders1i = 1

stageTwoTimer = 0
stageTwo = false

spiderTimer2 = 0
spiders2i = 2
spiders2Side = 1

require "Libraries/purplesoul"
CreatePurpleSoulArena()

function Update()
  PurpleSoul()
  
  if stageOne == true then
    stageOneTimer = stageOneTimer+Time.dt
    spiderTimer1 = spiderTimer1+Time.dt
  end
	
  if stageOne == true and stageOneTimer > 6 then
    stageOne = false
    stageTwo = true
  end
  
  if stageOne == true and spiderTimer1 > 0.75 then
    spiderTimer1 = spiderTimer1-0.75
    CreateSpiderProjectile("/modded/purplesoul/spiderbullet", 1, spiders1i, 3)
    CreateSpiderProjectile("/modded/purplesoul/spiderbullet", 1, spiders1i-1, 3)
    if spiders1i == 3 then
      spiders1i = 1
    else
      spiders1i = 3
    end
  end
  
  if stageTwo == true then
    stageTwoTimer = stageTwoTimer+Time.dt
    spiderTimer2 = spiderTimer2+Time.dt
  end
  
  if stageTwo == true and spiderTimer2 > 0.5 then
    spiderTimer2 = spiderTimer2 - 0.5
    CreateSpiderProjectile("/modded/purplesoul/spiderbullet", spiders2Side, spiders2i, 3)
    if spiders2Side == 2 then
      spiders2Side = 1
    else
      spiders2Side = 1
    end
    if spiders2i == 3 then
      spiders2i = 2
    elseif spiders2i == 2 then
      spiders2i = 1
    else
      spiders2i = 3
    end
   end
   
  SpiderProjectileController()
  
  end

  function OnHit(bullet)
  if bullet.GetVar("deadly") then
    Player.hurt(4)
  end
end
