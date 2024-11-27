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
	config = { extra = { Xmult = 2.5, num_black = 2, num_red = 2, cards = 8} },
	rarity = "hel_gx",
	cost = 6,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.Xmult, center.ability.extra.num_black, center.ability.extra.num_red, center.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
              local suits = {
                 ['Red'] = 0,
                 ['Black'] = 0
             }
             for i = 1, #context.scoring_hand do
                 if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                     if context.scoring_hand[i]:is_suit('Hearts', true) or context.scoring_hand[i]:is_suit('Diamonds', true) then suits["Red"] = suits["Red"] + 1 end
                     if context.scoring_hand[i]:is_suit('Spades', true) or context.scoring_hand[i]:is_suit('Clubs', true) then suits["Black"] = suits["Black"] + 1 end
                    else 
                     if context.scoring_hand[i]:is_suit('Hearts') or context.scoring_hand[i]:is_suit('Diamonds') then suits["Red"] = suits["Red"] + 1 end
                  if context.scoring_hand[i]:is_suit('Spades') or context.scoring_hand[i]:is_suit('Clubs') then suits["Black"] = suits["Black"] + 1 end
                 end
             end
              if suits["Red"] >= card.ability.extra.num_red and
              suits["Black"] >= card.ability.extra.num_black then
                  return {
                      message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                      Xmult_mod = card.ability.extra.Xmult
                  }
              end
        end
    end,
    can_gx = function(self, card)
        return #G.hand.cards > 0
    end,
    gx = function(self, card)
        G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
        G.E_MANAGER:add_event(Event({func = function()
        for i = 1, #G.hand.cards do
            local _card = G.hand.cards[i]
            enhance_card(_card, "m_wild")
            delay(0.1)
        end return true end}))
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            G.hand:unhighlight_all() return true
        end
        }))
        delay(0.5)
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

--yaoi
SMODS.Joker { 
	object_type = "Joker",
	name = "hel-yaoi",
	key = "yaoi",
    pools = {["Hell"] = true},
	pos = { x = 3, y = 0 },
	config = { extra = { num_gay = 2, multi = 2} },
	rarity = 2,
	cost = 5,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multi, center.ability.extra.num_gay, } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local gays = 0
            for i = 1, #context.scoring_hand do
                local rank = SMODS.Ranks[context.scoring_hand[i].base.value]
                if rank.key == "King" or rank.key == "Jack" then
                    gays = gays + 1
                end
            end
            if gays >= card.ability.extra.num_gay then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.multi}},
                    Xmult_mod = card.ability.extra.multi
                }
            end
      end
    end
}

--yuri
SMODS.Joker {
	name = "hel-yuri",
	key = "yuri",
    pools = {["Hell"] = true},
	pos = { x = 4, y = 0 },
	config = { extra = { chips_per_destroy = 15, current_chips = 45} },
	rarity = 2,
	cost = 5,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips_per_destroy, center.ability.extra.current_chips, } }
	end,
	calculate = function(self, card, context)
        if context.cards_destroyed and not context.blueprint then
            local cards = 0
            for k, v in ipairs(context.glass_shattered) do
                cards = cards + 1
            end
                if cards > 0 then
                    card.ability.extra.current_chips = card.ability.extra.current_chips + cards * card.ability.extra.chips_per_destroy
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.current_chips + cards*card.ability.extra.chips_per_destroy}}})
                end
        elseif context.remove_playing_cards and not context.blueprint then
            local cards = 0
            for k, v in ipairs(context.removed) do
                cards = cards + 1
            end
            if cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.current_chips = card.ability.extra.current_chips + cards * card.ability.extra.chips_per_destroy
                      return true
                    end
                  }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.current_chips + cards*card.ability.extra.chips_per_destroy}}})
                return true
            end
        elseif context.joker_main then
            return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.current_chips}},
                    chip_mod = card.ability.extra.current_chips
                }
      end
    end
}

