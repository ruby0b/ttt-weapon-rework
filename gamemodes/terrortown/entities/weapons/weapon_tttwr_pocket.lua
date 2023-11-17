TTTWR.MakeSniper(SWEP,
    "pocket",
    "",
    "weapons/g2contender/scout-2.wav",
    17,
    60 / 60,
    0.03,
    4,
    1,
    -3, -15.857, 0.36,
    0, 0, 0
)


TTTWR.MakeIronsightsChargeableSniper(SWEP, 3, 3)

if CLIENT then
    SWEP.Slot = 1
    SWEP.Icon = "vgui/ttt/lykrast/icon_rp_pocket"
    SWEP.ViewModelFOV = 70
end

SWEP.Kind = WEAPON_PISTOL
SWEP.HoldType = "revolver"
SWEP.ViewModel = "models/weapons/v_contender2.mdl"
SWEP.WorldModel = "models/weapons/w_g2_contender.mdl"

SWEP.ReloadTime = 1.5
SWEP.DeployTime = 0.875
-- SWEP.DeployAnimSpeed = 1.15

local _PrimaryFire = SWEP.PrimaryFire
function SWEP:PrimaryFire()
    _PrimaryFire(self)

    if self:Clip1() > 0 then return end

    if self:Reload() ~= false then return end

    self:SetIronsights(false)
    self:SendWeaponAnim(ACT_VM_IDLE)

    local ent = CLIENT and self:GetOwnerViewModel() or self
    if ent ~= self and not IsFirstTimePredicted() then return end
    ent:EmitSound("weapons/pistol/pistol_empty.wav", 60, 100, 0.25, CHAN_AUTO)
end
