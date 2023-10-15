--- @param player_index uint
--- @param gui_type defines.gui_type
--- @param entity LuaEntity
--- @param item LuaItemStack
--- @param equipment LuaEquipment
--- @param other_player LuaPlayer
--- @param element LuaGuiElement
--- @param inventory LuaInventory
--- @param name defines.events.on_gui_opened
--- @param tick uint
local function sort_inventory(e)
  local player = game.get_player(e.player_index)
  local entity = e.entity

  if not player or not player.valid then return end
  if not entity or not entity.valid then return end

  local inventory = entity.get_inventory(defines.inventory.chest)
  if not inventory or not inventory.valid then return end

  inventory.sort_and_merge()
end

--=================================================================================================

---@type ScriptLib
local Sorter = {}

Sorter.events = {
  [defines.events.on_gui_opened] = sort_inventory,
}

return Sorter