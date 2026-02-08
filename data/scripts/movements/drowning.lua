local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -20)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)

local stepIn = MoveEvent()
function stepIn.onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        local headItem = creature:getSlotItem(CONST_SLOT_HEAD)
        if headItem and isInArray({ 5460, 11585, 13995 }, headItem.itemid) then
            return true
        elseif math.random(1, 10) == 1 then
            position:sendMagicEffect(CONST_ME_BUBBLES)
        end
        creature:addCondition(condition)
        creature:addAchievementProgress("Deep Sea Diver", 1000000)
    end
    return true
end
stepIn:type("stepin")
stepIn:id(5404, 5405, 5406, 5407, 5408, 5409, 5743, 5764, 8755, 8756, 8757, 9291)
stepIn:register()

local stepOut = MoveEvent()
function stepOut.onStepOut(creature, item, position, fromPosition)
    if creature:isPlayer() then creature:removeCondition(CONDITION_DROWN) end
    return true
end
stepOut:type("stepout")
stepOut:id(5404, 5405, 5406, 5407, 5408, 5409, 5743, 5764, 8755, 8756, 8757, 9291)
stepOut:register()
