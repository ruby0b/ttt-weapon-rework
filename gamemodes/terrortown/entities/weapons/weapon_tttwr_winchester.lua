TTTWR.MakeSniper(SWEP,
    "winchester",
    "",
    "weapons/winchester73/w73-1.wav",
    36,
    60 / 66,
    0.02,
    3,
    7,
    4.356, 0, 2.591,
    0, 0, 0
)


TTTWR.MakeChargeableSniper(SWEP, 1)

SWEP.HideCrosshair = false
SWEP.ZoomFOV = 35

if CLIENT then
    SWEP.Icon = "VGUI/ttt/lykrast/icon_sp_winchester"
    SWEP.ViewModelFOV = 70
    SWEP.ViewModelFlip = true
end

SWEP.ViewModel = "models/weapons/v_winchester1873.mdl"
SWEP.WorldModel = "models/weapons/w_winchester_1873.mdl"

-- no scope
function SWEP:DrawHUD()
    if self.ZoomableDrawHUD then
        self:ZoomableDrawHUD()
    end
    if not self:GetIronsights() and self.HideCrosshair then
        return
    end
    return self.BaseClass.DrawHUD(self)
end

-- copy shotgun reload
local fake_shotgun = { Primary = {} }
TTTWR.MakeShotgun(fake_shotgun, "", "", "", 0, 0, 0, 0, 0)

local shotgun_think = fake_shotgun.OnThink
local sniper_think = SWEP.OnThink

function SWEP:OnThink()
    sniper_think(self)
    return shotgun_think(self)
end

SWEP.ReloadTime = 0.5
SWEP.ReloadTimeConsecutive = 0.5
SWEP.ReloadTimeFinish = 0.5
SWEP.ReloadAnim = ACT_SHOTGUN_RELOAD_START
