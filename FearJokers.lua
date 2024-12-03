[manifest]
version = "1.0.0"
dump_lua = true
priority = 0

# function Blind:stay_flipped (Vandalism 6/7)
[[patches]]
[patches.pattern]
target = 'blind.lua'
pattern = '''if self.name == 'The Wheel' and pseudorandom(pseudoseed('wheel')) < G.GAME.probabilities.normal/7 then'''
position = 'before'
match_indent = true
payload = '''

if G.jokers ~= nil then
    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_tma_BlindSun' and not v.debuff then
            if (pseudorandom('blindsun'..G.SEED) < G.GAME.probabilities.normal / v.ability.extra.odds) and (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND) then
                v:calculate_joker({stay_flipped = true})
                return true
            end
        end
    end
end

'''

# G.FUNCS.play_cards_from_highlighted (Vandalism 7/7)
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''--check the hand first'''
position = 'after'
match_indent = true
payload = '''

if G.jokers ~= nil then
    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_tma_BlindSun' and not v.debuff then
            v:calculate_joker({play_cards = true})
        end
    end
end

'''

# Jacks as Magic ids
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.other_card:get_id\(\) == 11'''
position = 'at'
payload = '''(context.other_card:get_id() == 11 or ((context.other_card:get_id() == 12 or context.other_card:get_id() == 13) and next(find_joker('j_tma_Boneturner'))) )'''

# Queens as Magic ids
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.other_card:get_id\(\) == 12'''
position = 'at'
payload = '''(context.other_card:get_id() == 12 or ((context.other_card:get_id() == 11 or context.other_card:get_id() == 13) and next(find_joker('j_tma_Boneturner'))))'''

# Kings as Magic ids
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.other_card:get_id\(\) == 13'''
position = 'at'
payload = '''(context.other_card:get_id() == 13 or ((context.other_card:get_id() == 12 or context.other_card:get_id() == 11) and next(find_joker('j_tma_Boneturner'))))'''

# Idol Fix
[[patches]]
[patches.pattern]
target = 'card.lua'
pattern = '''context.other_card:get_id() == G.GAME.current_round.idol_card.id'''
match_indent = true
position = 'at'
payload = '''(context.other_card:get_id() == G.GAME.current_round.idol_card.id or ((context.other_card:get_id() == 11 or context.other_card:get_id() == 12 or context.other_card:get_id() == 13) and next(find_joker('j_tma_Boneturner')) and (G.GAME.current_round.idol_card.id == 11 or G.GAME.current_round.idol_card.id == 12 or G.GAME.current_round.idol_card.id == 13) ))'''

