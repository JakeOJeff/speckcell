-- onCollide functions

function spreadColor(self, other)
    if enableInfection then
        other.color = self.color
        other.type = "infected"
        other.onCollide = spreadColor
    end
end
