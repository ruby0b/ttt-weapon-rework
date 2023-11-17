local en = TTT2 and "en" or "english"

local function add(k, v)
	return LANG.AddToLanguage(en, k, v)
end
local function get(k)
	return LANG.GetTranslationFromLanguage(k, en)
end

for k, v in pairs({
	fn57 = "Five-Seven",
	glock = "Glock",
	usp = "USP",
	p228 = "P228",

	mac10 = "MAC-10",
	mp5 = "MP5",
	ump = "UMP",
	p90 = "P90",
	mp7 = "MP7",

	m16 = "M4",
	ak47 = "AK-47",
	famas = "FAMAS",
	galil = "Galil",
	aug = "AUG",
	sg = "SG 552",

	scout = "Scout",
	awp = "AWP",
	g3 = "G3",
	krieg = "Krieg",
	pocket = "Pocket Rifle",
	winchester = "Winchester",

	m3 = "M3",
	xm = "XM",
	spas = "SPAS-12",
	mag7 = "MAG-7",
	boomstick = "Boom Stick",

	deagle = "Deagle",
	python = "Revolver",

	huge = "H.U.G.E-249",

	elites = "Dual Elites",
	sim16 = "Silenced M4",
	sipist = "Silenced USP",
	tmp = "TMP Prototype",
	penetrator = "X-Ray Deagle",
}) do
	add("tttwr_" .. k .. "_name", v)
end

add("ammo_pistol", "Light ammo")
add("ammo_smg1", "Medium ammo")
add("ammo_357", "Heavy ammo")
add("ammo_buckshot", "Shotgun Shells")
-- Unused:
add("ammo_alyxgun", "Magnum ammo")
add("ammo_airboatgun", "LMG ammo")

add("elites_desc", [[
Has very generous auto-aim. Deals
double damage when attacking two
targets simultaneously.

Uses standard pistol ammo.]])
add("elites_help_pri", "{primaryfire} to shoot with auto-aim")
add("elites_help_sec", "{secondaryfire} to shoot with manual aim")

add("sim16_desc", [[
M16 with a suppressor and slightly
better damage, accuracy, and recoil.
Uses assault rifle ammo.

Victims will not scream when killed.]])

add("ump_desc", get("ump_desc"):gsub("SMG ammo", "pistol ammo"))

add("penetrator_desc", [[
Deagle that can shoot through walls.
The perfect weapon for dealing with
particularly cowardly traitors.

Uses standard magnum ammo.]])

add("newton_desc", get("newton_desc"):gsub("Push people", "Push and pull people", 1))
add("newton_help_pri", "{primaryfire} to push")
add("newton_help_sec", "{secondaryfire} to pull")

add("knife_desc", get("knife_desc"):gsub("Kills wounded targets instantly", "Kills with a backstab instantly", 1))

add("decoy_toomany", "You have too many decoys planted!")
add("decoy_broken2", "Your Decoy {num} was destroyed!")
add("decoy_menutitle", "Decoy control")
add("decoy_equip_lbl1", "Toggle decoy radar signals")
add("decoy_equip_lbl2", "Choose fake DNA location")
add("decoy_equip_cbox", "Decoy {num}")
add("equip_tooltip_decoy", "Decoy control")

add("equip_buycost", "This item costs {num} credit(s).")

add("sb_tag_priotarg", "PRIORITY TARGET")
add("priotarg_show1", "Kill this target for extra credits: {targ}")
add("priotarg_show2", "Kill these targets for extra credits: {targ1} and {targ2}")
add("priotarg_show3", "Kill these targets for extra credits: {targs}")
add("priotarg_kill", "You have been rewarded {num} credit(s) for the death of {targ}")

local matdata = {
	["$basetexture"] = Material("materials/tttwr/tttwr_icons.png"):GetName(),
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$translucent"] = 1,
}

for y, v in ipairs({
	{"fn57", "glock", "usp", "p228", "elites", "deagle", "python", "penetrator",},
	{"mac10", "mp5", "ump", "p90", "tmp", "mp7",},
	{"m16", "ak47", "famas", "galil", "aug", "sg", "sim16",},
	{"scout", "awp", "g3", "krieg", "m3", "xm", "spas",},
}) do
	for x, v in ipairs(v) do
		matdata["$basetexturetransform"] = (
			"center 0 0 scale 0.125 0.25 rotate 0 translate %s %s"
		):format((x - 1) * 0.125, (y - 1) * 0.25)

		CreateMaterial("tttwr_icons/" .. v, "UnlitGeneric", matdata)
	end
end

for k, v in pairs({
	weapon_zm_pistol = "Pistol (old)",
	weapon_ttt_glock = "Glock (old)",
	weapon_ttt_m16 = "M16 (old)",
	weapon_zm_mac10 = "MAC10 (old)",
	weapon_zm_rifle = "Rifle (old)",
	weapon_zm_shotgun = "Shotgun (old)",
}) do
	weapons.GetStored(k).PrintName = v
end
