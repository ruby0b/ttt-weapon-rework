local SWEP = weapons.GetStored("weapon_zm_revolver")

TTTWR.MakePistol(SWEP,
	"deagle",
	"deagle",
	{"weapons/deagle/deagle-1.wav", 90},
	35,
	60 / 120,
	0.02,
	5,
	7,
	-6.361, -3.701, 2.15,
	0, 0, 0
)


SWEP.HeadshotMultiplier = 3.5

SWEP.FalloffStart = 384
SWEP.FalloffEnd = 1280

SWEP.ConeResetStart = 2 / 3

SWEP.ReloadTime = 2.5
SWEP.DeployTime = 0.875
SWEP.DeployAnimSpeed = 1.15

SWEP.BulletTracer = 1

SWEP.Primary.ClipMax = 36
SWEP.Primary.Ammo = "357"

SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.DryFireAnim = ACT_VM_DRYFIRE
