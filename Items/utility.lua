function pseudorandom_f_range(seed, min, max)
	local val
	while not val do
		val = pseudorandom(seed) * (max - min) + min
	end
	return val
end

G.FUNCS.draw_from_discard_to_hand = function(e)
    local hand_space = e or math.min(#G.discard.cards, G.hand.config.card_limit - #G.hand.cards)
	for i=1, hand_space do --draw cards from deckL
		draw_card(G.discard,G.hand, i*100/hand_space,'up', true)
	end
end

function find_joker_rarity(rar)
	local jokers = {}
	if not G.jokers or not G.jokers.cards then return {} end
	for k, v in pairs(G.jokers.cards) do
	  if v and type(v) == 'table' and v.config.center.rarity == rar then
		table.insert(jokers, v)
	  end
	end
	return jokers
  end

  --Localization colors
local lc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		lc()
	end
	G.ARGS.LOC_COLOURS.heart = G.C.SUITS.Hearts
	G.ARGS.LOC_COLOURS.diamond = G.C.SUITS.Diamonds
	G.ARGS.LOC_COLOURS.spade = G.C.SUITS.Spades
	G.ARGS.LOC_COLOURS.club = G.C.SUITS.Clubs
	return lc(_c, _default)
end

G.FUNCS.use_gx = function(e)
	G.GAME.hel_gx_use = 1
	local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.config.center:gx(c1)
			return true
		end,
	}))
	card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize("hel_gx_ex"), colour = G.C.DARK_EDITION})
end

G.FUNCS.can_use_gx = function(e)
	local c1 = e.config.ref_table
	if G.GAME.hel_gx_use == 0 and c1.config.center:can_gx(c1) then
		e.config.colour = G.C.DARK_EDITION
        e.config.button = 'use_gx'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      	e.config.button = nil
	end
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)
	if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card.config.center.gx ~= nil then
		local gx = 
		{n=G.UIT.C, config={align = "cr"}, nodes={
		  
			{n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_use_gx'}, nodes={
			  {n=G.UIT.B, config = {w=0.1,h=0.6}},
			  {n=G.UIT.C, config={align = "tm"}, nodes={
				  {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
					  {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
				  }},
				  {n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = localize('b_hel_gx'),colour = G.C.WHITE, scale = 0.55, shadow = true}}
				  }}
			  }}
			}}
		  }}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, gx)
		return retval
	end

	return retval
end

function enhance_card(card, enhancement)
	G.E_MANAGER:add_event(Event({
		func = function()
			card:flip(); play_sound('card1', 1.15); card:juice_up(0.3,
				0.3); return true
		end
	}))
	if enhancement then
		if enhancement == "random" then
			local cen_pool = {}
			for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
			if v.key ~= 'm_stone' and not v.overrides_base_rank then
				cen_pool[#cen_pool + 1] = v
			end
			end
			enhancement = pseudorandom_element(cen_pool, pseudoseed("mtg-random_enhancement"))
		else
			enhancement = G.P_CENTERS[enhancement]
		end
		card:set_ability(enhancement, nil, true)
	end
		G.E_MANAGER:add_event(Event({
			func = function()
				card:flip(); play_sound('tarot2', 0.85, 0.6); card
					:juice_up(
						0.3, 0.3); return true
			end
		}))
end