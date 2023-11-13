local SWEP = {}

function TTTWR:MakeIronsightsChargeableSniper(chargetime, maxdamagemultiplier)
	TTTWR.CopySWEP(self, SWEP)

	self.SniperRifleChargeTime = chargetime
	self.SniperRifleChargeMaxMultiplier = maxdamagemultiplier or 2
end

function SWEP:PreSetupDataTables()
	self:NetworkVar("Float", 2, "SniperCharge")

	self:SetSniperCharge(-1)
end

function SWEP:PrimaryAttack()
	self:SetSniperCharge(-1)

	self:PrimaryFire()
end

function SWEP:OnThink()
	local charge = self:GetSniperCharge()

	if CurTime() < self:GetNextPrimaryFire() then
		self:SetSniperCharge(-1)

		return
	end

	if not self:GetIronsights() then
		if charge >= 0 then
			self:SetSniperCharge(-1)
		end

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
	else
		charge = nil
	end

	if charge then
		self:SetSniperCharge(charge)
	end
end

function SWEP:OnStartReload()
	self:SetSniperCharge(-1)
end

function SWEP:ZoomablePreDrop()
	self:SetSniperCharge(-1)
end

function SWEP:ZoomableHolster()
	self:SetSniperCharge(-1)

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
	surface.SetTextPos( (x - w * 0.5) + 3, y - h - 15)
	surface.DrawText("DAMAGE")
end
