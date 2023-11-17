TTTWR.MakeShotgun(SWEP,
	"spas",
	"",
	"weapons/shotgun/shotgun_fire7.wav",
	9,
	60 / 90,
	0.085,
	6,
	4,
	-8.08, -8, 2,
	1, 1.03, 0.1
)

TTTWR.MakeEquipment(SWEP, { ROLE_TRAITOR, ROLE_DETECTIVE })

if CLIENT then
	SWEP.PrintName = "tttwr_boomstick_name"
	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "A shotgun with lots of knockback recoil.\nCan be used for very quick movement."
	};
end

if SERVER then
	hook.Add("EntityTakeDamage", "BoomstickPreventFallDamage",
		function(target, dmginfo)
			if not dmginfo:IsFallDamage() then return end
			if not (IsValid(target) and target:IsPlayer()) then return end
			local wep = target:GetActiveWeapon()
			if not (wep and IsValid(wep) and wep:GetClass() == "boomstick") then return end
			dmginfo:ScaleDamage(0)
		end)
end

function SWEP:PrimaryAttack(worldsnd)
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()
	if not IsValid(owner) then return end

	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-150 * self:Clip1() * owner:GetAimVector())

	self:PrimaryFire()
end

-- General SPAS-12 animation stuff:

SWEP.ReloadTimeConsecutive = 0.3
SWEP.DeployTime = 0.75

SWEP.PumpSound = "weapons/shotgun/shotgun_cock.wav"
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

function SWEP:PreSetupDataTables()
	self:NetworkVar("Float", 1, "PumpTime")
end

function SWEP:ShotgunThink()
	local pumptime = self:GetPumpTime()

	if pumptime == 0
		or CurTime() <= pumptime
	then
		return
	end

	self:SetPumpTime(0)

	if self:GetActivity() ~= ACT_VM_PRIMARYATTACK then
		return
	end

	self:SendWeaponAnim(ACT_SHOTGUN_PUMP)

	local ent = CLIENT and self:GetOwnerViewModel() or self

	if ent == self or IsFirstTimePredicted() then
		ent:EmitSound(
			self.PumpSound, 75, 100, 1, CHAN_AUTO
		)
	end
end

function SWEP:OnPostShoot()
	self:SetPumpTime(CurTime() + 0.15)
end

if SERVER then
	return
end

function SWEP:OnInsertClip()
	return self:EmitSound("Weapon_M3.Insertshell")
end

function SWEP:GetViewModelPosition(pos, ang)
	pos, ang = self.BaseClass.GetViewModelPosition(self, pos, ang)

	local fwd, rgt = ang:Forward(), ang:Right()

	for i = 1, 3 do
		pos[i] = pos[i] + fwd[i] * 2 - rgt[i]
	end

	ang:RotateAroundAxis(ang:Up(), -1)

	return pos, ang
end

function SWEP:FireAnimationEvent(pos, ang, event, options)
	if event == 21 then
		event = 5001
	elseif event == 6001 then
		local data = EffectData()
		data:SetFlags(90)

		local vm = self:GetOwnerViewModel()

		local att = vm
			and vm:GetAttachment(2)
			or self:GetAttachment(2)

		data:SetOrigin(att and att.Pos or pos)
		data:SetAngles(att and att.Ang or ang)

		util.Effect("EjectBrass_12Gauge", data)

		return true
	elseif event == 22 then
		local data = EffectData()
		data:SetEntity(self)
		data:SetFlags(2)

		util.Effect("MuzzleFlash", data)

		return true
	end

	return self.BaseClass.FireAnimationEvent(self, pos, ang, event, options)
end
