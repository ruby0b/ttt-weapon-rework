local SWEP = {}

TTTWR.cv_charge_snipers = CreateConVar("ttt_charge_snipers", "1",
	FCVAR_ARCHIVE + FCVAR_NOTIFY + FCVAR_REPLICATED,
	"Should sniper rifles be chargeable?")

function TTTWR:MakeIronsightsChargeableSniper(chargetime, maxdamagemultiplier)
	-- If the cvar is off, damage is just always the max charged damage
	if not TTTWR.cv_charge_snipers:GetBool() then
		self.Primary.Damage = self.Primary.Damage * (maxdamagemultiplier or 2)
		return
	end

	TTTWR.CopySWEP(self, SWEP)

	self.SniperRifleChargeTime = chargetime
	self.SniperRifleChargeMaxMultiplier = maxdamagemultiplier or 2
end

function SWEP:PreSetupDataTables()
	self:NetworkVar("Float", 2, "SniperCharge")
	self:SetSniperCharge(-1)
end

function SWEP:ResetCharge(charge)
	charge = charge or self:GetSniperCharge()
	if charge >= 0 then
		self:SetSniperCharge(-1)
	end
	self.BulletDamageMultiplier = nil
end

function SWEP:PrimaryAttack()
	self:PrimaryFire()
	self:ResetCharge()
end

function SWEP:OnThink()
	local charge = self:GetSniperCharge()

	if (not self:GetIronsights()
			or CurTime() < self:GetNextPrimaryFire()
			or self:Clip1() == 0) then
		self:ResetCharge(charge)
		return
	end

	local owner = self:GetOwner()

	if not (IsValid(owner) and owner:IsTerror()) then
		return
	end

	if charge ~= 1000 then
		charge = math.Clamp(
			charge + 1000 / self.SniperRifleChargeTime * FrameTime(),
			0, 1000
		)

		self.BulletDamageMultiplier = TTTWR.RemapClamp(
			charge, 100, 1000, 1, self.SniperRifleChargeMaxMultiplier
		)

		self:SetSniperCharge(charge)
	end
end

function SWEP:OnStartReload()
	self:ResetCharge()
end

function SWEP:ZoomablePreDrop()
	self:ResetCharge()
end

function SWEP:ZoomableHolster()
	self:ResetCharge()
	return true
end

if SERVER then
	return
end

function SWEP:ZoomableDrawHUD()
	local charge = self:GetSniperCharge()

	if charge < 100 then
		return
	end

	if LocalPlayer():IsTraitor() then
		surface.SetDrawColor(255, 0, 0, 255)
	else
		surface.SetDrawColor(0, 255, 0, 255)
	end

	local x, y = ScrW() * 0.5, ScrH() * 0.66

	local w, h = 100, 10

	surface.DrawOutlinedRect(x - w * 0.5, y - h, w, h)

	surface.DrawRect(x - w * 0.5, y - h, w * charge * 0.001, h)

	surface.SetFont("TabLarge")
	surface.SetTextColor(255, 255, 255, 180)
	surface.SetTextPos((x - w * 0.5) + 3, y - h - 15)
	surface.DrawText("DAMAGE")
end
