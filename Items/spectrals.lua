--Negative Tag and The Soul
SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "hel-negtagandsoul",
	key = "negtagandsoul",
  pools = {["Hell"] = true},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
  cost=10,
	order = 41,
	atlas = "hel_not_joker",
	can_use = function(self, card)
		if G.GAME.hel_gx_use > 0 then
            return false
        else
          return true
        end
	end,
  config = { extra = {num_hands = 1}},
	loc_vars = function(self, info_queue, card)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
	  return { vars = { card.ability.extra.num_hands } }
	end,
	use = function(self, card, area, copier)
    G.GAME.hel_gx_use = 1
    local used_tarot = card or copier
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local created_card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, "negtagandsoul")
          created_card:set_edition({negative = true}, true)
          created_card:add_to_deck()
          G.jokers:emplace(created_card)
          check_for_unlock{type = 'spawn_legendary'}
          used_tarot:juice_up(0.3, 0.5)
          return true end }))
		delay(0.6)
        ease_hands_played(-card.ability.extra.num_hands)
        return true
	end,
}

--[[the stitcher
SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "hel-stitcher",
	key = "stitcher",
  pools = {["Hell"] = true},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
  cost=10,
	order = 41,
	atlas = "hel_not_joker",
	can_use = function(self, card)
		if G.GAME.hel_gx_use == 0 and #G.jokers.cards >= 2 then
            return true
        else
          return false
        end
	end,
  config = { },
	loc_vars = function(self, info_queue, card)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
    else
      info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
    end
        
	  return { vars = {  } }
	end,
	use = function(self, card, area, copier)
    G.GAME.hel_gx_use = 1
    local used_tarot = card or copier
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('timpani')
      used_tarot:juice_up(0.3, 0.5)
      local created_card = SMODS.create_card({key="j_hel_stitched"})
      created_card.config.center:init(created_card, G.jokers.cards[1], G.jokers.cards[2])
      created_card:add_to_deck()
      G.jokers:emplace(created_card)
      return true end }))
	end,
}]]