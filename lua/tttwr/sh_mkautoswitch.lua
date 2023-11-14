function TTTWR:MakeAutoSwitch(semidamage)
    self.DefaultDamage = self.Primary.Damage
    self.SemiDamage = semidamage or math.Round(self.Primary.Damage * 1.33)

    TTTWR.MakeModeSwitch(
        self,
        { "automatic", "semi-automatic" },
        {
            function(self)
                self.Primary.Automatic = true
                self.Primary.Damage = self.DefaultDamage
            end,
            function(self)
                self.Primary.Automatic = false
                self.Primary.Damage = self.SemiDamage
            end
        }
    )
end
