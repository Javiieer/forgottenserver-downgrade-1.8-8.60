-- CrystalServer compatibility patch for StdModule
-- Keeps the legacy API but routes all behavior through the real NpcSystem.

CrystalStdModule = CrystalStdModule or {}

local function crystalParseText(npcHandler, text, parseInfo)
	if type(text) == "table" then
		local parsed = {}
		for i = 1, #text do
			parsed[i] = npcHandler:parseMessage(text[i], parseInfo)
		end
		return parsed
	end

	return npcHandler:parseMessage(text, parseInfo)
end

function CrystalStdModule.say(...)
	if _G.CrystalCompatDebug then
		_G.CrystalCompatDebug("StdModule.say called")
	end
	local argc = select("#", ...)
	local cid, message, keywords, parameters, node

	-- Supports both old-style callback shape and the native NpcSystem shape.
	if argc >= 6 then
		local npc, creature, msgType, msg, keys, params = ...
		cid = type(creature) == "number" and creature or (Player(creature) and Player(creature):getId() or 0)
		message = msg
		keywords = keys
		parameters = params
		node = select(7, ...)
	else
		cid, message, keywords, parameters, node = ...
	end

	local npcHandler = parameters and parameters.npcHandler or nil
	if npcHandler == nil then
		error("StdModule.say called without any npcHandler instance.")
	end

	local onlyFocus = (parameters.onlyFocus == nil or parameters.onlyFocus == true)
	if onlyFocus and not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if not player then
		return false
	end

	local parseInfo = {
		[TAG_PLAYERNAME] = player:getName(),
	}

	local text = parameters.text or parameters.message
	local parsedText = crystalParseText(npcHandler, text, parseInfo)
	local delay = parameters.delay or parameters.interval or 4000
	if _G.CrystalCompatDebug then
		_G.CrystalCompatDebug("StdModule.say text type = " .. type(text) .. ", cid = " .. tostring(cid))
	end
	npcHandler:say(parsedText, cid, parameters.publicize and true or false, nil, delay)

	if parameters.reset then
		npcHandler:resetNpc(cid)
	elseif parameters.moveup then
		npcHandler.keywordHandler:moveUp(cid, parameters.moveup)
	end

	return true
end

if StdModule then
	StdModule.say = CrystalStdModule.say
end
