TTTWR.MakeRifle(SWEP,
	"sim16",
	"m4a1",
	{"weapons/m4a1/m4a1-1.wav", 65, 90, 0.8},
	17,
	60 / 400,
	0.016,
	2,
	30,
	-7.86, -4.6, 0.2,
	3.32, -1.35, -4.2
)

TTTWR.MakeAutoSwitch(SWEP)

TTTWR.MakeEquipment(SWEP,
	CreateConVar(
		"ttt_buyable_sim16", "1", FCVAR_ARCHIVE + FCVAR_NOTIFY + FCVAR_REPLICATED, "server needs a map change to apply new value"
	):GetBool() and {ROLE_TRAITOR} or nil,
	2
)

SWEP.FakeDefaultEquipment = true

SWEP.IsSilent = true

-- for some reason, the silenced version of the m4a1's world model has a longer grip and magazine
SWEP.WorldModel = "models/weapons/w_rif_m4a1_silencer.mdl"

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.ReloadAnim = ACT_VM_RELOAD_SILENCED
SWEP.DeployAnim = ACT_VM_DRAW_SILENCED
SWEP.IdleAnim = ACT_VM_IDLE_SILENCED

if CLIENT then
	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "sim16_desc",
	}
end


function SWEP:OnThink()
	-- the m4a1's attack animation ends with a weird angle
	if self:GetActivity() == self.PrimaryAnim
		and CurTime() > self:GetLastPrimaryFire() + 0.25
	then
		self:SendWeaponAnim(self.IdleAnim)
	end
end
