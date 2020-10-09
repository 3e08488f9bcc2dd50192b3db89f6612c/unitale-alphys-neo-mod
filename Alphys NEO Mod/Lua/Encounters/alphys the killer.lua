music = "AlphysTakesActionIntro"

encountertext = "Welcome to HardMode" --Modify as necessary. It will only be read out in the action select screen.

nextwaves = {"blank"}
wavetimer = 15.0
--565 arena width is size of text box
arenasize = {155, 130}

intro = true
introDialoguing = false
introPhase = 2
introTime = Time.time
--Length of this pause between textboxes, in seconds
introPhaseLength = 2

introMessage = 1

songIntro = false
songTimer = 0

screenAnims = {}
whiteFadeBullets = {}
oneFrameBullets = {}
transformationTimer = 0
transformed = false
SetGlobal("transforming",false)
playedLastSound = false

SetGlobal("attackNum",0)
SetGlobal("DEAD",0)
SetGlobal("hit1",false)
SetGlobal("hurtTime",-10)

NONE = 0
FIGHT = 1
ACT = 2
ITEM = 3
MERCY = 4
DEFENSE = 5
INNERACT = 6

cursorLoc = FIGHT
curMenu = DEFENSE
itemNum = 1

idleAnim = false

enemies = {
"Alphys"
}

jiggleAlphys = nil
alphysSprite = nil

afterimages = {}
aitimers = {}
spawntimer = 0

enemypositions = {
{-5, 0}
}

itemsUsed = { false, 0, false, false, false, false, false }
justUsedNullItem = false

rollingHP = -1

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou"}

randomList = {"attack1","yellow1","yellow2","piano1"}

local blackbullet

