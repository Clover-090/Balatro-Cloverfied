

SMODS.Joker {

    key = 'Mattleg',
    
    loc_txt = {
                name = 'G. Histrio',
                text = {"{C:attention}Go Fish!{}", "{C:inactive} Draws a {C:attention}secret hand{}{C:inactive} every round", "{C:inactive}If you play any cards from the secret hand",
                "{C:inactive}Gain{C:attention} $5{}{C:inactive} per card",},
                unlock = {
                'Win any stake on', '{C:attention}Checkered Deck{}'
                }
            },

        config = {extra = { money = 10, r1 = 1, r2 =2, r3 =3, r4 = 4, r5 = 5 }},
        yes_pool_flag = 'enableMoker',
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'historio',
        pos = {x = 0, y = 0},
        soul_pos = {x = 1, y = 0},
        cost = 20,
        allow_duplicates = false,
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_checkered'},
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('Moker', G.C.RED, G.C.WHITE, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.money } }
        end,

        calculate = function(self, card, context)
                    
                    if context.ending_shop then

                        r1 = math.random(1, 14)
                        r2 = math.random(1, 14)
                        r3 = math.random(1, 14)
                        r4 = math.random(1, 14)
                        r5 = math.random(1, 14)

                        print('This one is for all the debug plus heads out there! ' ..r1.. ' ' ..r2.. ' ' ..r3.. ' ' ..r4.. ' ' ..r5 )
                    end

                    if context.individual and context.cardarea == G.play then
                        if context.other_card:get_id() == r1 or context.other_card:get_id() == r2 or context.other_card:get_id() == r3 or context.other_card:get_id() == r4 or context.other_card:get_id() == r5 then
                            ease_dollars(card.ability.extra.money)
                            end
                        end
                end
}

SMODS.Joker { 

    key='sifleg',
    loc_txt = {
                name = "Perdu Un",
                text = {"For each card that is {C:attention}retriggered{}", "add {X:mult,C:white}0.1X{} Mult", 
                "{C:inactive}Currently {X:mult,C:white}X#1# {C:inactive} Mult"},
                unlock = {
                "Win a game on the", "{C:attention}Nebula Deck{}"
                }
            },

    config = {extra = {Xmult = 1, Xmult_gain = 0.1}},
    yes_pool_flag = 'cameo_appear',
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'sifleg',
        pos = {x = 1, y = 0},
        soul_pos={x=0,y=0},
        cost = 10,
        allow_duplicates = false,  
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_nebula'},     
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('In Stars and Time', G.C.WHITE, G.C.BLACK, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
        end,
    
        
        calculate = function(self, card, context)
            if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
            }
            end 
            if context.repetition then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                                return {
                                    message = 'Upgraded!',
                                    colour = G.C.Xmult,
                                    card = self
                                    }
                                end
                            end
}


