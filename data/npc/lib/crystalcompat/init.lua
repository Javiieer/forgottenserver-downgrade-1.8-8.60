-- Crystal Compat initialization
if _G.CrystalCompatLoaded then return end
_G.CrystalCompatLoaded = true

MESSAGE_GREET = MESSAGE_GREET or 1
MESSAGE_FAREWELL = MESSAGE_FAREWELL or 2
MESSAGE_WALKAWAY = MESSAGE_WALKAWAY or 16

if VOCATION and VOCATION.ID and not VOCATION.BASE_ID then
	VOCATION.BASE_ID = {
		SORCERER = VOCATION.ID.SORCERER,
		DRUID = VOCATION.ID.DRUID,
		PALADIN = VOCATION.ID.PALADIN,
		KNIGHT = VOCATION.ID.KNIGHT,
		MONK = VOCATION.ID.MONK,
	}
end

if Vocation and not Vocation.getBaseId then
	function Vocation.getBaseId(self)
		local base = self.getBase and self:getBase() or self
		return base and base:getId() or 0
	end
end

Storage = Storage or {}
if PlayerStorageKeys and PlayerStorageKeys.firstRod and not Storage.FirstMageWeapon then
	Storage.FirstMageWeapon = PlayerStorageKeys.firstRod
end

dofile('data/npc/lib/crystalcompat/keywordhandler.lua')
dofile('data/npc/lib/crystalcompat/npchandler.lua')
dofile('data/npc/lib/crystalcompat/stdmodule.lua')
dofile('data/npc/lib/crystalcompat/focusmodule.lua')
dofile('data/npc/lib/crystalcompat/npctype.lua')

if KeywordHandler and NpcHandler then
	if not _G.OriginalKeywordHandlerNew then _G.OriginalKeywordHandlerNew = KeywordHandler.new end
	if not _G.OriginalNpcHandlerNew then _G.OriginalNpcHandlerNew = NpcHandler.new end

	function KeywordHandler:new(...)
		return CrystalKeywordHandler:new(...)
	end

	function NpcHandler:new(...)
		return CrystalNpcHandler:new(...)
	end
end