--smeared + flower pot
SMODS.Joker { 
	object_type = "Joker",
	name = "hel-smearflowerpot",
	key = "smearflowerpot",
    pools = {["Hell"] = true},
	pos = { x = 1, y = 0 },
	config = { extra = { Xmult = 2.5, num_black = 2, num_red = 2, cards = 8} },
	rarity = "hel_gx",
	cost = 6,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.Xmult, center.ability.extra.num_black, center.ability.extra.num_red, center.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
              local suits = {
                 ['Red'] = 0,
                 ['Black'] = 0
             }
             for i = 1, #context.scoring_hand do
                 if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                     if context.scoring_hand[i]:is_suit('Hearts', true) or context.scoring_hand[i]:is_suit('Diamonds', true) then suits["Red"] = suits["Red"] + 1 end
                     if context.scoring_hand[i]:is_suit('Spades', true) or context.scoring_hand[i]:is_suit('Clubs', true) then suits["Black"] = suits["Black"] + 1 end
                    else 
                     if context.scoring_hand[i]:is_suit('Hearts') or context.scoring_hand[i]:is_suit('Diamonds') then suits["Red"] = suits["Red"] + 1 end
                  if context.scoring_hand[i]:is_suit('Spades') or context.scoring_hand[i]:is_suit('Clubs') then suits["Black"] = suits["Black"] + 1 end
                 end
             end
              if suits["Red"] >= card.ability.extra.num_red and
              suits["Black"] >= card.ability.extra.num_black then
                  return {
                      message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                      Xmult_mod = card.ability.extra.Xmult
                  }
              end
        end
    end,
    can_gx = function(self, card)
        return #G.hand.cards > 0
    end,
    gx = function(self, card)
        G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
        G.E_MANAGER:add_event(Event({func = function()
        for i = 1, #G.hand.cards do
            local _card = G.hand.cards[i]
            enhance_card(_card, "m_wild")
            delay(0.1)
        end return true end}))
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            G.hand:unhighlight_all() return true
        end
        }))
        delay(0.5)
    end
}

--vagabond and credit card

SMODS.Joker { 
	object_type = "Joker",
	name = "hel-vagabondandcreditcard",
	key = "vagabondandcreditcard",
    pools = {["Hell"] = true},
	pos = { x = 3, y = 1 },
	config = { extra = { debt = 10, active = false, cost_per_card = 2} },
	rarity = "hel_gx",
	cost = 8,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.debt, center.ability.extra.cost_per_card} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                if G.GAME.dollars < 0 then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'vag')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    return {
                        message = localize('k_plus_tarot'),
                        card = card
                    }
                end
            end
        elseif context.individual and context.cardarea == G.play and not context.blueprint and card.ability.extra.active then
            
            if context.other_card.seal ~= "Purple" then
                G.E_MANAGER:add_event(Event({func = function() 
                    context.other_card:set_seal("Purple", true)
                    card:juice_up(0.3, 0.4)
                    context.other_card:juice_up()
                    play_sound("gold_seal", 1.2, 0.4); 
                    return true end }))
                    ease_dollars(- card.ability.extra.cost_per_card)
                end
        elseif context.end_of_round
			and not context.blueprint
			and not context.repetition
			and not context.individual
			and card.ability.extra.active then
                card.ability.extra.active = false
        end
    end,
    can_gx = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end,
    gx = function(self, card)
        card.ability.extra.active = true
        local eval = function() return card.ability.extra.active end
        juice_card_until(card, eval, true)
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
    end,
}

--[[stitched = SMODS.Joker {
	name = "hel-stitched",
	key = "stitched",
	pos = { x = 4, y = 1 },
	config = { extra = {joker1 = nil, joker2 = nil} },
	rarity = 3,
	cost = 4,
	atlas = "hel_joker",
    in_pool = false,
	loc_vars = function(self, info_queue, center)
        for key, value in pairs(center.ability.extra.joker1) do
          print(tostring(key).."="..tostring(value))
        end
        local name1, name2
        if center.ability.extra.joker1 then
            name1 = localize(center.ability.extra.joker1.label)
        else
            name1 = "???"
        end
        if center.ability.extra.joker2 then
            name2 = localize(center.ability.extra.joker2.label)
        else
            name2 = "???"
        end
		return { vars = { name1, name2 } }
	end,
    init = function(self, card, jok1, jok2)
        card.ability.extra.joker1 = jok1
        card.ability.extra.joker2 = jok2
    end,
	calculate = function(self, card, context)
        if card.ability.extra.joker1 then
            print("jok1")
            card.ability.extra.joker1.config.center:calculate(card, context)
        end
        if card.ability.extra.joker2 then
            print("jok2")
            card.ability.extra.joker2.config.center:calculate(card, context)
        end
    end
}]]

--cavendish and gros michel

