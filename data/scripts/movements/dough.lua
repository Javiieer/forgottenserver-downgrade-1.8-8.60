local moveevent = MoveEvent()
function moveevent.onAddItem(moveitem, tileitem, position)
	if moveitem:getId() == 3604 then
		moveitem:transform(3600)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
	elseif moveitem:getId() == 6276 then
		moveitem:transform(6277, 12)
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
	end
	return true
end
moveevent:type("additem")
moveevent:id(2535, 2537, 2539, 2541)
moveevent:tileItem(1)
moveevent:register()
