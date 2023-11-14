if engine.ActiveGamemode() ~= "terrortown" or TTTWR == false then
	return
end

local function noreg(data)
	if data.TTTWR_DISABLED then
		return false
	end
end

hook.Add("PreRegisterSENT", "tttwr_PreRegisterSENT", noreg)
hook.Add("PreRegisterSWEP", "tttwr_PreRegisterSWEP", noreg)

TTTWR = {
	fns = TTTWR and TTTWR.fns or {},
	weakkeys = {__mode = "k"},
	sounds = {},
}

local included = {}

local function incl(name, cl)
	name = "tttwr/"
		.. (cl and "cl_" or cl == false and "sv_" or "sh_")
		.. name
		.. ".lua"

	if cl ~= false and SERVER then
		AddCSLuaFile(name)
	end

	if not cl or CLIENT then
		local fn = include(name)

		if isfunction(fn) then
			included[#included + 1] = fn
		end
	end
end

local function PostGamemodeLoaded()
	PostGamemodeLoaded = nil
	hook.Remove("PostGamemodeLoaded", "tttwr_PostGamemodeLoaded")

	if GAMEMODE_NAME ~= "terrortown" or TTTWR_DISABLED then
		TTTWR = false

		incl, included = nil, nil

		return
	end

	TTTWR.loaded = true

	TTTWR.maxplayers_bits = math.ceil(math.log(game.MaxPlayers()) / math.log(2))

	function TTTWR:getfn(fnname)
		TTTWR.fns = TTTWR.fns or {}

		local id = (self.ClassName or tostring(self)) .. "\n" .. fnname

		local fn = TTTWR.fns[id] or self[fnname]

		TTTWR.fns[id] = fn

		return fn
	end

	incl("client", true)

	incl("client_extra", true)

	incl("decoy", true)

	incl("priotargs", true)

	incl("magneto", true)

	-- Light Ammo
	local item_ammo_pistol_ttt = scripted_ents.GetStored("item_ammo_pistol_ttt").t
	item_ammo_pistol_ttt.AmmoAmount = 60 -- 20
	item_ammo_pistol_ttt.AmmoMax = 120 -- 60
	-- Medium Ammo
	local item_ammo_smg1_ttt = scripted_ents.GetStored("item_ammo_smg1_ttt").t
	item_ammo_smg1_ttt.AmmoAmount = 30 -- 30
	item_ammo_smg1_ttt.AmmoMax = 60 -- 60
	-- Heavy Ammo
	local item_ammo_357_ttt = scripted_ents.GetStored("item_ammo_357_ttt").t
	item_ammo_357_ttt.AmmoAmount = 12 -- 10
	item_ammo_357_ttt.AmmoMax = 36 -- 20
	-- Shotgun Shells
	local item_box_buckshot_ttt = scripted_ents.GetStored("item_box_buckshot_ttt").t
	item_box_buckshot_ttt.AmmoAmount = 12 -- 10
	item_box_buckshot_ttt.AmmoMax = 24 -- 20
	-- Stop Spawning Deagle Ammo
	local item_ammo_revolver_ttt = scripted_ents.GetStored("item_ammo_revolver_ttt").t
	item_ammo_revolver_ttt.AutoSpawnable = false

	-- allow these weapons to be deployed near-instantly
	for _, v in pairs({
		"weapon_ttt_binoculars",
		"weapon_ttt_cse",
		"weapon_ttt_decoy",
		"weapon_ttt_defuser",
		"weapon_ttt_health_station",
		"weapon_ttt_radio",
		"weapon_ttt_teleport",
		"weapon_ttt_unarmed",
		"weapon_ttt_wtester",
	}) do
		weapons.GetStored(v).DeploySpeed = 12
	end

	incl("crowbar")

	incl("deagle")

	incl("huge")

	incl("knife")

	incl("flaregun")

	incl("newton")

	incl("sipist")

	incl("stungun")

	incl("equip")

	incl("movement")

	incl("sound")

	if CLIENT then
		goto skip
	end

	resource.AddSingleFile("materials/tttwr/tttwr_icons.png")

	incl("magneto", false)

	incl("decoy", false)

	incl("ammo", false)

	incl("scaledmg", false)

	incl("death", false)

	incl("replace", false)

	incl("hooks", false)

	::skip::

	for i = 1, #included do
		included[i]()
	end

	incl, included = nil, nil
end

local min, max = math.min, math.max

function TTTWR.RemapClamp(val, a, b, c, d)
	return c + (d - c) * min(1, max(0, (val - a) / (b - a)))
end

TTTWR.FrameTime = (function(ft)
	local a = Angle(0.015)

	if ft == a[1] then
		return 0.015
	end

	--for r = 10, 100 do
	for r = math.floor(1 / ft), math.ceil(1 / ft) do
		a[1] = 1 / r

		if ft == a[1] then
			return 1 / r
		end
	end

	return ft
end)(engine.TickInterval())


function TTTWR:CopySWEP(swep)
	for k, v in pairs(swep) do
		if istable(v) and istable(self[k]) then
			for k2, v2 in pairs(v) do
				self[k][k2] = v2
			end
		else
			self[k] = v
		end
	end
end

incl("mkweapon")

incl("mkpistol")
incl("mksmg")
incl("mkrifle")
incl("mksniper")
incl("mkshotgun")

incl("mkzoomable")
incl("mklasersniper")
incl("mkfocussniper")
incl("mkdoubleaction")
incl("mkmodeswitch")
incl("mkautoswitch")
incl("mkequip")

if GAMEMODE then
	PostGamemodeLoaded()
else
	hook.Add("PostGamemodeLoaded", "tttwr_PostGamemodeLoaded", PostGamemodeLoaded)
end
