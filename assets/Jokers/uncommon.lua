SMODS.Joker {

    key='everythingsfine',
    loc_txt = {
                name = "Big Rock",
                text = {"Gives {C:mult}+20{} Mult", "for each scored", "{C:attention}Stone Card", "{C:inactive}See guys? Everythings fi-{}"},
                unlock = {
                "Win a game on the", "{C:attention}Nebula Deck{}"
                }
            },

    config = { extra = { mult = 20 }},
    yes_pool_flag = 'cameo_appear',
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'rock',
        pos = {x = 0, y = 0},
        cost = 6,
        allow_duplicates = false,  
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_nebula'},     
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('In Stars And Time', G.C.WHITE, G.C.BLACK, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult} }
        end,



        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card.ability.effect == 'Stone Card' then --Thanks to the RE:SPH balatro mod for helping me figure this one line of code out because they basically have this card but for steels
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
}

SMODS.Joker {

    key='antimatter',
    loc_txt = {
                name = "Antimatter Joker",
                text = {"Gives {C:mult}+15{} Mult for each", "{C:attention}negative{} Joker"},
                unlock = {
                "Win a game on the", "{C:attention}Black Deck{}"
                }
            },

    config = {extra = { mult = 15 }},
    yes_pool_flag = 'enableCoker',
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'antimatter',
        pos = {x = 0, y = 0},
        cost = 8,
        allow_duplicates = false,  
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_black'},     
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('Cloker', G.C.GREEN, G.C.PURPLE, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult} }
        end,

        calculate = function(self, card, context)
 
            if context.other_joker
			and context.other_joker.edition
            and context.other_joker.edition.negative == true then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end 
        end
}