function Update()
	--Control Alphys' sprite when appropriate here.
	if (GetGlobal("hurtTime") == true) then
		SetAlphys("alphyshurt2")
	elseif (GetGlobal("DEAD") == 0 and idleAnim == true) then
		local turn = GetGlobal("attackNum")
		if (turn < 12) then
			SetAlphys("alphyssweating" .. math.floor((Time.time/2) % 4))
		elseif (turn < 14) then
			SetAlphys("alphysangry")
		elseif (turn == 14) then
			SetAlphys("alphysangryteeth")
		else
			SetAlphys("alphyssadangry")
		end
	end	
	
	--Remove bullets to be displayed only one frame (well, one update)
	for i=#oneFrameBullets,1,-1 do
		oneFrameBullets[i].Remove()
		table.remove(oneFrameBullets,i)
	end
	
	--The song has an intro that only plays once
	if (songIntro == true) then
		if (Audio.playtime < songTimer or Audio.playtime > 32.010) then
			songIntro = false
			Audio.LoadFile("AlphysTakesAction")
		end		
		songTimer = Audio.playtime
	end
	
	
	
	--Eat shit
	if (rollingHP > -1) then
		rollingHP = rollingHP + 1
		if (rollingHP % 2 == 0) then Player.hp = Player.hp - 1 end
	end
	
	if (curMenu == NONE) then
		if (Input.Confirm == 1) then
			curMenu = cursorLoc
			itemNum = 1
			if (curMenu == ITEM) then
				local bullet = CreateProjectileAbs("item1", 320, 240)
				bullet.SetVar('tile',1)
				table.insert(oneFrameBullets, bullet)
			end
		elseif (Input.Left == 1) then 
			cursorLoc = cursorLoc - 1
			if (cursorLoc == 0) then cursorLoc = MERCY end
		elseif (Input.Right == 1) then
			cursorLoc = cursorLoc + 1
			if (cursorLoc == 5) then cursorLoc = FIGHT end
		end
	elseif (curMenu == ITEM) then
		if (Input.Cancel == 1) then
			curMenu = NONE
		elseif (Input.Confirm == 1) then
			curMenu = DEFENSE
		--There's probably a better way to do this but I don't care!!
		elseif (Input.Left == 1) then
			if (itemNum == 1) then itemNum = 6
			elseif (itemNum == 2) then itemNum = 1
			elseif (itemNum == 4) then itemNum = 3
			elseif (itemNum == 5) then itemNum = 2
			elseif (itemNum == 6) then itemNum = 5
			elseif (itemNum == 7) then itemNum = 4
			end
		elseif (Input.Right == 1) then
			if (itemNum == 1) then itemNum = 2
			elseif (itemNum == 2) then itemNum = 5
			elseif (itemNum == 3) then itemNum = 4
			elseif (itemNum == 4) then itemNum = 7
			elseif (itemNum == 5) then itemNum = 6
			elseif (itemNum == 6) then itemNum = 1
			end
		elseif (Input.Up == 1) then
			if (itemNum == 1) then itemNum = 3
			elseif (itemNum == 2) then itemNum = 4
			elseif (itemNum == 3) then itemNum = 1
			elseif (itemNum == 4) then itemNum = 2
			elseif (itemNum == 5) then itemNum = 7
			elseif (itemNum == 7) then itemNum = 5
			end
		elseif (Input.Down == 1) then
			if (itemNum == 1) then itemNum = 3
			elseif (itemNum == 2) then itemNum = 4
			elseif (itemNum == 3) then itemNum = 1
			elseif (itemNum == 4) then itemNum = 2
			elseif (itemNum == 5) then itemNum = 7
			elseif (itemNum == 7) then itemNum = 5
			end
		end
		
		--Draw the item bullet overlays now. Menu 1
		if (itemNum <= 4) then
			local bullet = CreateProjectileAbs("item1", 320, 240)
			bullet.SetVar('tile',1)
			table.insert(oneFrameBullets, bullet)
		--Menu 2
		else
			local bullet = CreateProjectileAbs("item2", 320, 240)
			bullet.SetVar('tile',1)
			table.insert(oneFrameBullets, bullet)	
		end
	elseif (curMenu == ACT) then
		if (Input.Cancel == 1) then
			curMenu = NONE
		elseif (Input.Confirm == 1) then
			curMenu = INNERACT
		end
	elseif (curMenu == INNERACT) then
		if (Input.Cancel == 1) then
			curMenu = ACT
		elseif (Input.Confirm == 1) then
			curMenu = DEFENSE
		end
	elseif (curMenu ~= DEFENSE) then
		if (Input.Cancel == 1) then
			curMenu = NONE
		elseif (Input.Confirm == 1) then
			curMenu = DEFENSE
		end
	end

	
	--if (GetGlobal("esf") ~= nil) then
		--if (Time.time - GetGlobal("esf") > 0.2) then
			--SetGlobal("esf",nil)
			--BattleDialog({"[noskip]Dr. Alphys tried[func:PlayIntroPSI]\rPSI Anime B![func:StartPSI][w:85]\n[func:EndPSI]" .. math.random(64,99) .. " HP of mortal damage to Chara![w:9999]"})

		--end
	--end
	
	if (GetGlobal("fadeout") ~= nil) then
		if (blackbullet.isactive == false) then
			blackbullet = CreateProjectileAbs("screenfade/black",320,240)
			blackbullet.sprite.alpha = 0
			blackbullet.SetVar('tile', 1)
			blackbullet.SendToBottom()
		end
		blackbullet.sprite.alpha = (Time.time - GetGlobal("fadeout"))*5
	end
	
	--This is all stuff for the intro that doesn't need to update otherwise
	if (intro == true) then
		--Skip intro with C
		if (Input.Menu > 0) then
			nextwaves = {"blank"}
			introDialoguing = false
			introTime = Time.time
			introPhase = 6
			introPhaseLength = 0.001
			State("DEFENDING")
		end
		if (introDialoguing == false) then
			if (introPhase == 6) then
				--Time to end the intro.
				introPhase = 7
				idleAnim = true
				intro = false
				encountertext = "Enemy loaded!"
				State("ACTIONSELECT")
				Audio.Play()
				songIntro = true
				if (whitebullet ~= nil) then whitebullet.Remove() end
				if (blackbullet ~= nil) then blackbullet.Remove() end
			--This is so Alphys pauses between dialogue boxes
			elseif (Time.time - introTime > introPhaseLength) then
				introDialoguing = true
				State("ENEMYDIALOGUE")
			--This is a one-off sprite change midway through a pause
			elseif (Time.time - introTime > (introPhaseLength/2) and introPhase == 4) then
				SetAlphys("alphyssadclosedleft")
			end
		end
		
		--Black fade-in at the start of the battle
		if (blackbullet.sprite.alpha > 0) then
			blackbullet.sprite.alpha = 3 - (Time.time - introTime)*6
			blackbullet.SendToTop()
			if (blackbullet.sprite.alpha < 0) then blackbullet.Remove() end
		end
		
		--The Alphys lua sets transforming via a dialogue box func, this sees it and starts the stuff in encounter.lua once
		if (GetGlobal("transforming") == true) then
			whitebullet = CreateProjectileAbs("screenfade/white",320,240)
			whitebullet.sprite.alpha = 0
			whitebullet.SetVar('tile', 1)
			Audio.PlaySound("neofadeout")
			transformationTimer = Time.time
			SetGlobal("transforming",false)
		end

		--This is used to do the fadeout for the intro "transformation"
		if (transformationTimer > 0) then
			if (Time.time - transformationTimer > 3.5) then
				if (playedLastSound == false) then
					Audio.PlaySound("transformcomplete")
					playedLastSound = true
				end
				local opac = 1.0 - (Time.time - transformationTimer - 3.5) / (1/3)
				whitebullet.sprite.alpha = opac
			else
				local opac = (Time.time - transformationTimer) / (1.4)
				whitebullet.sprite.alpha = opac
			end
		end
	end
	
	for i=#screenAnims,1,-1 do
		-- I want the animations to play at 30 FPS.
		local curFrame = math.floor((Time.time - screenAnims[i].time) / (1/30))
		if (curFrame <= screenAnims[i].frames) then
			local bullet = CreateProjectileAbs(screenAnims[i].type .. curFrame, screenAnims[i].x,screenAnims[i].y)
			bullet.SetVar('tile',1)
			table.insert(oneFrameBullets, bullet)
		else
			table.remove(screenAnims,i)
		end
	end
	
	--Jiggle Alphys during some death scenes. I want to do it at 30 fps
	if (jiggleAlphys ~= nil) then
		if (Time.time - jiggleAlphys > 1/30) then
			jiggleAlphys = Time.time
			alphysSprite.x = 315 + (-1 + math.random()*2)
			alphysSprite.y = 303 + (-1 + math.random()*2)
		end
	end
	
	if (GetGlobal("afterimage") == true) then
		spawntimer = spawntimer + Time.dt
		--Create a new afterimage 30 times a second
		if (spawntimer > 1/30) then
			spawntimer = spawntimer - 1/30
			local newAI = CreateSprite("tldr2/afterimagewhite")
			local cr = 40
			newAI.color = { (96 + math.random()*cr-cr/2) / 255, (64 + math.random()*cr-cr/2) / 255, (224 + math.random()*cr-cr/2) / 255 }
			newAI.x = 325+math.random()*4-2
			newAI.y = 302+math.random()*4-2
			table.insert(afterimages,newAI)
			table.insert(aitimers,Time.time)
		end
	
		--Change color and opacity of existing afterimages
		for i=#afterimages,1,-1 do
			--afterimages[i].color = {math.random(), math.random(), math.random()}
			local timeDiff = Time.time - aitimers[i]
			afterimages[i].alpha = 0.75 - timeDiff * 1.3
			afterimages[i].Scale(0.8 + timeDiff * 0.25, 0.8 + timeDiff * 0.28)
			
			if (afterimages[i].alpha <= 0) then
				afterimages[i].Remove()
				table.remove(afterimages,i)
				table.remove(aitimers,i)
			end
		end
	end
	
	--Audio.Pitch((math.sin(Time.time)*1.5)+1.5)
	
