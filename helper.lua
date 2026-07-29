function particle:nearestParticle(findType)
    local best, bestDist
    for i, other in ipairs(particles) do
        if other ~= self and (not findType or other.type == findType) then
            -- Calculating shortest distance based on Distance formula
            local dx, dy = other.pX - self.pX, other.pY - self.pY
            local dist = dx * dx + dy * dy
            if not bestDist or dist < bestDist then
                best, bestDist = other, dist
            end
        end
    end
    return best
end

function particle:findEmptyCell()
    for i = 1, rows do
        for j = 1, cols do
            grids[i][j] = {
                x = (i - 1) * size,
                y = (j - 1) * size,
                holding = nil
            }
        end
    end
end

function countParticleType(type)
    local count = 0
    for i = 1, #particles do
        if particles[i].type == type then
            count = count + 1
        end
    end
    return count
end
