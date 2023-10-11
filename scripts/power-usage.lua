local BLACKLIST = require 'config.blacklist'
local WEIGHTS = require 'config.weights'
local BASE = settings.global['ew:base'].value or 5
local STEP = settings.global['ew:step'].value or 2.05879/10^6
local EXP = settings.global['ew:exp'].value or 1.3
local MAX = settings.global['ew:max'].value or 60
local CHEST_ID = defines.inventory.chest
local MW_RATE = 5000 / 0.3

local function setup()
  global.units = global.units or {}
end

local function get_weight(item)
  return WEIGHTS[item] or 1
end

local function compute_power_usage(weight)
  local p = (BASE + (weight ^ EXP) * STEP ) * MW_RATE
  local m = MAX * MW_RATE
  return p < m and p or m
end

local function on_built(event)
  local entity = event.created_entity or event.entity
  if not entity then return end
  if entity.type ~= 'container' and entity.type ~= 'logistic-container' then return end
  if entity.prototype.get_inventory_size(CHEST_ID) <= 48 then return end
  if BLACKLIST[entity.name] then return end

  global.units[entity.unit_number] = {
    entity = entity,
    powersource = entity.surface.create_entity{
      name = 'ew-storage-power',
      position = entity.position,
      force = entity.force
    },
    inventory = entity.get_inventory(CHEST_ID)
	}
end

local function on_destroyed(event)
  local entity = event.entity
  if not entity then return end
  if entity.type ~= 'container' and entity.type ~= 'logistic-container' then return end
  if BLACKLIST[entity.name] then return end

  local unit = global.units[entity.unit_number]
  if unit ~= nil then
    unit.powersource.destroy()
    global.units[entity.unit_number] = nil
  end
end

local function update_power_drain()
  for ___, unit in pairs(global.units) do
    local entity = unit.entity
    local powersource = unit.powersource

    if entity.valid == false or powersource.valid == false then
      log("Unable to access invalid entity or powersource")
      goto skip
    end

    local inventory = unit.inventory
    inventory.sort_and_merge()

    local items = inventory.get_contents()
    local weight = 0
    for item, amount in pairs(items) do
      local stack_size = game.item_prototypes[item].stack_size or 50
      weight = get_weight(item) * amount / stack_size * 200
    end

    local power_usage = compute_power_usage(weight)
    powersource.power_usage = power_usage
    powersource.electric_buffer_size = power_usage

    ::skip::
  end
end

--=================================================================================================

---@type ScriptLib
local Power = {}

Power.on_init = setup
Power.on_configuration_changed = setup

Power.on_nth_tick = { 
  [60 * 5] = update_power_drain
}

Power.events = {
  -- on built
  [defines.events.on_built_entity] = on_built,
  [defines.events.on_robot_built_entity] = on_built,
  [defines.events.on_entity_cloned] = on_built,
  [defines.events.script_raised_built] = on_built,
  [defines.events.script_raised_revive] = on_built,
  -- on destroyed
  [defines.events.on_player_mined_entity] = on_destroyed,
  [defines.events.on_robot_mined_entity] = on_destroyed,
  [defines.events.on_entity_died] = on_destroyed,
  [defines.events.script_raised_destroy] = on_destroyed,
}

return Power