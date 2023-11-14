TTTWR.MakeRifle(SWEP,
	"m16",
	"m4a1",
	"weapons/m4a1/m4a1_unsil-1.wav",
	15,
	60 / 400,
	0.018,
	2.2,
	30,
	-7.86, -4.6, 0.2,
	3.32, -1.35, -4.2
)

TTTWR.MakeAutoSwitch(SWEP)

function SWEP:OnThink()
	-- the m4a1's attack animation ends with a weird angle
	if self:GetActivity() == ACT_VM_PRIMARYATTACK
		and CurTime() > self:GetLastPrimaryFire() + 0.25
	then
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end
