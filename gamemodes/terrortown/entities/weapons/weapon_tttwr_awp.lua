TTTWR.MakeSniper(SWEP,
	"awp",
	"awp",
	{ "weapons/awp/awp1.wav", 95 },
	65,
	60 / 40,
	0.03,
	7,
	2
)

TTTWR.MakeIronsightsChargeableSniper(SWEP, 2)

SWEP.HideCrosshair = true

SWEP.ReloadTime = 4

TTTWR.MakeEquipment(SWEP, { ROLE_TRAITOR, ROLE_DETECTIVE })

TTTWR.ExtraAmmoOnBuy = 0

SWEP.Primary.Ammo = "none"

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "AWP Sniper Rifle.\n\nFully charged bodyshots kill in one hit."
	}
end
