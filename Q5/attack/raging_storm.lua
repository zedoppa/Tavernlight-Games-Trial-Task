-- Set custom area
-- 0 - no spawn effect area
-- 1 - spawn effect area
-- 3 - caster area
local AREA = {
	{ 0, 0, 0, 1, 0, 0, 0},
	{ 0, 0, 1, 1, 1, 0, 0},
	{ 0, 1, 1, 1, 1, 1, 0},
	{ 1, 1, 1, 3, 1, 1, 1},
	{ 0, 1, 1, 1, 1, 1, 0},
	{ 0, 0, 1, 1, 1, 0, 0},
	{ 0, 0, 0, 1, 0, 0, 0},
}

function spellCallback(cid, position, count, maxCount)
    if Creature(cid) then
        -- Everytime this functions is called, it will spawn the effect and area damage if the condition is met
        if count > 0 and math.random(0, 1) == 1 then
            position:sendMagicEffect(CONST_ME_ICETORNADO)
            doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, -100, -100, CONST_ME_ICETORNADO)
        end

        -- Keep looping until it reached the maxCount value
        if count < maxCount then
            count = count + 1
            -- Trigger the function for every x miliseconds randomly between 500 to 1000
            addEvent(spellCallback, math.random(500, 1000), cid, position, count, maxCount)
        end
    end
end

function onTargetTile(creature, position)
    -- Set how many cycles to loop
    local maxCount = 5
    -- Spawn the magic effect 
    spellCallback(creature:getId(), position, 0, maxCount)
end

local combat = Combat()
combat:setArea(createCombatArea(AREA))
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end