# Mail Fix
[[patches]]
[patches.pattern]
target = 'card.lua'
pattern = '''context.other_card:get_id() == G.GAME.current_round.mail_card.id'''
match_indent = true
position = 'at'
payload = '''(context.other_card:get_id() == G.GAME.current_round.mail_card.id  or ((context.other_card:get_id() == 11 or context.other_card:get_id() == 12 or context.other_card:get_id() == 13) and next(find_joker('j_tma_Boneturner')) and (G.GAME.current_round.mail_card.id == 11 or G.GAME.current_round.mail_card.id == 12 or G.GAME.current_round.mail_card.id == 13) ))'''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.other_card:get_id\(\) == '''
position = 'at'
match_indent = true
payload = ''' ((next(SMODS.find_card('c_tma_morph')) and SMODS.find_card('c_tma_morph')[1].ability.extra.active and context.other_card.ability.effect == "Wild Card") or context.other_card:get_id() == '''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.other_card:get_id\(\) == [\w\d\s][\w\d\s]'''
position = 'after'
match_indent = true
payload = ''' )'''


# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''G\.GAME\.current_round\.mail_card\.id'''
position = 'after'
match_indent = true
payload = ''' )'''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''G\.GAME\.current_round\.idol_card\.id'''
position = 'after'
match_indent = true
payload = ''' )'''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''and \(pseudorandom\(\'8ball\'\)'''
position = 'before'
match_indent = true
payload = ''' )'''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''\(\(next\(SMODS\.find_card\('c_tma_morph'\)\) and SMODS\.find_card\('c_tma_morph'\)\[1\]\.ability\.extra\.active and context\.other_card\.ability\.effect == "Wild Card"\) or context\.other_card:get_id\(\) == 5\)'''
position = 'after'
match_indent = true
payload = ''' )'''

# All rank wild rank
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''\(\(next\(SMODS\.find_card\('c_tma_morph'\)\) and SMODS\.find_card\('c_tma_morph'\)\[1\]\.ability\.extra\.active and context\.other_card\.ability\.effect == "Wild Card"\) or context\.other_card:get_id\(\) == 10 \) or  \(\(next\(SMODS\.find_card\('c_tma_morph'\)\) and SMODS\.find_card\('c_tma_morph'\)\[1\]\.ability\.extra\.active and context\.other_card\.ability\.effect == "Wild Card"\) or context\.other_card:get_id\(\) == 4\)'''
position = 'after'
match_indent = true
payload = ''' )'''
[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''next\(find_joker\(\"Pareidolia\"\)\)'''
position = 'at'
match_indent = true
payload = ''' (next(SMODS.find_card('c_tma_morph')) and SMODS.find_card('c_tma_morph')[1].ability.extra.active) or next(find_joker("Pareidolia")) '''

[[patches]]
[patches.regex]
target = 'card.lua'
pattern = '''context\.full_hand\[1\]\:get_id\(\) == 6'''
position = 'at'
match_indent = true
payload = ''' ((next(SMODS.find_card('c_tma_morph')) and SMODS.find_card('c_tma_morph')[1].ability.extra.active and context.full_hand[1].ability.effect == "Wild Card") or context.full_hand[1]:get_id() == 6)'''

# Wildfire
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''if scoring_hand[i].ability.name == 'Glass Card' and not scoring_hand[i].debuff and pseudorandom('glass') < G.GAME.probabilities.normal/scoring_hand[i].ability.extra then'''
position = 'before'
match_indent = true
payload = '''
if scoring_hand[i].ability.name == 'Wild Card' and not scoring_hand[i].debuff and next(SMODS.find_card('j_tma_Wildfire')) then
    for _, v in ipairs(G.jokers.cards) do
        if v.config.center.key == 'j_tma_Wildfire' and not v.debuff then
            if (pseudorandom('wildfire'..G.SEED) < G.GAME.probabilities.normal / v.ability.extra.odds) then
                local wildcard = scoring_hand[i]
                if scoring_hand[i+1] then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = scoring_hand[i+1]
                    copy_card(scoring_hand[i], card)
                    card:juice_up()
                return true end }))
                end
            elseif (pseudorandom('wildfire'..G.SEED) < G.GAME.probabilities.normal / v.ability.extra.odds) then
                local wildcard = scoring_hand[i]
                if scoring_hand[i-1] then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = scoring_hand[i-1]
                    copy_card(scoring_hand[i], card)
                    card:juice_up()
                return true end }))
                end
            end
        end
    end
end'''

# Lighthhouse
[[patches]]
[patches.pattern]
target = 'card.lua'
pattern = '''if self.ability.perishable and self.ability.perish_tally <= 0 then'''
match_indent = true
position = 'before'
payload = '''
if next(SMODS.find_card('j_tma_Lighthouse')) and self.ability.effect ~= "Base" then
    self.debuff = false
    return
end
'''

# Preserve
[[patches]]
[patches.pattern]
target = 'card.lua'
pattern = '''if self.ability.perishable and self.ability.perish_tally <= 0 then'''
match_indent = true
position = 'before'
payload = '''
    if G.consumeables then
    for i=1, #G.consumeables.cards do
        if G.consumeables.cards[i].ability.name == "c_tma_preserve" and G.consumeables.cards[i].ability.extra.active then
            self.debuff = false
            return
        end
    end
    end
