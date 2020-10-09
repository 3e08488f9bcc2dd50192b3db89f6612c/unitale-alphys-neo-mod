spawntimer = 0

bonecage = CreateProjectile("/modded/trap", 0, -155)
Audio.PlaySound("Ding")

function Update()
	spawntimer = spawntimer + 1
	if spawntimer > 10 then
		bonecage.Move(0, 0.225)
	end
end

function OnHit(bullet)
	Audio.PlaySound("Ding")
	bonecage.Remove()
	State("ACTIONSELECT")
end