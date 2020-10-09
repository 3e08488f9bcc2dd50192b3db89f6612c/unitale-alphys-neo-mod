-- Work like Gaster Blasters
spawntimer = 0
speed = 1
moveDirection = 1
blasters = {}
yblasters = {}
blasts = {}
yblasts = {}
fireRate = 60
blastersCreated = false
blastersFired = false
xMotion = 0
yMotion = 0
timer = 0

function CreateBlasters(blasterPattern, blasterSprite)
	timer = timer + 1
	if blasterPattern == 1 then
		if blastersCreated == false then
			Audio.PlaySound('charge2')
			blaster1 = CreateProjectile(blasterSprite, -400, Player.y)
			blaster1.sprite.rotation = 90
			blaster1.sprite.SendToTop()
			blastersCreated = true
			table.insert(blasters, blaster1)
		end
		if blaster1.x < -250 then
			blaster1.Move(7, 0)
		end
		if (timer % 15 == 0) then
			blastersCreated = false
		end
	end
	if blasterPattern == 2 then
		if blastersCreated == false then
			Audio.PlaySound('charge2')
			blaster1 = CreateProjectile(blasterSprite, -400, Player.y)
			blaster2 = CreateProjectile(blasterSprite, Player.x, 300)
			blaster1.sprite.rotation = 90
			blaster1.sprite.SendToTop()
			blaster2.sprite.SendToTop()
			table.insert(blasters, blaster1)
			table.insert(yblasters, blaster2)
			blastersCreated = true
		end
		if blaster1.x < -150 then
			blaster1.Move(7, 0)
		end
		if blaster2.y > 50 then
			blaster2.Move(0, -7)
		end
		if (timer % 30 == 0) then
			blastersCreated = false
		end
	end
end

function FireBlasters(blasterPattern, blastSprite, blastVertSprite, blasterShootAnim, blasterShootAnimTimePerFrame, blastAnim, blastAnimTimePerFrame, vertBlastAnim, vertBlastAnimTimePerFrame)
	timer = timer + 1
	if blasterPattern == 1 then
		xMotion = xMotion - 1/10
		if blastersFired == false then
			Audio.PlaySound('blast')
			for i=1,#blasters do
				blaster1 = blasters[i]
				blast1 = CreateProjectile(blastSprite, blaster1.x + 1024, blaster1.y)
				blaster1.sprite.SetAnimation(blasterShootAnim, blasterShootAnimTimePerFrame)
				blast1.sprite.SetAnimation(blastAnim, blastAnimTimePerFrame)
				blaster1.sprite.SendToTop()
				table.insert(blasts, blast1)
			end
			blastersFired = true
		end
		for i=1,#blasters do
			for i=1,#blasts do
				blaster1 = blasters[i]
				blast1 = blasts[i]
				if blaster1.x > -400 then
					blaster1.Move(xMotion, 0)
				end
				if timer >= 1 then
					blast1.MoveTo(blaster1.x + 1024, blast1.y)
				end
			end
		end
	end
	if blasterPattern == 2 then
		xMotion = xMotion - 1/10
		yMotion = yMotion + 1/10
		if blastersFired == false then
			Audio.PlaySound('blast')
			for i=1,#blasters do
				blaster1 = blasters[i]
				blast1 = CreateProjectile(blastSprite, blaster1.x + 1024, blaster1.y)
				blast1.sprite.SetAnimation(blastAnim, blastAnimTimePerFrame)
				blaster1.sprite.SetAnimation(blasterShootAnim, blasterShootAnimTimePerFrame)
				blaster1.sprite.SendToTop()
				table.insert(blasts, blast1)
			end
			for i=1,#yblasters do
				blaster2 = yblasters[i]
				blast2 = CreateProjectile(blastVertSprite, blaster2.x, blaster2.y - 1024)
				blast2.sprite.SetAnimation(vertBlastAnim, vertBlastAnimTimePerFrame)
				blaster2.sprite.SetAnimation(blasterShootAnim, blasterShootAnimTimePerFrame)
				blaster2.sprite.SendToTop()
				table.insert(yblasts, blast2)
			end
			blastersFired = true
		end
		for i=1,#blasters do
			for i=1,#blasts do
				blaster1 = blasters[i]
				blast1 = blasts[i]
				if blaster1.x > -400 then
					blaster1.Move(xMotion, 0)
				end
				if timer >= 1 then
					blast1.MoveTo(blaster1.x + 1024, blast1.y)
				end
			end
		end
		for i=1,#yblasters do
			for i=1,#yblasts do
				blaster2 = yblasters[i]
				blast2 = yblasts[i]
				if blaster2.y < 400 then
					blaster2.Move(0, yMotion)
				end
				if timer >= 1 then
					blast2.MoveTo(blast2.x, blaster2.y - 1024)
				end
			end
		end
	end
end