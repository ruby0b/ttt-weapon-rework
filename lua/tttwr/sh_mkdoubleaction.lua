local SWEP = {}

function TTTWR:MakeDoubleAction(da_sound, da_time)
    TTTWR.CopySWEP(self, SWEP)

    self.DoubleActionSound = da_sound
    self.DoubleActionTime = da_time
end

function SWEP:PreSetupDataTables()
    self:NetworkVar("Float", 5, "DoubleActionShootTime")

    self:SetDoubleActionShootTime(-1)
end

function SWEP:DoubleActionReset()
    self:SetDoubleActionShootTime(-1)
    self:SetIronsights(false)
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
        return
    end

    if self:GetDoubleActionShootTime() < 0 then
        self:SetDoubleActionShootTime(CurTime() + self.DoubleActionTime)
        self:SetIronsights(true)

        if self.DoubleActionSound then
            local owner = self:GetOwner()
            if not IsValid(owner) then
                owner = nil
            end

            local localowned = CLIENT and owner == LocalPlayer()

            if localowned then
                self:EmitSound(self.DoubleActionSound)
            elseif owner then
                TTTWR.PlaySound(self, owner, self.DoubleActionSound, nil)
            else
                self:EmitSound(self.DoubleActionSound)
            end
        end
    end
end

function SWEP:SecondaryAttack()
    if CurTime() >= self:GetNextPrimaryFire() and self:GetDoubleActionShootTime() < 0 then
        return self:PrimaryFire()
    end
end

function SWEP:OnThink()
    local shoot_time = self:GetDoubleActionShootTime()

    if shoot_time < 0 then
        return
    end

    local owner = self:GetOwner()
    if not (IsValid(owner) and owner:IsTerror()) then
        return
    end

    if CurTime() >= shoot_time then
        self:PrimaryFire()
        self:DoubleActionReset()
    elseif owner:KeyReleased(IN_ATTACK) then
        self:DoubleActionReset()
    end
end

function SWEP:OnStartReload()
    self:DoubleActionReset()
end

function SWEP:ZoomablePreDrop()
    self:DoubleActionReset()
end

function SWEP:ZoomableHolster()
    self:DoubleActionReset()

    return true
end
