function particle:findUninfectedTarget(type)
    local targetX, targetY = self.pX, self.pY         -- default: don't move if no target
    if self.type == "infected" then
        local target = nearestParticle(self, type)
        if target then targetX, targetY = target.pX, target.pY end
    end
    return targetX, targetY
end

function particle:findParticleRadius(targetCenter)
    
    local targetX, targetY = self.pX, self.pY
    local radius = 35
    if self.type == "life" then
        if targetCenter then
            targetX, targetY = love.math.random(self.x - radius, self.x + radius), love.math.random(self.y - radius, self.y + radius)
        end
    end
    return targetX, targetY
end