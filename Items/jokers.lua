SMODS.Joker { 
	object_type = "Joker",
	name = "hel-grunch",
	key = "grunch",
    pools = {["Hell"] = true},
	pos = { x = 0, y = 0 },
	config = { extra = { min_Xmult = 0.8, max_Xmult = 2, min_chips = 10, max_chips = 100} },
	rarity = 1,
	cost = 5,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.min_Xmult, center.ability.extra.max_Xmult, center.ability.extra.min_chips, center.ability.extra.max_chips } }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local temp_XMult = pseudorandom_f_range(pseudoseed('grunch'), card.ability.extra.min_Xmult, card.ability.extra.max_Xmult)
      local temp_Chips = pseudorandom_f_range(pseudoseed('grunch'), card.ability.extra.min_chips, card.ability.extra.max_chips)
      return {
        chip_mod = temp_Chips,
        Xmult_mod = temp_XMult,
        message = localize("hel_grunch_ex")
      }
		end
	end
}

SMODS.Joker { 
	object_type = "Joker",
	name = "hel-smearflowerpot",
	key = "smearflowerpot",
    pools = {["Hell"] = true},
	pos = { x = 1, y = 0 },
	config = { extra = { Xmult = 5, num_black = 2, num_red = 2} },
	rarity = "hel_gx",
	cost = 10,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.Xmult, center.ability.extra.num_black, center.ability.extra.num_red } }
	end,
    add_to_deck = function(self, card, from_debuff)
		if G.GAME.hel_gx_use > 0 then
			card:start_dissolve()
        else
            G.GAME.hel_gx_use = 1
        end
	end,
	calculate = function(self, card, context)
        if context.joker_main then
              local suits = {
                 ['Hearts'] = 0,
                 ['Spades'] = 0
             }
             for i = 1, #context.scoring_hand do
                 if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                     if context.scoring_hand[i]:is_suit('Hearts', true) then suits["Hearts"] = suits["Hearts"] + 1
                     elseif context.scoring_hand[i]:is_suit('Spades', true) then suits["Spades"] = suits["Spades"] + 1 end
                    else 
                     if context.scoring_hand[i]:is_suit('Hearts') then suits["Hearts"] = suits["Hearts"] + 1
                  elseif context.scoring_hand[i]:is_suit('Spades') then suits["Spades"] = suits["Spades"] + 1 end
                 end
             end
              if suits["Hearts"] >= card.ability.extra.num_red and
              suits["Spades"] >= card.ability.extra.num_black then
                  return {
                      message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                      Xmult_mod = card.ability.extra.Xmult
                  }
              end
        end
    end
}

SMODS.Joker { 
	object_type = "Joker",
	name = "hel-gxtest",
	key = "gxtest",
    pools = {["Hell"] = true},
	pos = { x = 2, y = 0 },
	config = { extra = { Xmult = 3} },
	rarity = "hel_gx",
	cost = 10,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.Xmult } }
	end,
    add_to_deck = function(self, card, from_debuff)
		if G.GAME.hel_gx_use > 0 then
			card:start_dissolve()
        else
            G.GAME.hel_gx_use = 1
        end
	end,
	calculate = function(self, card, context)
        if context.joker_main then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
    end
}

SMODS.Joker { 
	object_type = "Joker",
	name = "hel-toaster",
	key = "toaster",
    pools = {["Hell"] = true},
	pos = { x = 1, y = 1 },
	config = { extra = { Xmult_current = 1, Xmult_modifier = 0.1, num_discarded = 2} },
	rarity = 3,
	cost = 10,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult_current, center.ability.extra.Xmult_modifier, center.ability.extra.num_discarded } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult_current}},
                Xmult_mod = card.ability.extra.Xmult_current
            }
        end
        if context.pre_discard then
            if #context.full_hand == card.ability.extra.num_discarded then
                card.ability.extra.Xmult_current = card.ability.extra.Xmult_current + card.ability.extra.Xmult_modifier
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker { 
	object_type = "Joker",
	name = "hel-colossaldreadmaw",
	key = "colossaldreadmaw",
    pools = {["Hell"] = true},
	pos = { x = 0, y = 1 },
	config = { extra = { chips = 6, mult = 6} },
	rarity = 1,
	cost = 6,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { key = "r_hel_trample", set = "Other", config = { extra = 1 } }
		return { vars = { center.ability.extra.chips, center.ability.extra.mult, G.GAME.hel_trample_value} }
	end,
	calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_id() == 6 then
                        return {
                            chips = card.ability.extra.chips,
                            mult = card.ability.extra.mult,
                            card = card
                        }
                    end
            end
        end
    end
}