'''

# Last used Joker
[[patches]]
[patches.pattern]
target = 'game.lua'
pattern = '''last_tarot_planet = nil,'''
match_indent = true
position = 'before'
payload = '''
last_sold_joker = nil,
morphIsActive = false,
'''

# Statements as Jokers, main effects
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local nu_chip, nu_mult = G.GAME.selected_back:trigger_effect{context = 'final_scoring_step', chips = hand_chips, mult = mult}'''
match_indent = true
position = 'before'
payload = '''
            if G.consumeables then
            for i=1, #G.consumeables.cards do
            local _card = G.consumeables.cards[i]
            --calculate the consumeable effects
            local effects = eval_card(_card, {cardarea = G.consumeables, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, joker_main = true, callback = function(_card, ret) effects = {jokers = ret}

            --Any Joker effects
            if effects.jokers then 
                local extras = {mult = false, hand_chips = false}
                if effects.jokers.mult_mod then mult = mod_mult(mult + effects.jokers.mult_mod);extras.mult = true end
                if effects.jokers.chip_mod then hand_chips = mod_chips(hand_chips + effects.jokers.chip_mod);extras.hand_chips = true end
                if effects.jokers.Xmult_mod then mult = mod_mult(mult*effects.jokers.Xmult_mod);extras.mult = true  end
                update_hand_text({delay = 0}, {chips = extras.hand_chips and hand_chips, mult = extras.mult and mult})
                card_eval_status_text(_card, 'jokers', nil, percent, nil, effects.jokers)
                percent = percent+percent_delta
            end

            --Joker on Joker effects
            for _, v in ipairs(G.consumeables.cards) do
                local effect = v:calculate_joker{full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, other_joker = _card}
                if effect then
                    local extras = {mult = false, hand_chips = false}
                    if effect.mult_mod then mult = mod_mult(mult + effect.mult_mod);extras.mult = true end
                    if effect.chip_mod then hand_chips = mod_chips(hand_chips + effect.chip_mod);extras.hand_chips = true end
                    if effect.Xmult_mod then mult = mod_mult(mult*effect.Xmult_mod);extras.mult = true  end
                    if extras.mult or extras.hand_chips then update_hand_text({delay = 0}, {chips = extras.hand_chips and hand_chips, mult = extras.mult and mult}) end
                    if extras.mult or extras.hand_chips then card_eval_status_text(v, 'jokers', nil, percent, nil, effect) end
                    percent = percent+percent_delta
                end
            end})
            end
            end
            end
'''

# Statements as Jokers, destroying cards
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''if scoring_hand[i].ability.name == 'Glass Card' and not scoring_hand[i].debuff and pseudorandom('glass') < G.GAME.probabilities.normal/scoring_hand[i].ability.extra then '''
match_indent = true
position = 'before'
payload = '''
            if G.consumeables then
            for c = 1, #G.consumeables.cards do
                destroyed = G.consumeables.cards[c]:calculate_joker({destroying_card = scoring_hand[i], full_hand = G.play.cards})
                if destroyed then break end
            end
            end
'''


# Statements as Jokers, context.before
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local hand_text_set = false'''
match_indent = true
position = 'before'
payload = '''
        if G.consumeables then
        for c=1, #G.consumeables.cards do
            --calculate the joker effects
            local effects = eval_card(G.consumeables.cards[c], {cardarea = G.consumeables, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, before = true, callback = function(card, ret) effects = {jokers = ret}
            if effects.jokers then
                card_eval_status_text(card, 'jokers', nil, percent, nil, effects.jokers)
                percent = percent + percent_delta
                if effects.jokers.level_up then
                    level_up_hand(card, text)
                end
            end
            end})
        end
        end
'''



# Statements as Jokers, debuffed
[[patches]]
[patches.regex]
target = 'functions/state_events.lua'
pattern = '''for i\= 1, \#G\.jokers\.cards do[ \t] --calculate the joker a'''
match_indent = true
position = 'before'
payload = '''
        if G.consumeables then
        for c=1, #G.consumeables.cards do
        local effects = eval_card(G.consumeables.cards[c], {cardarea = G.consumeables, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, after = true})
        if effects.jokers then
            card_eval_status_text(card, 'jokers', nil, percent, nil, effects.jokers)
            percent = percent + percent_delta
        end
    end
    end

'''

