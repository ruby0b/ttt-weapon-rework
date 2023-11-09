local en = TTT2 and "en" or "english"

local function add(k, v)
	return LANG.AddToLanguage(en, k, v)
end

add("item_armor_desc", [[
Reduces bullet damage.

Depletes over time.]])

-- spelling fixes and added a newline
add("ttt2_weapon_boom_body_desc", [[
The boom body is a fake corpse that explodes if a player tries to search it.
You and your team mates know that it is a boom body.]])

-- add "(inactive)" for clarity
add("identity_disguiser_hud", "{name} (inactive)")

local function role(name, v) return LANG.AddToLanguage(en, "chat_info_" .. name, v) end

role("traitor", [[
Team: Traitor
Press C to access the Traitor shop.
]])
role(HAUNTED.name, [[
Team: Traitor
You respawn when your killer dies.
Press C to access the Traitor shop.
]])
role(HITMAN.name, [[
Team: Traitor
Kill your current target to get more credits.
Press C to access the Traitor shop.
]])
role(ACCOMPLICE.name, [[
Team: Traitor
You don't know who your fellow Traitors are.
But the Traitors know that you're their Accomplice.
Try to find them without exposing yourself!
]])
role("innocent", [[
Team: Innocent
]])
role("detective", [[
Team: Innocent
Everyone knows that you're on team Innocent.
Press C to access the Detective shop.
]])
role(LYCANTHROPE.name, [[
Team: Innocent
You get stronger if you are the only Innocent left.
]])
role(PURE.name, [[
Team: Innocent
Your killer gets blinded for a few seconds.
As long as you haven't killed anyone yourself...
]])
role(SURVIVALIST.name, [[
Team: Innocent
Press C to access a special shop.
]])
role(SPIRIT.name, [[
Team: Innocent
Your ghost becomes visible once your corpse is identified.
]])
