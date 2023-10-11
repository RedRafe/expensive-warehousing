local items = {
  -- raws
  ['coal'] = 20,
  ['compact-raw-rare-metals'] = 20,
  ['copper-ore'] = 20,
  ['iron-ore'] = 20,
  ['raw-imersite'] = 20,
  ['raw-rare-metals'] = 20,
  ['stone'] = 20,
  ['uranium-ore'] = 20,
  ['wood'] = 20,
  -- processed
  ['coke'] = 5,
  ['enriched-copper'] = 5,
  ['enriched-iron'] = 5,
  ['enriched-rare-metals'] = 5,
  ['fluoride'] = 5,
  ['imersite-crystal'] = 5,
  ['imersite-powder'] = 5,
  ['lithium-chloride'] = 5,
  ['lithium'] = 5,
  ['quartz'] = 5,
  ['sand'] = 5,
  ['silicon'] = 5,
  ['solid-fuel'] = 5,
  ['sulfur'] = 5,
  ['yellowcake'] = 5,
  -- plates
  ['copper-plate'] = 10,
  ['glass'] = 10,
  ['imersium-plate'] = 10,
  ['iron-plate'] = 10,
  ['plastic-bar'] = 10,
  ['rare-metals'] = 10,
  ['steel-plate'] = 10,
  ['stone-brick'] = 10,
  -- intermediates
  ['electronic-components'] = 2,
  ['electronic-circuit'] = 2,
  ['advanced-circuit'] = 2,
  ['processing-unit'] = 2,
}


if script.active_mods['deadlock-beltboxes-loaders'] then
  local stack_size = settings.startup['deadlock-stack-size'].value or 10
  local new_items = {}
  -- double loop to avoid infinite combo
  for item, weight in pairs(items) do
    new_items['deadlock-stack-' .. item] = weight * stack_size
  end

  for k, v in pairs(new_items) do
    items[k] = v
  end
end

return items