# Statements as Jokers, end_of_round
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''if G.GAME.round_resets.ante == G.GAME.win_ante and G.GAME.blind:get_type() == 'Boss' then'''
match_indent = true
position = 'before'
payload = '''
            if G.consumeables then
            for c = 1, #G.consumeables.cards do
                local eval = nil
                eval = G.consumeables.cards[c]:calculate_joker({end_of_round = true, game_over = game_over, callback = function(card, eval)
                if eval then
                    if eval.saved then
                        game_over = false
                    end
                    card_eval_status_text(card, 'jokers', nil, nil, nil, eval)
                end
                G.consumeables.cards[c]:calculate_rental()
                G.consumeables.cards[c]:calculate_perishable()
            end})
            end
            end

'''

# Statements as Jokers, end_of_round
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local effects = {G.hand.cards[i]:get_end_of_round_effect()}'''
match_indent = true
position = 'after'
payload = '''
                        if G.consumeables then
                        for c=1, #G.consumeables.cards do
                            --calculate the joker individual card effects
                            local eval = G.consumeables.cards[c]:calculate_joker({cardarea = G.hand, other_card = G.hand.cards[i], individual = true, end_of_round = true, callback = function(card, eval, retrigger)
                            if eval then 
                                table.insert(effects, eval)
                            end
                        end
                        end

'''

# Statements as Jokers, setting_blind
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''G.GAME.blind:set_blind(G.GAME.round_resets.blind)'''
match_indent = true
position = 'after'
payload = '''
            if G.consumeables then
            for c = 1, #G.consumeables.cards do
                G.consumeables.cards[c]:calculate_joker({setting_blind = true, blind = G.GAME.round_resets.blind})
            end
            end

