if SERVER then
    resource.AddFile("sound/weapons/csgo/auto_semiauto_switch.wav")
end

local SWEP = {}

SWEP.ModeSwitchSound = "weapons/csgo/auto_semiauto_switch.wav"
SWEP.ModeSwitchMessageDuration = 1.0

-- modemessages: table<state_message: string>
-- modehooks: table<state_hook: function(SWEP)>
function TTTWR:MakeModeSwitch(modemessages, modehooks)
    TTTWR.CopySWEP(self, SWEP)

    self.ModeSwitchMessages = modemessages
    self.ModeSwitchHooks = modehooks
end

function SWEP:PreSetupDataTables()
    self:NetworkVar("Int", 6, "ModeSwitchState")
    self:NetworkVar("Float", 6, "ModeSwitchTime")

    self:SetModeSwitchState(1)
    self:SetModeSwitchTime(-1)
end

function SWEP:SecondaryAttack()
    if self:ModeSwitch() then
        return
    end

    self.BaseClass.SecondaryAttack(self)
end

function SWEP:ModeSwitch()
    local owner = self:GetOwner()

    if not IsValid(owner) or not owner:KeyDown(IN_USE) then
        return
    end

    if self.ModeSwitchSound then
        self:EmitSound(self.ModeSwitchSound)
    end

    local new_state = (self:GetModeSwitchState() % #self.ModeSwitchMessages) + 1

    self:SetModeSwitchState(new_state)

    local onswitch = self.ModeSwitchHooks[new_state]
    if onswitch then
        onswitch(self)
    end

    self:SetModeSwitchTime(CurTime())
    self:SetNextSecondaryFire(CurTime() + 0.35)

    return true
end

local max = math.max
local easeIn = math.ease.InQuint
local Lerp = Lerp
local Color = Color
local _DrawHUD = SWEP.DrawHUD
function SWEP:DrawHUD()
    if _DrawHUD then
        _DrawHUD(self)
    else
        self.BaseClass.DrawHUD(self)
    end

    local time = self:GetModeSwitchTime()

    if time < 0 then
        return
    end

    local delta = CurTime() - time
    local progress = max(0, delta / self.ModeSwitchMessageDuration)

    if progress >= 1 then
        self:SetModeSwitchTime(-1)

        return
    end

    local state = self:GetModeSwitchState()
    local message = self.ModeSwitchMessages[state]

    if not message then
        return
    end

    message = "Switched to " .. message

    local alpha = Lerp(easeIn(progress), 255, 0)
    local font = "TargetID"

    draw.DrawText(
        message, font,
        ScrW() * 0.5, ScrH() * 0.55,
        Color(255, 255, 255, alpha),
        TEXT_ALIGN_CENTER
    )
end
