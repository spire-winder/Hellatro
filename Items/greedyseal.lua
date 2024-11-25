--[[SMODS.Seal {
	name = "hel-Greedy-Seal",
	key = "greedy",
	badge_colour = HEX("59a444"),
	config = { cards_drawn = 2 },
	loc_vars = function(self, info_queue)
		return { vars = { self.config.cards_drawn } }
	end,
	atlas = "hel_misc",
	pos = { x = 0, y = 0 },
    calculate = function(self, card, context, effect)
        if context.discard or (context.cardarea == G.play and not context.repetition ) then 
            G.E_MANAGER:add_event(Event({delay = 0.1,func = function()
                G.FUNCS.draw_from_deck_to_hand(self.config.cards_drawn)
            return true end }))
        end
    end
}]]