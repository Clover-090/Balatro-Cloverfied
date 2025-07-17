
SMODS.Joker {

    key='FUCKYOUBALTIMORE',
    loc_txt = {
              name = "FUCK YOU BALTIMORE",
              text = {"If youre dumb enough to buy a new car this weekend, youre a big enough schmuck to come to Big Bill Hells Cars!", 'Bad deals! Cars that break down! Thieves!', 'If you think youre going to find a bargain at Big Bills, you can kiss my ass!', 'Its our belief that youre such a stupid motherfucker, youll fall for this bullshit—guaranteed!', 'If you find a better deal, shove it up your ugly ass!', 'You heard us right!', 'Shove it up your ugly ass!', 'Bring your trade! Bring your title! Bring your wife!', 'Well fuck her!', 'Thats right! We will fuck your wife!', 'Because at Big Bill Hells, youre fucked six ways from Sunday!', 'Take a hike to Big Bill Hells—Home of Challenge Pissing!', 'Thats right! Challenge Pissing!', 'How does it work?', 'If you can piss six feet in the air straight up and not get wet, you get no down payment!', 'Dont wait! Dont delay! Dont fuck with us, or well rip your nuts off!', 'Only at Big Bill Hells, the only dealer that tells you to fuck off!', 'Hurry up, asshole!', 'This event ends the minute after you write us a cheque, and it better not bounce or youre a dead motherfucker!', 'Go to hell—Big Bill Hells Cars!', "Baltimores filthiest and exclusive home of the meanest sons-of-bitches in the state of Maryland! guaranteed!"}
            },
    config = {extra = {}},
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = false,
        atlas = 'BIGBILL',
        pos = {x = 0, y = 0},
        cost = 0,
        allow_duplicates = true,
        
        
        set_card_type_badge = function(self, card, badges)
            badges[#badges+1] = create_badge('USELESS', G.C.RED, G.C.BLACK, 1.2 )
        end,
        loc_vars = function(self, info_queue, card)
            card = card
            card:set_eternal(true)
            
        end,
}

SMODS.Joker {
    key = 'balding',
    loc_txt = {
        name = 'Bald Spot',
        text = {
          "After each {C:attention}Boss Blind{}",
          "spawn a {C:attention}negitive hanged man{} card"
        },
        unlock = {
        'Win any stake on', '{C:attention}Checkered Deck{}'
        }
      },
    config = {extra = {}},
    yes_pool_flag = 'mokers_appear',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = 'PlaceHolder',
    pos = { x = 0, y = 0 }, 
    cost = 3,
    unlocked = false,
    unlock_condition = {type = 'win_deck', deck = 'b_checkered'},

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Moker', G.C.RED, G.C.WHITE, 1.2 )
    end,


    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and (not context.individual) and (not context.repetition) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card = create_card('Tarot', G.consumeables, nil, 0, 0, 0, 'c_hanged_man')
                    card:set_edition({negative = true}, true, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    return true
				    end
}))
end
end
}


SMODS.Joker{
    key = 'thepark',
    loc_txt = {
        name = "8s under the bridge",
        text = {"Triggers scoring played {C:attention}8{}s", "{C:attention}3{} additional times"},
        unlock = {
            "Win a game on the", "{C:attention}Yellow{} deck"
        }   
    },
    config = {extra = { repetitions = 3 }},
    yes_pool_flag = 'enableMauroker',
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'PlaceHolder',
        pos = {x = 0, y = 0},
        cost = 5,
        allow_duplicates = false,  
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_yellow'}, 

        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('Mauroker', G.C.GREEN, G.C.YELLOW, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.repetitions} }
        end,

        calculate = function(self, card, context)
            
            if context.cardarea == G.play and context.repetition and not context.repetition_only then

                if context.other_card:get_id() == 8 then
                    return {
                        message = 'Again!',
                        repetitions = card.ability.extra.repetitions,
                        
                        card = context.other_card
                    }
                end
            end
        end

}

SMODS.Joker {

    key='foolhand',
    loc_txt = {
                name = "Fool's Hand",
                text = {"For each owned {C:attention}Joker{} joker", "Give {X:mult,C:white}1.5X{} Mult"},
                unlock = {
                    "Win a game on the", "{C:attention}Ghost Deck{}"
                    }
            },

        config = {extra = {Xmult = 1.5}},
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = 'PlaceHolder',
        pos = {x = 0, y = 0},
        cost = 7,
        allow_duplicates = false,
        unlocked = false,
        unlock_condition = {type = 'win_deck', deck = 'b_ghost'},
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge('Clokers',  G.C.GREEN, G.C.PURPLE, 1.2 )
        end,

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.Xmult } }
        end,

        calculate = function(self, card, context)
 
            if context.other_joker and not card.debuff and not context.blueprint then
                if (context.other_joker.ability.name == 'Joker') then
                    return {
                        Xmult_mod = card.ability.extra.Xmult,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
                    }

            end
        end
    end

    }