SMODS.Joker {
	name = "hel-grosmichelandcavendish",
	key = "grosmichelandcavendish",
    pools = {["Hell"] = true},
	pos = { x = 2, y = 1 },
	config = { extra = { mult = 15, x_mult = 3, odds = 10000, active_x_mult = 3, active = false} },
	rarity = "hel_gx",
	cost = 10,
	atlas = "hel_joker",
    yes_pool_flag = 'gros_michel_extinct',
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.mult, center.ability.extra.x_mult, (G.GAME.probabilities.normal or 1), center.ability.extra.odds,center.ability.extra.active_x_mult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize("hel_banana_ex"),
                Xmult_mod = card.ability.extra.x_mult,
                mult_mod = card.ability.extra.mult
            }
        elseif context.individual and context.cardarea == G.play and card.ability.extra.active then
				return {
					x_mult = card.ability.extra.active_x_mult,
					colour = G.C.RED,
					card = card,
				}
        elseif context.end_of_round and not context.repetition and not context.game_over and not context.blueprint then
            if card.ability.extra.active then
                card.ability.extra.active = false
            end
            -- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
            if pseudorandom('grosmichelandcavendish') < G.GAME.probabilities.normal / card.ability.extra.odds then
              -- This part plays the animation.
              G.E_MANAGER:add_event(Event({
                func = function()
                  play_sound('tarot1')
                  card.T.r = -0.2
                  card:juice_up(0.3, 0.4)
                  card.states.drag.is = true
                  card.children.center.pinch.x = true
                  -- This part destroys the card.
                  G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                      G.jokers:remove_card(card)
                      card:remove()
                      card = nil
                      return true;
                    end
                  }))
                  return true
                end
              }))
              G.GAME.pool_flags.grosmichelandcavendish_extinct = true
              return {
                message = 'Extinct!'
              }
            else
              return {
                message = 'Safe!'
              }
            end
          end
    end,
    can_gx = function(self, card)
        return G.STATE == G.STATES.SELECTING_HAND
    end,
    gx = function(self, card)
        card.ability.extra.active = true
        local eval = function() return card.ability.extra.active end
        juice_card_until(card, eval, true)
    end
}

--walkie talkie hack

SMODS.Joker {
	name = "hel-walkiehack",
	key = "walkiehack",
    pools = {["Hell"] = true},
	pos = { x = 6, y = 0 },
	config = { extra = { chips = 4, mult = 4, copies = 4, repetitions = 1} },
	rarity = "hel_gx",
	cost = 10,
	atlas = "hel_joker",
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.copies } }
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            -- context.other_card is something that's used when either context.individual or context.repetition is true
            -- It is each card 1 by 1, but in other cases, you'd need to iterate over the scoring hand to check which cards are there.
            if context.other_card:get_id() == 4 then
              return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.repetitions,
                -- The card the repetitions are applying to is context.other_card
                card = card
              }
            end
        end
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_id() == 4 then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult,
                        card = card
                    }
                end
            end
        end
    end,
    can_gx = function(self, card)
        return #G.hand.cards > 0
    end,
    gx = function(self, card)
        for i=1,card.ability.extra.copies do
            local _suit, _rank = pseudorandom_element(SMODS.Suits, pseudoseed('hel_walkiehack')).card_key, '4'
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' and not v.overrides_base_rank then
                    cen_pool[#cen_pool + 1] = v
                end
            end
            local _card = create_playing_card({
                front = G.P_CARDS[_suit .. '_' .. _rank],
                center = pseudorandom_element(cen_pool, pseudoseed('joker_card'))}, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
            _card:set_seal(SMODS.poll_seal({guaranteed = true}), true)
            _card:set_edition(poll_edition("aura", nil, true, true), true)
        end
    end
}

--seeing double and perkeo

SMODS.Joker {
	name = "hel-seeingdoubleandperkeo",
	key = "seeingdoubleandperkeo",
    pools = {["Hell"] = true},
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 1 },
	config = { extra = { x_mult = 1.5} },
	rarity = "hel_gx",
	cost = 10,
	atlas = "hel_joker",
    yes_pool_flag = 'gros_michel_extinct',
	loc_vars = function(self, info_queue, center)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
		return { vars = { center.ability.extra.x_mult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local suits = {
                ['notClubs'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Clubs') then suits["Clubs"] = suits["Clubs"] + 1
                else
                    suits["notClubs"] = suits["notClubs"] + 1
                end
            end
            if (suits["notClubs"] > 0) and suits["Clubs"] > 0 then
                if #G.consumeables.cards > 0 then
                    local target = pseudorandom_element(G.consumeables.cards, pseudoseed('seeingdoubleandperkeo'))
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_copy = copy_card(target, nil)
                            card_copy:set_edition({negative = true}, true)
                            card_copy:add_to_deck()
                            G.consumeables:emplace(card_copy)
                            return true
                        end}))
                    card_eval_status_text(target, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.SECONDARY_SET.Spectral})
                end
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        
        end
    end,
    can_gx = function(self, card)
        return G.STATE == G.STATES.SHOP
    end,
    gx = function(self, card)
        for i = 1, #G.shop_jokers.cards do
			local c = copy_card(G.shop_jokers.cards[i],nil)
            c:set_edition({negative = true}, true)
            c:start_materialize()
            create_shop_card_ui(c)
            G.shop_jokers:emplace(c)
		end
		for i = 1, #G.shop_booster.cards do
			local c = copy_card(G.shop_booster.cards[i],nil)
            c:set_edition({negative = true}, true)
            c:start_materialize()
            create_shop_card_ui(c)
            G.shop_booster:emplace(c)
		end
    end
}