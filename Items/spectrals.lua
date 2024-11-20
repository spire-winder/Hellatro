--Negative Tag and The Soul
SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "hel-negtagandsoul",
	key = "negtagandsoul",
    pools = {["Hell"] = true},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	hidden = true,
  cost=10,
	soul_set = "Tarot",
	order = 41,
	atlas = "hel_not_joker",
	can_use = function(self, card)
		return true
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
        if G.GAME.hel_gx_use > 0 then
			card:start_dissolve()
            return true
        else
            G.GAME.hel_gx_use = 1
        end
    local used_tarot = card or copier
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local created_card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, "negtagandsoul")
          created_card:set_edition({negative = true}, true)
          created_card:add_to_deck()
          G.jokers:emplace(created_card)
          if card.ability.name == 'The Soul' then check_for_unlock{type = 'spawn_legendary'} end
          used_tarot:juice_up(0.3, 0.5)
          return true end }))
		delay(0.6)
        ease_hands_played(-card.ability.extra.num_hands)
        return true
	end,
}