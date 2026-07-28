-- onCollide functions

function spreadColor(self, other)
    if enableInfection then
        other.color = self.color
        other.type = "infected"
        other.onCollide = spreadColor
        other.target = "life"
        other.targetType = findUninfected
        if countParticleType("life") > 0 then
            other.movementType = particle.targetedMovement
        else
            other.movementType = particle.randomMovement
        end
        
    end
end

function eatAndReproduce(self, other)
    if other.type == "food" then
        
    end
end
