SMODS.Voucher {
	object_type = "Voucher",
	key = "blanktrio",
	atlas = "hel_not_joker",
	order = 3,
	pos = { x = 1, y = 0 },
    config = { },
	loc_vars = function(self, info_queue, card)
		if G.GAME.hel_gx_use > 0 then
			info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_used", set = "Other", config = { extra = 1 } }
        else
            info_queue[#info_queue + 1] = { key = "r_hel_gx_rule_unused", set = "Other", config = { extra = 1 } }
        end
        
	  return { vars = {} }
	end,
	redeem = function(self)
        if G.GAME.hel_gx_use > 0 then
            return true
        else
            G.GAME.hel_gx_use = 1
        end
		G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
            return true end }))
	end,
	unredeem = function(self)
        if G.GAME.hel_gx_use > 0 then
            G.GAME.hel_gx_use = 0
        end
		G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            end
            return true end }))
	end,
}