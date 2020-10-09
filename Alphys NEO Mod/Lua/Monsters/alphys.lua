-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Smells like dog food.", "Alphys is sweating.", "Alphys is trembling.", "Alphys.", "Fuck you", "You are an idiot", "Goodjob idiot","Waw you are a very-noob with a super pernis","NOOB!!!","Im kill your life","Watch winx noob","Flora... Stella..","porno","wewewewewe","..","UTGERFHRT","sdsdssd"}
commands = {"Talk"}
--randomdialogue = {"Random\nDialogue\n1.", "Random\nDialogue\n2.", "Random\nDialogue\n3."}
randomdialogue = nil

sprite = "alphyssadcloseddown" --Always PNG. Extension is added automatically.
name = "Alphys NEO"
hp = 99999999
--hp = 999999
atk = 100
def = -1
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
		hp = 1
		def = -125000
		name = "Alphys"
		--Audio.Pitch(1/12)
		Audio.Stop()
		SetGlobal("DEAD",1)
		State("ENEMYDIALOGUE")
		
	elseif (GetGlobal("DEAD") > 0) then
		--Actually dies.
		Kill()
		Player.lv = 13
		BattleDialog({"[noskip][starcolor:000000][w:150][func:StartFadeout][w:30][func:State,DONE]"})
	end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "TALK" then
		if (GetGlobal("DEAD") == 0) then
			local curdef = 20 - (numberoftaunts*5)
			BattleDialog({"I`m pro you noob !!!! " .. curdef .. "\nDr.Alphys is a pro\r you are a idiot."})
			BattleDialog({"START " .. curdef .. "\nEEEE"})
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