--config menu start

local clov_config = SMODS.current_mod.config
-- Code Borrowed From Cardsauce mod
clov_enabled = copy_table(clov_config)

local function config_matching()
	for k, v in pairs(clov_enabled) do
		if v ~= clov_config[k] then
			return false
		end
	end
	return true
end


function G.FUNCS.clov_restart()
	if config_matching() then
		SMODS.full_restart = 0
	else
		SMODS.full_restart = 1
	end
end

local start = Game.start_run
function Game:start_run(args)
	start(self, args)
	if clov_enabled['enableMoker'] then
        G.GAME.pool_flags.mokers_appear = true
    else
        G.GAME.pool_flags.mokers_appear = false
    end

    if clov_enabled['enableLoker'] then
        G.GAME.pool_flags.lokers_appear = true
    else
        G.GAME.pool_flags.lokers_appear = false
    end

    if clov_enabled['enableCameo'] then
        G.GAME.pool_flags.cameo_appear = true
    else
        G.GAME.pool_flags.cameo_appear = false
    end

    if clov_enabled['enableCoker'] then
        G.GAME.pool_flags.coker_appear = true
    else
        G.GAME.pool_flags.coker_appear = false
    end

    if clov_enabled['enableMauroker'] then
        G.GAME.pool_flags.maurokers_appear = true
    else
        G.GAME.pool_flags.maurokers_appear = false
    end
end  

SMODS.current_mod.config_tab = function()
	local ordered_config = {
		'enableMoker',
		'enableLoker',
		'enableCameo',
        'enableCoker',
        'enableMauroker'

	}
	local left_settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
	local right_settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
	for i, k in ipairs(ordered_config) do
		if #right_settings.nodes < #left_settings.nodes then
			right_settings.nodes[#right_settings.nodes + 1] = create_toggle({ label = localize("clov_options_"..ordered_config[i]), ref_table = clov_config, ref_value = ordered_config[i], callback = G.FUNCS.clov_restart})
		else
			left_settings.nodes[#left_settings.nodes + 1] = create_toggle({ label = localize("clov_options_"..ordered_config[i]), ref_table = clov_config, ref_value = ordered_config[i], callback = G.FUNCS.clov_restart})
		end
	end
	local clov_config_ui = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.05,
			colour = G.C.BLACK,
		},
		nodes = {
			clov_config_ui
		}
	}
    end



--Atlas defs start 
SMODS.Atlas {
    key = "PlaceHolder",
    path = "PlaceHolder.png",
    px = 71,
    py = 95
}


SMODS.Atlas {
    key = "BIGBILL",
    path = "BIGBILL.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Addictive",
    path = "Addictive.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "rock",
    path = "Rock.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "sifleg",
    path = "PERDUUN.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "antimatter",
    path = "AntimaterJ.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "historio",
    path = "G_histrio.png",
    px = 71,
    py = 95

}


--Atlas defs end  




--jokers begin
SMODS.Joker {
    key = 'lodog',
    loc_txt = {
        name = 'Unfortunatly Placed Dog',
        text = {
          "Gains {C:mult}+10 Mult",
          "For each face card within",
          "a {C:attention}Two Pair{}",
          "{C:inactive}(Currently {C:mult}+#1# {C:inactive} Mult)",
          "{C:inactive} Get them some Spare Trousers!"
        },
        unlock = {
            'Win any stake on', '{C:attention}Plasma Deck{}'
        }
      },

    config = { extra = { mult = 0, mult_gain = 10}},
    yes_pool_flag = 'lokers_appear',
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'PlaceHolder', --Add Correct Atlas once sprite is finished
    pos = { x = 0, y = 0 }, 
    cost = 8,
    unlocked = false,
    unlock_condition = {type = 'win_deck', deck = 'b_plasma'},

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Loker', G.C.WHITE, G.C.RED, 1.2 )
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
          return {
            mult_mod = card.ability.extra.mult,
            message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
          }
        end 
    
        
        if context.scoring_name == "Two Pair" and not context.blueprint then --checks to see what hand is being scored and makes sure blueprint or brainstorm wont copy upgrade
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_face() then --checks to see if there are face cards
                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain --scales mult
                            return {
                                message = 'Upgraded!',
                                colour = G.C.Mult,
                                card = card
                            }
                        end
                    end
                end
            end

}

SMODS.Joker {
    key = 'Hypothetical',
    loc_txt = {
        name = 'Hypothetical Joker',
        text = {
          "After each {C:attention}Boss Blind{}",
          "spawn a {C:attention}negitive hanged man{} card" --This will change to a custom card once I'm more knowlegeable of LUA
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




SMODS.Joker {

    key = 'addictive',
    loc_txt = {
        name = 'Addictive Joker',
        text = {
          "gains {X:mult,C:white}X0.1{} Mult for each {C:attention}Straight{} played.",
          "{C:inactive}Currently {X:mult,C:white}X#1# {C:inactive} Mult",
          "{C:inactive}Played more than 9 hours straight"
        },
        unlock = {
        "Win any stake on", "{C:attention}Plasma Deck{}"
        }
      },

    config = {extra = {Xmult = 1, Xmult_gain = 0.1}},
    yes_pool_flag = 'lokers_appear',
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    atlas = 'Addictive',
    pos = {x = 0, y = 0},
    cost = 5,
    unlocked = false,
    unlock_condition = {type = 'win_deck', deck = 'b_plasma'},

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Loker', G.C.WHITE, G.C.RED, 1.2 )
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

        if context.before and next(context.poker_hands['Straight']) and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain --scales XMult
                                return {
                                    message = 'Upgraded!',
                                    colour = G.C.Xmult,
                                    card = card
                                    }
                                end
                            end
}


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

    key = 'Mattleg',
    
    loc_txt = {
                name = 'G. Histrio',
                text = {"Draws a {C:attention}secret hand{} every round", "If you play any cards from the secret hand",
                " Gain{C:attention} $5{}",},
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