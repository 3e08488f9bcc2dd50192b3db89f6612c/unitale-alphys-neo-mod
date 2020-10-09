-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Smells like dog food.", "Alphys is sweating.", "Alphys is trembling.", "Alphys."}
commands = {"Check", "Taunt"}
--randomdialogue = {"Random\nDialogue\n1.", "Random\nDialogue\n2.", "Random\nDialogue\n3."}
randomdialogue = nil

sprite = "alphyssadcloseddown" --Always PNG. Extension is added automatically.
name = "Alphys NEO"
hp = 33333
--hp = 100
atk = 128
def = -1000
check = "Check message goes here."
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
canspare = false
cancheck = false

numberoftaunts = 0

-- Happens after the slash animation but before the shaking and hit sound.
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
		local piesEaten = Encounter.GetVar("itemsUsed")[2]
		--She dead bro
		if (hp <= 0) then
			Audio.Stop()
			if (piesEaten >= 11) then
				SetSprite("alphyshurt1")
				Encounter.SetVar("idleAnim",false)
			elseif (GetGlobal("DEAD") == 0) then
				SetGlobal("hurtTime",true)
			else
				SetSprite("Keebler/melt3smile")
			end
		else
			if (GetGlobal("DEAD") == 0) then
				SetGlobal("hurtTime",true)
				if (hp < attackstatus*2) then
					comments = {"She's barely holding on.","Almost.","Alphys is struggling\rto stand."}
				end
			end
		end
        -- player did actually attack
    end
end
 
function OnDeath()
	if (GetGlobal("DEAD") == 0) then
		hp = 33333
		def = -125000
		name = "Alphys"
		--Audio.Pitch(1/12)
		Audio.Stop()
		SetGlobal("DEAD",1)
		State("ENEMYDIALOGUE")
		
	elseif (GetGlobal("DEAD") > 0) then
		--Actually dies. (Do a fadeout here like in real Undertale? Maybe fade the battle in too)
		Kill()
		Player.lv = 13
		BattleDialog({"[noskip][starcolor:000000][w:150][func:StartFadeout][w:30][func:State,DONE]"})
	end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "CHECK" then
		if (GetGlobal("DEAD") == 0) then
			local curdef = 20 - (numberoftaunts*5)
			BattleDialog({"ALPHYS NEO - ATK 128 DEF " .. curdef .. "\nDr. Alphys's greatest\rinvention."})
		else
			BattleDialog({"ALPHYS - ATK 0 DEF -255\nMaybe she'll get to\rsee Undyne again."})
		end
    elseif command == "TAUNT" then
		if (GetGlobal("DEAD") > 0) then
			BattleDialog({"[starcolor:ff0000][color:ff0000]Just finish the job."})
		elseif (numberoftaunts < 4 and GetGlobal("heardAlphys") == true) then
			numberoftaunts = numberoftaunts + 1
			SetGlobal("heardAlphys",false)
			BattleDialog({"You ask Alphys if she's\rtalking to herself."})
			currentdialogue = {"[noskip][func:SetSprite,alphysangrytalk][next]",
			"[voice:alphys][effect:twitch]S-[w:8]SHUT UP!!!"}
			Encounter.SetVar("nextwaves",{"Hard/circlemadness"})
			def = def - 400
			SetGlobal("justTaunted", true)
		elseif (numberoftaunts == 0) then
			numberoftaunts = 1
			BattleDialog({"You describe how satisfying\rit felt to bash Undyne's\rface into a pulp.","You can see her start\rto lose what little\rconfidence she had."})
			currentdialogue = {"[noskip][func:SetSprite,alphysohmygod3][next]",
			"[voice:alphys][effect:twitch].[w:4].[w:4].[w:15][func:SetSprite,alphysohmygod2]Wh...[w:15][func:SetSprite,alphysconcerned]\nWhat ARE you?!"}
			def = def - 150
			--Make sure this attack sets the "hurt on turn 1" global
			Encounter.SetVar("nextwaves",{"Hard/orangetraps"})
			SetGlobal("justTaunted", true)
		elseif (numberoftaunts == 1) then
			numberoftaunts = 2
			BattleDialog({"You tell Alphys she's a\rmurderer too.[w:10] Except YOU\rat least don't hide it."})
			currentdialogue = {"[noskip][func:SetSprite,alphysohmygod2][next]",
			"[voice:alphys][effect:twitch]I...[w:15] [func:SetSprite,alphysangrytalk]I don't know\nwhat you're\ntalking about!"}
			def = def - 225
			Encounter.SetVar("nextwaves",{"Hard/timeflow2"})
			SetGlobal("justTaunted", true)
		elseif (numberoftaunts == 2) then
			numberoftaunts = 3
			BattleDialog({"You tell Alphys you've seen\revery timeline,[w:5] and Undyne\rdoesn't love her in any of them."})
			currentdialogue = {"[noskip][func:SetSprite,alphystalking][next]",
			"[voice:alphys][effect:twitch]T-[w:5]time...?[w:15] [func:SetSprite,alphysconcerned]That...[w:10]\n[func:SetSprite,alphyssaddown]That's not...[w:10] true..."}
			def = def - 300
			Encounter.SetVar("nextwaves",{"Hard/spaceinvaders"})
			SetGlobal("justTaunted", true)
		elseif (numberoftaunts == 3) then
			numberoftaunts = 4
			BattleDialog({"You say \"Mew Mew Kissy Cutie 2\"\ris your favorite anime."})
			currentdialogue = {"[noskip][func:SetSprite,alphysangry][next]",
			"[voice:alphys][effect:twitch]...[w:15][func:SetSprite,alphysangrytalk]I DON'T KNOW WHAT\nYOUR PROBLEM IS BUT\n[func:SetSprite,alphysangryteeth]JUST STOP IT!!!!"}
			def = def - 400
			Encounter.SetVar("nextwaves",{"Hard/circlemadness"})
			SetGlobal("justTaunted", true)
		else
			BattleDialog({"You say something disturbing,[w:10]\rbut she ignores you."})
		end

    end
    
end

function SetAlphys(spritename)
	SetSprite(spritename)
end

function SetJiggle(spritename)
	Encounter.GetVar("alphysSprite").Set(spritename)
end

function EndJiggle()
	Encounter.GetVar("alphysSprite").Remove()
	Encounter.SetVar("jiggleAlphys",nil)
	SetSprite("alphyseyesshut2")
end

function SetBubble(bubbletype)
	dialogbubble = bubbletype
end

function M()
	Audio.LoadFile("tldr")
end

function ESF()
	SetGlobal("esf",Time.time)
end

function StartTransformation()
	SetGlobal("transforming",true)
end

function Refused()
	Audio.LoadFile("earth")
end

function FinalMusic()
	Audio.LoadFile("excerpt")
end

function Afterimage()
	SetGlobal("afterimage",true)
end
