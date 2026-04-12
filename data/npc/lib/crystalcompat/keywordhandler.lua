-- CrystalServer compatibility wrapper for KeywordHandler
-- Reuses the real NpcSystem handler so legacy NPCs keep working unchanged.

CrystalKeywordHandler = CrystalKeywordHandler or {}
CrystalKeywordHandler.__index = CrystalKeywordHandler

function CrystalKeywordHandler:new(...)
	if _G.OriginalKeywordHandlerNew then
		return _G.OriginalKeywordHandlerNew(KeywordHandler, ...)
	end

	local obj = {}
	setmetatable(obj, CrystalKeywordHandler)
	return obj
end
