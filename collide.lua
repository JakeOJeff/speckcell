-- onCollide functions

function spreadColor(self, other)
    if enableInfection then
        other.color = self.color
        other.type = "infected"
        other.onCollide = spreadColor
    end
end

function eatAndReproduce(self, other)
    if other.type == "food" then
        
    end
end
