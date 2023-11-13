TTTWR.MakeShotgun(SWEP,
    "mag7",
    "",
    "csgo/weapons/mag7/mag7_01.wav",
    9,
    60 / 90,
    0.085,
    6,
    5,
    -6.38, -10, 3.3,
    0, 0, 0
)

if CLIENT then
    SWEP.Icon = "entities/weapon_csgo_mag7.png"
    SWEP.ViewModelFOV = 60
end

SWEP.ViewModel = Model("models/csgo/weapons/v_shot_mag7.mdl")
SWEP.WorldModel = Model("models/csgo/weapons/w_shot_mag7.mdl")

-- mag7 doesn't have individual "shotgun" reloading
SWEP.OnThink = nil
SWEP.ReloadAnim = ACT_VM_RELOAD
SWEP.ReloadTime = 2.0
SWEP.HoldType = "ar2"
SWEP.UseHands = false
SWEP.NoSetInsertingOnReload = false

