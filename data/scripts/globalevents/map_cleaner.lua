--[[
    Map Cleaner System (RevScript)
    
    Automatically cleans the map at regular intervals with multiple warnings.
    
    Warning schedule:
    - 5 minutes before: First warning
    - 2 minutes before: Second warning (may cause lag)
    - 0 minutes: Map is cleaned
]]

local function cleanMapTimer(clean)
    if not clean then
        Game.broadcastMessage("Map will be cleaned in 2 minutes. Be aware, there may be some lag.", MESSAGE_STATUS_WARNING)
        addEvent(cleanMapTimer, 2 * 60 * 1000, true)
    else
        local removed = cleanMap()
        if removed > 0 then
            Game.broadcastMessage(string.format("Map cleaned successfully! %d item%s removed from the ground.", removed, removed > 1 and "s" or ""), MESSAGE_STATUS_WARNING)
            print(string.format("[MapCleaner] %d items removed.", removed))
        else
            Game.broadcastMessage("Map cleaned successfully! No items found on the ground.", MESSAGE_STATUS_WARNING)
            print("[MapCleaner] No items to remove.")
        end
    end
end

local mapCleaner = GlobalEvent("MapCleaner")

function mapCleaner.onThink(interval, lastExecution)
    Game.broadcastMessage("Map will be cleaned in 5 minutes. Please pick up your items!", MESSAGE_STATUS_WARNING)
    addEvent(cleanMapTimer, 3 * 60 * 1000, false)
    return true
end

mapCleaner:interval(30 * 60 * 1000) -- 30 minutes
mapCleaner:register()