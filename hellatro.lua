
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({
	key = "hel_joker",
	path = "hel_joker_atlas.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "hel_not_joker",
	path = "hel_not_joker_atlas.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	object_type = "Atlas",
	key = "hel_pack",
	path = "hel_pack.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "hel_misc",
	path = "hel_misc.png",
	px = 71,
	py = 95,
})

SMODS.Rarity{
    key = "gx",
    badge_colour = HEX('9d03fc'),
    default_weight = 0.003,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return 0.05
    end,
}


SMODS.load_file("items/utility.lua")()
SMODS.load_file("items/jokers.lua")()
SMODS.load_file("items/spectrals.lua")()
SMODS.load_file("items/vouchers.lua")()
SMODS.load_file("items/pack.lua")()
if SMODS.Mods["magic-the-jokering"] then
	SMODS.load_file("items/magic.lua")()
end
SMODS.load_file("items/greedyseal.lua")()