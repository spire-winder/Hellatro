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
	G.ARGS.LOC_COLOURS.hel_ascendant = G.C.HEL_ASCENDANT
	return lc(_c, _default)
end