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



    SMODS.load_file("assets/Jokers/Jatlas.lua")()

    SMODS.load_file("assets/Jokers/common.lua")()
    SMODS.load_file("assets/Jokers/uncommon.lua")()
    SMODS.load_file("assets/Jokers/rare.lua")()
    SMODS.load_file("assets/Jokers/legendary.lua")()