'''
# Statements as Jokers, discards
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local removed = false'''
match_indent = true
position = 'after'
payload = '''
            if G.consumeables then
            for c = 1, #G.consumeables.cards do
                local eval = nil
                eval = G.consumeables.cards[c]:calculate_joker({discard = true, other_card =  G.hand.highlighted[i], full_hand = G.hand.highlighted, callback = function(card, eval, retrigger)
                if eval then
                    if eval.remove then removed = true end
                    card_eval_status_text(card, 'jokers', nil, 1, nil, eval)
                end
            end})
            end
            end

'''
# Statements as Jokers, retriggers
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''for j=1,#reps do'''
match_indent = true
position = 'before'
payload = '''
            if G.consumeables then
                for c=1, #G.consumeables.cards do
                    --calculate the joker effects
                    local eval = eval_card(G.consumeables.cards[c], {cardarea = G.play, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, other_card = scoring_hand[i], repetition = true, callback = function(card, ret) eval = {jokers = ret}
                    if next(eval) and eval.jokers then 
                        for h = 1, eval.jokers.repetitions do
                            reps[#reps+1] = eval
                        end
                    end
                end
            end
'''
# Statements as Jokers, removing
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''for i=1, #G.jokers.cards + #G.consumeables.cards do'''
match_indent = true
position = 'at'
payload = '''for i=1, #G.jokers.cards do

'''
# Statements as Jokers, removing
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local _card = G.jokers.cards[i] or G.consumeables.cards[i - #G.jokers.cards]'''
match_indent = true
position = 'at'
payload = '''local _card = G.jokers.cards[i]

'''
# Statements as Jokers, common event
[[patches]]
[patches.pattern]
target = 'functions/common_events.lua'
pattern = '''if context.cardarea == G.jokers or context.card == G.consumeables then'''
match_indent = true
position = 'at'
payload = '''

    if card.edition and card.edition.key then
        local ed = SMODS.Centers[card.edition.key]
        if ed.calculate and type(ed.calculate) == 'function' then
            context.from_playing_card = true
            ed:calculate(card, context)
            context.from_playing_card = nil
        end
    end
    if not enhancement_calculated and card.ability.set == 'Enhanced' and center.calculate and type(center.calculate) == 'function' then 
        center:calculate(card, context, ret)
        enhancement_calculated = true
    end
    local seals = card:calculate_seal(context)
    if seals then
        ret.seals = seals
    end
    if context.cardarea == G.jokers or context.cardarea == G.consumeables then

'''

# Statements as Jokers, indiv card
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''local effects = {eval_card(G.hand.cards[i], {cardarea = G.hand, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands})}'''
match_indent = true
position = 'after'
payload = '''
                if G.consumeables then
                for c=1, #G.consumeables.cards do
                        --calculate the joker individual card effects
                        local eval = G.consumeables.cards[c]:calculate_joker({cardarea = G.hand, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, other_card = G.hand.cards[i], individual = true, callback = function(card, eval, retrigger)
                        if eval then 
                            mod_percent = true
                            table.insert(effects, eval)
                        end
                    end
                    end

'''
# Statements as Jokers, 
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''scoring_hand[i].lucky_trigger = nil'''
match_indent = true
position = 'before'
payload = '''
                if G.consumeables then
                for k=1, #G.consumeables.cards do
                        --calculate the joker individual card effects
                        local eval = G.consumeables.cards[k]:calculate_joker({cardarea = G.play, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, other_card = scoring_hand[i], individual = true, callback = function(card, eval, retrigger)
                        if eval then 
                            table.insert(effects, eval)
                        end
                    end
                    end

'''

# Statements as Jokers, 
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''destroyed = G.jokers.cards[j]:calculate_joker({destroying_card = scoring_hand[i], full_hand = G.play.cards})'''
match_indent = true
position = 'after'
payload = '''
                if destroyed then break end
            end
            if G.consumeables then
            for j = 1, #G.consumeables.cards do
                destroyed = G.consumeables.cards[j]:calculate_joker({destroying_card = scoring_hand[i], full_hand = G.play.cards, callback = function(card, ret) if ret then destroyed=true end end})
                end
'''

# Indulgence discards
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = '''ease_discard(-1)'''
match_indent = true
position = 'at'
payload = '''
        local freediscard = false
        if G.consumeables then
        for i=1, #G.consumeables.cards do
            if G.consumeables.cards[i].ability.name == "c_tma_indulgence" and G.consumeables.cards[i].ability.extra.active and G.GAME.current_round.discards_left <= 0 then
                ease_dollars(-G.consumeables.cards[i].ability.extra.cost)
                freediscard = true
                break
            end
        end
        end
        if not freediscard then
            ease_discard(-1)
        end
'''

# static draw from play to discard
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = "draw_card(G.play,G.discard, it*100/play_count,'down', false, v)"
position = 'at'
match_indent = true
payload = '''

local cards_to_hand = {}

if G.consumeables ~= nil then
    for _, c in ipairs(G.consumeables.cards) do
        if c.config.center.key == 'c_tma_static' and c.ability.extra.active and not c.debuff then
            for __, card in ipairs(c.ability.extra.cards_to_hand) do
                table.insert(cards_to_hand, card)
            end
            break
        end
    end
end

if cards_to_hand ~= {} then
    local condition = false
    for _, card_to_hand in ipairs(cards_to_hand) do
        if v == card_to_hand then
            condition = true
        end
    end
    if condition then
        draw_card(G.play,G.hand, it*100/play_count,'up', true, v)
    else
        draw_card(G.play,G.discard, it*100/play_count,'down', false, v)
    end
else
    draw_card(G.play,G.discard, it*100/play_count,'down', false, v)
end

'''

# G.FUNCS.play_cards_from_highlighted() (Cellphone 2/2)
[[patches]]
[patches.pattern]
target = 'functions/state_events.lua'
pattern = "inc_career_stat('c_hands_played', 1)"
position = 'after'
match_indent = true
payload = '''

if G.consumeables ~= nil then
    for _, v in ipairs(G.consumeables.cards) do
        if v.config.center.key == 'c_tma_static' and v.ability.extra.active and not v.debuff then
            v:calculate_joker({press_play = true})
            break
        end
    end
end

'''
