local talkaction = TalkAction("/instancetest")

local TEST_AREA_CENTER = Position(1112, 1187, 7)
local TEST_MONSTER_NAME = "Demon"
local instanceCounter = 0

function talkaction.onSay(player, words, param)
	param = param:lower():gsub("^%s*(.-)%s*$", "%1")
	local args = {}
	for word in param:gmatch("%S+") do
		args[#args + 1] = word
	end

	local action = args[1] or "info"

	if action == "info" then
		local instanceId = player:getInstanceId()
		local pos = player:getPosition()
		local msg = "=== Instance System Info ===\n"
		msg = msg .. "Your Instance ID: " .. instanceId .. "\n"
		msg = msg .. "Position: " .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. "\n"
		if instanceId == 0 then
			msg = msg .. "Status: Global world (no instance)\n"
		else
			msg = msg .. "Status: Inside instance #" .. instanceId .. "\n"
		end
		player:popupFYI(msg)
		return false
	end

	if action == "enter" then
		instanceCounter = instanceCounter + 1
		local instanceId = instanceCounter
		local oldInstance = player:getInstanceId()
		player:setInstanceId(instanceId)

		local dest = player:getClosestFreePosition(TEST_AREA_CENTER, false)
		if dest.x ~= 0 then
			player:teleportTo(dest)
			dest:sendMagicEffect(CONST_ME_TELEPORT, {player})
		else
			player:teleportTo(TEST_AREA_CENTER)
			TEST_AREA_CENTER:sendMagicEffect(CONST_ME_TELEPORT, {player})
		end

		local destPos = player:getPosition()
		local spawnPos = Position(destPos.x + 1, destPos.y, destPos.z)
		local freePos = player:getClosestFreePosition(spawnPos, false)
		if freePos.x == 0 then freePos = spawnPos end

		local monster = Game.createMonster(TEST_MONSTER_NAME, freePos)
		if monster then
			monster:setInstanceId(instanceId)
			freePos:sendMagicEffect(CONST_ME_TELEPORT, {player})
		end

		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
			string.format("You entered instance #%d (previous: #%d).", instanceId, oldInstance))
		return false
	end

	if action == "exit" then
		local oldInstance = player:getInstanceId()
		if oldInstance == 0 then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You are already in the global world (instance 0).")
			return false
		end

		local spectators = Game.getSpectators(TEST_AREA_CENTER, false, false, 30, 30, 30, 30)
		for _, spec in ipairs(spectators) do
			if spec:isMonster() and spec:getInstanceId() == oldInstance then
				local summons = spec:getSummons()
				if summons then
					for _, summon in ipairs(summons) do
						summon:remove()
					end
				end
				spec:remove()
			end
		end

		player:setInstanceId(0)
		local temple = player:getTown():getTemplePosition()
		player:teleportTo(temple)
		temple:sendMagicEffect(CONST_ME_TELEPORT, {player})

		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
			string.format("You left instance #%d and returned to the global world.", oldInstance))
		return false
	end

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Usage: /instancetest [enter|exit|info]")
	return false
end

talkaction:separator(" ")
talkaction:register()
