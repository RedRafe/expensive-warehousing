data:extend({
  {
		name = 'ew:exp',
		type = 'double-setting',
		setting_type = 'runtime-global',
		default_value = 1.3,
		minimum_value = 0,
		maximum_value = 100,
		order = 'a'
	},
  {
		name = 'ew:step',
		type = 'double-setting',
		setting_type = 'runtime-global',
		default_value = 2.05879/10^6,
		minimum_value = 10^-10,
		maximum_value = 10^10,
		order = 'b'
	},
  {
		name = 'ew:base',
		type = 'double-setting',
		setting_type = 'runtime-global',
		default_value = 5,
		minimum_value = 1,
		maximum_value = 100000,
		order = 'c'
	},
  {
		name = 'ew:max',
		type = 'double-setting',
		setting_type = 'runtime-global',
		default_value = 60,
		minimum_value = 0.1,
		maximum_value = 100000,
		order = 'd'
	},
})