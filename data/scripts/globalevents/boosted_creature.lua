local monsterList = {
	"Dragon",
	"Demon",
	"Giant Spider",
	"Hydra",
	"Behemoth",
	"Mutated Rat",
	"Necromancer",
	"Vampire",
	"Grim Reaper",
	"Hero",
	"Bog Raider",
	"Black Knight",
	"Warlock",
	"Medusa",
	"Serpent Spawn"
}

local boostedSystem = GlobalEvent("BoostedCreatureStartup")

function boostedSystem.onStartup()
	local randomIndex = math.random(1, #monsterList)
	local selectedMonster = monsterList[randomIndex]

	Game.setBoostedCreature(selectedMonster)

	print(">> Boosted Creature of the day: " .. selectedMonster .. "!")
	return true
end

boostedSystem:register()

local loginBoosted = CreatureEvent("Boosted Creature Login")

function loginBoosted.onLogin(player)
	local boosted = Game.getBoostedCreature()
	if boosted ~= "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Today's boosted creature is: " .. boosted .. ". It yields double experience, double loot, and spawns twice as fast!")
	end
	return true
end

loginBoosted:register()
