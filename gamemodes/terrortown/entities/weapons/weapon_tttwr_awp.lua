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


TTTWR.MakeChargeableSniper(SWEP, 1, 2)

TTTWR.MakeEquipment(SWEP, { ROLE_TRAITOR, ROLE_DETECTIVE })

SWEP.HeadshotMultiplier = 1.6

SWEP.ReloadTime = 4
