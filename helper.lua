function nearestParticle(v, filterType)
    local best, bestDist
    for i, other in ipairs(particles) do
        if other ~= v and (not filterType or other.type == filterType) then
            local dx, dy = other.pX - v.pX, other.pY - v.pY
            local dist = dx*dx + dy*dy
            if not bestDist or dist < bestDist then
                best, bestDist = other, dist
            end
        end
    end
    return best
end

    function findEmptyCell()
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
