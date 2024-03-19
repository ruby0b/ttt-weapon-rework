TTTWR.MakeSniper(SWEP,
	"g3",
	"g3sg1",
	"weapons/g3sg1/g3sg1-1.wav",
	12,
	60 / 240,
	0.02,
	3,
	TTWR.cv_charge_snipers:GetBool() and 20 or 5
)

TTTWR.MakeIronsightsChargeableSniper(SWEP, 2, 3)

SWEP.HeadshotMultiplier = 3

SWEP.ConeResetStart = 0.25