end

function EncounterStarting()
	--Level 12 is what you'd probably be after killing Undyne :c
	Player.name = "Frisk"
	Player.lv = 19
	Player.hp = 99
	Audio.Stop()
	nextwaves = {"blank"}
	
	blackbullet = CreateProjectileAbs("screenfade/black",320,240)
	blackbullet.sprite.alpha = 2
	blackbullet.SetVar('tile', 1)
	blackbullet.SendToTop()
	
	State("DEFENDING")
end

function EnemyDialogueStarting()

	SetGlobal("hurtTime",false)
	idleAnim = false
	curMenu = DEFENSE

	if (introPhase == 2) then
		enemies[1].SetVar('dialogbubble', 'rightwide')
		enemies[1].SetVar('currentdialogue', { 
			"[noskip][next]",
			"[voice:alphys][effect:twitch][func:SetSprite,alphyssaddown]HARDMODE [w:15][func:SetSprite,alphyssadleft].[w:1][func:SetSprite,alphyssadclosedleft]",
		})
		introPhase = 3
		introPhaseLength = 1.75
	elseif (introPhase == 3) then
		enemies[1].SetVar('dialogbubble', 'rightwide')
		enemies[1].SetVar('currentdialogue', { 
			"[voice:alphys][effect:twitch][func:SetSprite,alphyssadleft]by private",
		})
		introPhase = 4
		introPhaseLength = 1.75
	elseif (introPhase == 4) then
		enemies[1].SetVar('dialogbubble', 'rightwide')
		enemies[1].SetVar('currentdialogue', { 
			"[noskip][voice:alphys][func:StartTransformation]I'LL KILL YOU!!!!!!!!!!!!!!![w:45][next]"
		})
		introPhase = 5
		introPhaseLength = 4
	elseif (introPhase == 5) then
		enemies[1].SetVar('dialogbubble', 'rightwide')
		enemies[1].SetVar('currentdialogue', {
			"[next]",
			"[voice:alphys][effect:twitch][func:SetSprite,alphysdimple]Magic Winx.. [w:20][func:SetSprite,alphyssweating3]\nEnchantix."
		})
		introPhase = 6
		introPhaseLength = 0.001
	else
		
		local turn = GetGlobal("attackNum")
		
		if (GetGlobal("DEAD") == 1) then
			if (itemsUsed[2] >= 11) then
				--[[Congratulations, you found the secret dumb easter egg. Not that it's hard to find in the code.
				I really love this monologue from the Halloween Hack, ok?
				You should play the Halloween Hack if you haven't. Check out this that Toby wrote about it:
				"Radiation's Halloween Hack (Press the B Button) is an edit of EarthBound that turns the game's original upbeat mood of
				lighthearted, courageous adventure into that of a fearful, psychologically warped tale based on the willingness
				of game players to fulfill what they are obligated to do, even when it goes against their wishes."
				Sounds a lot like Undertale, huh?
				So, basically, in making Undertale, he simultaneously made the game with an "upbeat mood of lighthearted,
				courageous adventure" AND the "psychologically warped" romhack, at the same time. How about that.
				]]
				Audio.LoadFile("eat")
				enemies[1].SetVar('dialogbubble', 'rightwide')
				enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,tldr2/alphyshurt1][next]",
				"[noskip][voice:alphys][effect:twitch]WHAT IS THIS FEELING[w:20]\n..... [func:SetSprite,tldr2/alphysexcited2]hahaha, i know\nwhat this feeling is[w:20][next]",
				"[noskip][voice:alphys][effect:twitch][w:20][func:SetSprite,tldr2/alphyshappysweat]it's hatred[w:20]\nfor the person who\ncame so far[w:20][next]",
				"[noskip][voice:alphys][effect:twitch]just to destroy\na harmless monster[w:20][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphystalking]my mind is gone.[w:20][next]",
				"[noskip][voice:alphys][effect:twitch]all that is left\nis pure hatred.[w:20]\ng-[w:10][func:SetSprite,tldr2/alphyshurt1]GUH[w:16][func:SetSprite,tldr2/alphyshurt2]my[w:16]NO[w:16][func:SetSprite,tldr2/alphysexcited2]hahaha[w:10]\n[func:SetSprite,tldr2/alphysdetermined]hahahaha[w:30][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphysdetermined]people say I can't\ntake what I dish out[w:20][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphyshappysweat]wl[w:30][func:Afterimage][w:30][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphysdetermined]YOU SEE THIS\nBURNING,[w:10] BLOODY\nUNIVERSE[w:25][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphyscrazyeyebrows2]YOU SEE THIS\nULTIMATE,[w:10] UNLIMITED\nPOWER?[w:25][next]",
				"[noskip][voice:alphys][effect:twitch][func:SetSprite,tldr2/alphystalking]Chara.[w:30][func:M]\n[func:SetSprite,tldr2/alphysangrytalk]I HAVE FUCKING HAD\nIT WITH YOUR SHIT.[w:20][next]",
				"[noskip][voice:alphys][effect:twitch]you little fuckers\nare going to have[w:15][next]",
				"[noskip][voice:alphys][effect:twitch]your bodies ripped\nin half[w:15][next]",
				"[noskip][voice:alphys][effect:twitch]i'll shove your asses\nso far down\nyour throats[w:15][next]",
				"[noskip][voice:alphys][effect:twitch]that when you crap[w:15][next]",
				"[noskip][voice:alphys][effect:twitch]you'll sing\nfucking beethoven[w:15][next]",
				"[noskip][voice:alphys][effect:twitch]tl;dr:[w:10]\n[func:SetSprite,tldr2/alphysdetermined]eat shit, faggots[w:30][func:ESF][next]"
				
				})
				
				nextwaves = {"blank"}
				wavetimer = 99
				
			else
				SetAlphys("blank")
				jiggleAlphys = Time.time
				alphysSprite = CreateSprite("alphysclosed")
				alphysSprite.x = 315
				alphysSprite.y = 303
			
				enemies[1].SetVar('dialogbubble', 'rightwide')
				enemies[1].SetVar('currentdialogue', { "[noskip][next]",
				"[voice:alphys][effect:shake,0.55][waitall:2]...[w:60]\n[func:SetJiggle,alphysclosed2]Well...[w:30]\nI'm not surprised...",
				"[voice:alphys][effect:shake,0.55][waitall:2]If Undyne couldn't\nstop you,[w:15] then...",
				"[noskip][voice:alphys][effect:shake,0.5][func:SetJiggle,alphysclosed][waitall:3]...[w:60][waitall:1][func:EndJiggle]no.[w:30] It's...[w:20]\nIt's not...[w:20] over...",
				"[voice:alphys][effect:shake,0.5][func:SetSprite,alphysexcited2]There's a rush of\nenergy flowing\nthrough me...",
				"[voice:alphys][effect:shake,0.5][func:SetSprite,alphyshappysweat]My entire body is\nready to give up...[w:20]\n[func:SetSprite,alphysexcited3]But my soul won't\nlet it!",
				"[noskip][voice:alphys][effect:shake,0.5][func:SetSprite,alphysdetermined]This is what Undyne\nwas talking about...[w:20]\n[func:SetSprite,alphyscrazyeyebrows2][func:FinalMusic]This is the power\nof [color:ff0000]DETERMINATION[color:000000]![w:30][next]"
				
				})
				
				nextwaves = {"final"}
				wavetimer = 99
			end
		elseif (GetGlobal("DEAD") == 2) then
			Audio.Stop()
			SetGlobal("DEAD",3)
			--Post-final attack.
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,Keebler/melt3closed][next]",
			"[noskip][voice:alphysmelt][effect:shake,0.55][waitall:4]The...[w:40] pain...[w:40]\n[func:SetSprite,Keebler/melt3open]This is what I\nmade them feel...",
			"[noskip][voice:alphysmelt][effect:shake,0.55][func:SetSprite,Keebler/melt3closedmouth][waitall:4]...[w:60][func:SetSprite,Keebler/melt3closed]I deserve this."
			})
			nextwaves = {"blank"}
			wavetimer = 0.01
		elseif (GetGlobal("DEAD") > 2) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,Keebler/melt3closedmouth][next]",
				"[voice:alphysmelt][effect:shake,0.55][waitall:3]..." })
			nextwaves = {"blank"}
			wavetimer = 0.01
		elseif (GetGlobal("justTaunted") == true) then
			--The monster lua ends up taking care of dialogue and nextwaves.
			--local taunts = enemies[1].GetVar('numberoftaunts')
			
		--elseif (turn == 1) then 
			--nextwaves = {"gravity"}
			
		elseif (turn == 1) then 
			nextwaves = {"gravity"}
		elseif (turn == 2) then 
			nextwaves = {"winx/corner1"}
		elseif (turn == 3) then 
			nextwaves = {"attack1"}
			
		elseif (turn == 4) then
			nextwaves = {"attack2"}
			
		elseif (turn == 5) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphyssaddown][next]",
			"[voice:alphys][effect:twitch]Robot Attack\n=\nActivated"})
			nextwaves = {"yellow1"}
			
		elseif (turn == 6) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			idleAnim = true
			nextwaves = {"yellow2"}
			
		elseif (turn == 7) then 
			nextwaves = {"attack5"}
			
		elseif (turn == 8) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysdetermined][next]",
			"[voice:alphys][effect:twitch]RACING 1.0 Impossible :)" })
			nextwaves = {"/saved/coloredtiles"}
			wavetimer = 20.0
			
		elseif (turn == 9) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			if (GetGlobal("fastfinish") == true) then
				enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysohmygod][next]",
				"[voice:alphys][effect:twitch]I...[w:10] [func:SetSprite,alphysawkwardsmile]RACING 2.0 TEST ?" })
			end
			nextwaves = {"/saved/coloredtiles1"}
			--Should end within 19 seconds naturally
			wavetimer = 20.0
			
		elseif (turn == 10) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			if (GetGlobal("fastfinish") == true) then
				enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysawkwardsmile][next]",
				"[voice:alphys][effect:twitch]Luck ? you Luck ?" })
			end
			nextwaves = {"timeflow1"}
			
		elseif (turn == 11) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			idleAnim = true
			--enemies[1].SetVar('currentdialogue', { "[noskip][next]",
			--	"[voice:alphys][effect:twitch]This isn't even\nmy final form!!!" })
			nextwaves = {"timeflow2"}
			
		elseif (turn == 12) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysdetermined][next]",
				"[voice:alphys][effect:twitch]Special Attack\n=\nActivated!!!" })
			nextwaves = {"piano1"}

		elseif (turn == 13) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysdetermined][next]",
				"[voice:alphys][effect:twitch]Racing Version x2" })
			nextwaves = {"/saved/coloredtiles2"}
			wavetimer = 20.0
			
		elseif (turn == 14) then
			nextwaves = {"hack2"}
			
		elseif (turn == 15) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysexcited2][next]",
				--Changed this line because it seemed to be confusing people about maybe they shouldn't move at all
				--All the hasty comment was meant to mean is, if you hold right at the start (as one's prone to do) you instantly turn orange and it becomes unwinnable
				--This... probably isn't any better? Hahaha...
				--"[voice:alphys][effect:twitch]You think you're\ninvincible?[w:10] Well,[w:5] [func:SetSprite,alphysexcited3]don't\nbe too 'hasty'!!" })
				"[voice:alphys][effect:twitch]im joke with you 'ORANGE'" })
			nextwaves = {"/saved/coloredtiles"}
			--Should end within 19 seconds naturally
			wavetimer = 20.0
			
		elseif (turn == 15) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysdimple][next]",
				"[voice:alphys][effect:twitch]Wait...[w:15]\n[func:SetSprite,alphysangrytalk]Noob" })
			nextwaves = {"spaceinvaders"}
			--Ends earlier on its own rules
			wavetimer = 90.0
			
		elseif (turn == 16) then
			if (GetGlobal("heardAlphys") == nil) then SetGlobal("heardAlphys",true) end
			enemies[1].SetVar('def', enemies[1].GetVar('def') - 150)
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysangrytalk][next]",
				"[voice:alphys][effect:twitch]JUST DIE ALREADY!" })
			nextwaves = {"circlemadness"}

		elseif (turn == 17) then
			nextwaves = {"orangetraps"}
		
		elseif (turn == 18) then
			nextwaves = {"Soul/greenattack1"}
	
		--Repeats start here
		elseif (turn == 19) then
			if (GetGlobal("heardAlphys") == nil) then SetGlobal("heardAlphys",true) end
			enemies[1].SetVar('def', enemies[1].GetVar('def') - 200)
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphysangryteeth][next]",
				"[voice:alphys][effect:twitch]HOW MANY MORE\nNEED TO DIE\nBEFORE YOU'LL BE\nSATISFIED?!" })
				
			--Randomly choosing one of the four upgraded attacks
			local choice = math.random(1,#randomList)
			nextwaves = {randomList[choice]}
			table.remove(randomList,choice)
			--nextwaves = {"piano1"}
		
		elseif (turn == 20) then
			enemies[1].SetVar('dialogbubble', 'rightwide')
			enemies[1].SetVar('def', enemies[1].GetVar('def') - 225)
			enemies[1].SetVar('currentdialogue', { "[noskip][func:SetSprite,alphyssadangry][next]",
				"[voice:alphys][effect:twitch]......" })
			--Randomly choosing one of the four upgraded attacks
			local choice = math.random(1,#randomList)
			nextwaves = {randomList[choice]}
			table.remove(randomList,choice)
		
		elseif (turn == 21) then
			idleAnim = true
			--Randomly choosing one of the four upgraded attacks
			local choice = math.random(1,#randomList)
			nextwaves = {randomList[choice]}
			table.remove(randomList,choice)
		
		elseif (turn == 22) then
			idleAnim = true
			--Randomly choosing one of the four upgraded attacks
			local choice = math.random(1,#randomList)
			nextwaves = {randomList[choice]}
			table.remove(randomList,choice)
			--The next 4 turns will have repeat attacks instead
			randomList = {"attack1","yellow1","yellow2","piano1","circlemadness","orangetraps","spaceinvaders","timeflow2","attack2","attack3","attack4","yellow3","yellow4","orangetraps2","piano2","timeflow1","timeflow3","timeflow4","circlemadness2","spaceinvaders2","rain","attack5","blackhole","blaster1","gravity","blaster2","blaster3","blaster4","winx/combyellow1","winx/combtimeflow1","winx/bomb","winx/laserbots1","winx/circleofdeath","winx/supermett1","winx/corner1","Soul/greenattack1","Soul/blueattack1","hack2","hack3","hack4","hack5","hack6"}
		
		else
			idleAnim = true
			local choice = math.random(1,#randomList)
			nextwaves = {randomList[choice]}
			table.remove(randomList,choice)
			--If you're somehow still going this long, it'll take from the last 8 attacks
			if (#randomList == 0) then
				randomList = {"attack1","yellow1","yellow2","piano1","circlemadness","orangetraps","spaceinvaders","timeflow2","attack2","attack3","attack4","yellow3","yellow4","orangetraps2","piano2","timeflow1","timeflow3","timeflow4","circlemadness2","spaceinvaders2","rain","attack5","blackhole","blaster1","gravity","blaster2","blaster3","blaster4","winx/combyellow1","winx/combtimeflow1","winx/bomb","winx/laserbots1","winx/circleofdeath","winx/supermett1","winx/corner1","Soul/greenattack1","Soul/blueattack1","hack2","hack3","hack4","hack5","hack6"}
			end
		end
		
	end
end

function EnemyDialogueEnding()
	if (intro == true) then
		nextwaves = {"blank"} --the blank wave just keeps your heart in place for having pauses
		introDialoguing = false
		introTime = Time.time
		if (introPhase == 2) then
			--SetAlphys("alphyssadcloseddown")
		elseif (introPhase == 3) then
			SetAlphys("alphyssadclosedleft")
		elseif (introPhase == 4) then
			SetAlphys("alphyssadsmile")
		elseif (introPhase == 5) then
			SetAlphys("alphysdimple")
		end
	else
		local turn = GetGlobal("attackNum")
		if (GetGlobal("justTaunted") == true) then
			--Don't need to do anything here?
		elseif (GetGlobal("DEAD") > 2) then
			SetAlphys("Keebler/melt3closedmouth")
		else
			idleAnim = true
		end
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
	if (intro == false) then 
		if (GetGlobal("DEAD") > 0) then
			encountertext = "..."
		elseif (GetGlobal("attackNum") ~= 0) then
			encountertext = RandomEncounterText()
		end
		SetGlobal("attackNum",GetGlobal("attackNum") + 1)
	end
	--Set idleanim = true here?
	idleAnim = true
	curMenu = NONE
	SetGlobal("justTaunted",false)
end

function HandleSpare()
	if (GetGlobal("DEAD") > 0) then
		BattleDialog({"[starcolor:ff0000][color:ff0000]You are a pro.."})
	else
		State("ENEMYDIALOGUE")
	end
end

function HandleItem(ItemID)
	if (ItemID == "DOGTEST1") then
		if (itemsUsed[1] == false) then
			local message = "GAME OVER.\n"
			itemsUsed[1] = true
			message = message .. HealItem(9999999999999999)
			BattleDialog({"YOU ARE HACKER"})
		end
	elseif (ItemID == "DOGTEST2") then
		if (itemsUsed[2] == true) then
			local message = "You lose a HP..\n"
			itemsUsed[2] = true
			message = message .. HealItem(-91)
			BattleDialog({"You lose a HP."})
		end
	end
end

function HealItem(val)
	Audio.PlaySound("nom")
	Player.hp = Player.hp + val
	if (Player.hp == 1) then return "Your HP was maxed out."
	else return "You recovered " .. val .. " HP!" end
end

function SetNone()
	curMenu = NONE
end

function SetAlphys(spritename)
	enemies[1].Call("SetSprite",spritename)
end

function OnHit(bullet)
	if(bullet.GetVar('tile')) == 0 then
    		Player.Hurt(1)
	end
end

function PlayIntroPSI()
	Audio.PlaySound("tldr")
end

function StartPSI()
	Audio.PlaySound("psi")
	table.insert(screenAnims, { type = "tldr2/psi", frames = 101, x = 320, y = 240, time = Time.time })
end

function EndPSI()
	rollingHP = 0
end

function StartFadeout()
	SetGlobal("fadeout",Time.time)
end