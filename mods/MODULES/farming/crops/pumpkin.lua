
local S = farming.translate

-- pumpkin slice
minetest.register_craftitem("farming:pumpkin_slice", {
	description = S("Pumpkin Slice"),
	inventory_image = "farming_pumpkin_slice.png",
	groups = {compostability = 65, seed = 2, food_pumpkin_slice = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pumpkin_1")
	end,
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "farming:pumpkin",
	recipe = {
		{"farming:pumpkin_slice", "farming:pumpkin_slice"},
		{"farming:pumpkin_slice", "farming:pumpkin_slice"}
	}
})

local tmp = farming.use_utensils and "farming:cutting_board" or ""

minetest.register_craft({
	output = "farming:pumpkin_slice 4",
	recipe = {{"farming:pumpkin", tmp}},
	replacements = {{"farming:cutting_board", "farming:cutting_board"}}
})

-- jack 'o lantern
minetest.register_node("farming:jackolantern", {
	description = S("Jack 'O Lantern (punch to turn on and off)"),
	tiles = {
		"farming_pumpkin_bottom.png^farming_pumpkin_top.png", "farming_pumpkin_bottom.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png^farming_pumpkin_face_off.png"
	},
	paramtype2 = "facedir",
	groups = {handy = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = farming.sounds.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher)
		local name = puncher:get_player_name() or ""
		if minetest.is_protected(pos, name) then return end
		node.name = "farming:jackolantern_on"
		minetest.swap_node(pos, node)
	end
})

minetest.register_node("farming:jackolantern_on", {
	tiles = {
		"farming_pumpkin_bottom.png^farming_pumpkin_top.png", "farming_pumpkin_bottom.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png",
		"farming_pumpkin_side.png", "farming_pumpkin_side.png^farming_pumpkin_face_on.png"
	},
	light_source = minetest.LIGHT_MAX - 1,
	paramtype2 = "facedir",
	groups = {
		handy = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2,
		not_in_creative_inventory = 1
	},
	sounds = farming.sounds.node_sound_wood_defaults(),
	drop = "farming:jackolantern",
	on_punch = function(pos, node, puncher)
		local name = puncher:get_player_name() or ""
		if minetest.is_protected(pos, name) then return end
		node.name = "farming:jackolantern"
		minetest.swap_node(pos, node)
	end
})

minetest.register_craft({
	output = "farming:jackolantern",
	recipe = {
		{"default:torch"},
		{"group:food_pumpkin"}
	}
})

--- wooden scarecrow base
minetest.register_node("farming:scarecrow_bottom", {
	description = S("Scarecrow Bottom"),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
			{-12/16, 4/16, -1/16, 12/16, 2/16, 1/16},
		}
	},
	groups = {handy = 1, snappy = 3, flammable = 2}
})

minetest.register_craft({
	output = "farming:scarecrow_bottom",
	recipe = {
		{"", "group:stick", ""},
		{"group:stick", "group:stick", "group:stick"},
		{"", "group:stick", ""}
	}
})

-- pumpkin bread
minetest.register_craftitem("farming:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "farming_pumpkin_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1, flammable = 2}
})

minetest.register_craftitem("farming:pumpkin_dough", {
	description = S("Pumpkin Dough"),
	inventory_image = "farming_pumpkin_dough.png"
})

minetest.register_craft({
	output = "farming:pumpkin_dough",
	recipe = {
		{"group:food_pumpkin_slice", "group:food_flour", "group:food_pumpkin_slice"}
	}
})

minetest.register_craft({
	type = "cooking",
	output = "farming:pumpkin_bread",
	recipe = "farming:pumpkin_dough",
	cooktime = 10
})

-- pumpkin definition
local def = {
	drawtype = "plantlike",
	tiles = {"farming_pumpkin_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = farming.sounds.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:pumpkin_1", table.copy(def))

-- stage 2
def.tiles = {"farming_pumpkin_2.png"}
minetest.register_node("farming:pumpkin_2", table.copy(def))

-- stage 3
def.tiles = {"farming_pumpkin_3.png"}
minetest.register_node("farming:pumpkin_3", table.copy(def))

-- stage 4
def.tiles = {"farming_pumpkin_4.png"}
minetest.register_node("farming:pumpkin_4", table.copy(def))

-- stage 5
def.tiles = {"farming_pumpkin_5.png"}
minetest.register_node("farming:pumpkin_5", table.copy(def))

-- stage 6
def.tiles = {"farming_pumpkin_6.png"}
minetest.register_node("farming:pumpkin_6", table.copy(def))

-- stage 7
def.tiles = {"farming_pumpkin_7.png"}
minetest.register_node("farming:pumpkin_7", table.copy(def))

-- stage 8 (final)
minetest.register_node("farming:pumpkin_8", {
	description = S("Pumpkin"),
	tiles = {
		"farming_pumpkin_bottom.png^farming_pumpkin_top.png",
		"farming_pumpkin_bottom.png",
		"farming_pumpkin_side.png"
	},
	groups = {
		food_pumpkin = 1, snappy = 3, choppy = 3, oddly_breakable_by_hand = 2,
		flammable = 2, plant = 1
	},
	drop = "farming:pumpkin_8",
	sounds = farming.sounds.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_alias("farming:pumpkin", "farming:pumpkin_8")

-- add to registered_plants
farming.registered_plants["farming:pumpkin"] = {
	crop = "farming:pumpkin",
	seed = "farming:pumpkin_slice",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen
local mg = farming.mapgen == "v6"

def = {
	y_max = mg and 20 or 6,
	near = mg and "group:water" or nil,
	num = mg and 1 or -1,
}

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.pumpkin,
		spread = {x = 100, y = 100, z = 100},
		seed = 576,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1,
	y_max = def.y_max,
	decoration = "farming:pumpkin_8",
	spawn_by = def.near,
	num_spawn_by = def.num
})
