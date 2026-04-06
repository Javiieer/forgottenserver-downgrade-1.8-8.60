local talkaction = TalkAction("/town")

function talkaction.onSay(player, words, param)
	local town = Town(param) or Town(tonumber(param))
	if town then
		player:teleportTo(town:getTemplePosition())
		player:setInstanceId(0)
	else
		player:sendCancelMessage("Town not found.")
	end
	return false
end

talkaction:separator(" ")
talkaction:access(true)
talkaction:register()

