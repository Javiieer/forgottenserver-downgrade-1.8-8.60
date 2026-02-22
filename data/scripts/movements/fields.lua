-- Field items using SERVER IDs from items.xml
local fieldItems = {
	-- Campfires (1998-2000)
	1998, 1999, 2000,
	
	-- Fire fields
	2118, 2119, 2120,  -- standard fire field
	2123, 2124, 2125,  -- fire field variant
	21465, 2132, 2133,  -- fire field variant
	2136, 2137,        -- fire bomb
	10069, 10070, 10071, -- fire field variant
	7465,              -- fire field
	
	-- Poison fields
	105,              -- poison gas
	2121,              -- poison gas
	2134,              -- poison gas
	23367, 23368,      -- poison/smoke trap
	
	-- Energy fields
	2122,              -- energy field
	2126,              -- energy field
	2135,              -- energy field
	23366,             -- energy trap
}

for _, itemId in ipairs(fieldItems) do
	local stepIn = MoveEvent()
	stepIn:type("stepin")
	stepIn:id(itemId)
	stepIn:onStepIn(function(creature, item, position, fromPosition)
		if item:isMagicField() then
			item:onStepInField(creature)
		end
		return true
	end)
	stepIn:register()

	local addItem = MoveEvent()
	addItem:type("additem")
	addItem:id(itemId)
	addItem:onAddItem(function(moveitem, tileitem, position)
		if moveitem:isMagicField() then
			local tile = Tile(position)
			if tile then
				local creatures = tile:getCreatures()
				if creatures then
					for _, creature in ipairs(creatures) do
						moveitem:onStepInField(creature)
					end
				end
			end
		end
		return true
	end)
	addItem:register()
end
