TTTWR.MakeSniper(SWEP,
	"awp",
	"awp",
	{ "weapons/awp/awp1.wav", 95 },
	65,
	60 / 40,
	0.03,
	7,
	5
)

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "AWP Sniper Rifle.\nFully charged bodyshots kill in one hit."
	}
end

TTTWR.MakeIronsightsChargeableSniper(SWEP, 2)

TTTWR.MakeEquipment(SWEP, { ROLE_TRAITOR, ROLE_DETECTIVE })

SWEP.ReloadTime = 4
