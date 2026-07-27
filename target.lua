function findUninfected(v, type)
    local targetX, targetY = v.pX, v.pY         -- default: don't move if no target
    if v.type == "infected" then
        local target = nearestParticle(v, type)
        if target then targetX, targetY = target.pX, target.pY end
    end
    return targetX, targetY
end

function findParticle(v, type)
    
end