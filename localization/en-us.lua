return {
    descriptions = {
        Joker = {
            j_hel_grunch = {
                name = "Grunch",
                text = {
                    "He will show you",
                    "how to {C:attention}Grunch{}"
                },
            },
            j_hel_yaoi = {
                name = "Yaoi",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if poker hand contains at least",
                    "{C:attention}#2#{} {C:attention}Jacks{} and/or {C:attention}Kings{}"
                },
            },
            j_hel_smearflowerpot = {
                name = "{C:dark_edition}Smeared Joker and Flower Pot TAG TEAM GX{}",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if poker hand contains at least",
                    "{C:attention}#2#{} {C:spade}Black{} cards and {C:attention}#3#{} {C:heart}Red{} cards",
                    "{C:dark_edition}GX{}: {C:attention}Enhances all{} cards in hand into {C:attention}Wild Cards{}"
                },
            },
            j_hel_gxtest = {
                name = "{C:dark_edition}GX TEST{}",
                text = {
                    "{X:mult,C:white}X#1#{} Mult"
                },
            },
            j_hel_colossaldreadmaw = {
                name = "Colossal Dreadmaw",
                text = {
                    "Played {C:attention}6s{} give {C:chips}+#1#{} Chips",
                    "and {C:mult}+#2#{} Mult when scored",
                    "{C:green}Trample{}",
                    "{C:inactive}(Currently trampling over for {C:attention}#3#{} {C:inactive}Chips){}"
                },
            },
            j_hel_toaster = {
                name = "Toaster on Theros",
                text = {
                   "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "when exactly {C:attention}#3#{} cards are discarded",
                    "{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
                },
            }
        },
        Spectral = {
            c_hel_negtagandsoul = {
                name = "{C:dark_edition}Negative Tag and The Soul TAG TEAM GX{}",
                text = {
                    "Gain a random {C:dark_edition}Negative{} {C:legendary}Legendary{} {C:attention}Joker{}",
                    "{C:red}-#1#{} Hands permanently"
                },
            },
        },
        Magic = {
            c_hel_onewithnothing = {
                name = "One with Nothing",
                text = {
                    "Discard your hand"
                },
            }
        },
        Voucher = {
            v_hel_blanktrio = {
                name = "{C:dark_edition}Blank, Blank, and Blank TAG TEAM GX{}",
                text = {
                    "{C:dark_edition}+1{} Joker Slot",
                },
            },
        },
        Other = {
            r_hel_trample = {
                name = "Trample",
                text = {
                    "Excess chips carry","over between blinds"
                }
            },
            r_hel_gx_rule_used = {
                name = "GX Rule",
                text = {
                    "You have already used ",
                    "your {C:dark_edition}GX{} {C:attention}Effect{}",
                    "this run"
                }
            },
            r_hel_gx_rule_unused = {
                name = "GX Rule",
                text = {
                    "You can only use",
                    "one {C:dark_edition}GX{} {C:attention}Effect{}",
                    "per run"
                }
            },
            p_hel_magic_fallen_empires = {
                name = "Fallen Empires",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_hel_magic_arb = {
                name = "Arabian Nights",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_hel_magic_mb2 = {
                name = "Mystery Booster 2",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_hel_magic_p3k = {
                name = "Portal Three Kingdoms",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            hel_greedy_seal = {
                name = "Greedy Seal",
                text = {
                    "Draw {C:attention}#1#{} cards when","this card is played and scored or discarded",
                },
            },
        }
    },
    misc = {
        dictionary = {
            k_hel_hell_pack = "Hell Pack",
            k_hel_gx = "GX",

            hel_grunch_ex = "Grunch!",
            hel_trample_ex = "Trample!",
            b_take = "TAKE",
            b_hel_gx = "GX",
        },
        labels = {
            hel_greedy_seal = "Greedy Seal",
            k_hel_gx = "GX",
        },
        v_dictionary = {
            a_xchips = {"X#1# Chips"},
            a_powmult = {"^#1# Mult"},
            a_powchips = {"^#1# Chips"},
            a_powmultchips = {"^#1# Mult+Chips"},
            a_round = {"+#1# Round"},
            a_candy = {"+#1# Candy"},
            a_xchips_minus = {"-X#1# Chips"},
            a_powmult_minus = {"-^#1# Mult"},
            a_powchips_minus = {"-^#1# Chips"},
            a_powmultchips_minus = {"-^#1# Mult+Chips"},
            a_round_minus = {"-#1# Round"},

            a_tag = {"#1# Tag"},
            a_tags = {"#1# Tags"},
        }
    }
}
