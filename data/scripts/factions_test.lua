-- Monstruo Faccion A (Deepling)
local mTypeA = Game.createMonsterType("Faction Deepling")
local monsterA = {
    name = "Faction Deepling",
    description = "a faction deepling",
    experience = 0,
    outfit = {lookType = 440}, -- Deepling Warrior
    health = 1000,
    maxHealth = 1000,
    faction = FACTION_DEEPLING,
    enemyFactions = { FACTION_PLAYER, FACTION_DEATHLING },
    flags = { attackable = true, hostile = true, targetDistance = 1 },
    attacks = {
        {name = "melee", interval = 2000, chance = 100, minDamage = -10, maxDamage = -20}
    },
    defenses = { defense = 10, armor = 10 }
}
mTypeA:register(monsterA)
-- Monstruo Faccion B (Deathling)
local mTypeB = Game.createMonsterType("Faction Deathling")
local monsterB = {
    name = "Faction Deathling",
    description = "a faction deathling",
    experience = 0,
    outfit = {lookType = 1111}, -- Deathling
    health = 1000,
    maxHealth = 1000,
    faction = FACTION_DEATHLING,
    enemyFactions = { FACTION_PLAYER, FACTION_DEEPLING }, -- Enemigo de los Deeplings
    flags = { attackable = true, hostile = true, targetDistance = 1 },
    attacks = {
        {name = "melee", interval = 2000, chance = 100, minDamage = -10, maxDamage = -20}
    },
    defenses = { defense = 10, armor = 10 }
}
mTypeB:register(monsterB)