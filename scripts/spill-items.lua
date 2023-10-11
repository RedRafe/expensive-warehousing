local SLOTS_PER_SECOND = 2

local function spill_content(unit)
  -- spill_content
  local entity = unit.entity
  local inventory = unit.inventory
  local spill_stack = entity.surface.spill_item_stack

  if inventory.is_empty() then return end

  inventory.sort_and_merge()

  -- docs: https://lua-api.factorio.com/latest/classes/LuaSurface.html#spill_item_stack
  for i=1, math.min(#inventory, SLOTS_PER_SECOND) do
    local c = 
    spill_stack(
      entity.position, 
      inventory[i],
      false,
      nil,
      false
    )
    inventory[i].clear()
  end
end

local function check_connection()
  for ___, unit in pairs(global.units) do
    local entity = unit.entity
    local powersource = unit.powersource

    if entity.valid == false or powersource.valid == false then
      log("Unable to access invalid entity or powersource")
      goto skip
    end

    if not powersource.is_connected_to_electric_network() then
      spill_content(unit)
    end

    ::skip::
  end
end

--=================================================================================================

---@type ScriptLib
local Spill = {}

Spill.on_nth_tick = { 
  [60 * 2] = check_connection
}

return Spill