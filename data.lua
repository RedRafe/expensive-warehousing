data:extend{
	{
    name = 'ew-storage-power',
		type = 'electric-energy-interface',
		localised_name = {'entity-name.ew-storage-power'},
		localised_description = {'entity-description.ew-storage-power'},
		energy_source = {
			type = 'electric',
			usage_priority = 'secondary-input',
			buffer_capacity = '1J'
		},
		energy_usage = '1W',
		order = 'z',
		collision_box = {{-2.7, -2.7}, {2.7, 2.7}},
		icon = '__expensive-warehousing__/graphics/power.png',
		icon_size = 64,
		icon_mipmaps = 1,
		collision_mask = {},
		selectable_in_game = false,
		remove_decoratives = 'false',
		flags = {'placeable-player', 'placeable-neutral', 'hidden', 'not-selectable-in-game', 'not-blueprintable', 'not-deconstructable', 'not-flammable', 'not-upgradable'}
	}
}