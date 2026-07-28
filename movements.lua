function particle:randomMovement(targetX, targetY)
    return love.math.random() * 2 - 1, love.math.random() * 2 - 1
end

function particle:targetedMovement(targetX, targetY)
    local impX = (targetX - self.pX > 0) and 1 or -1
    local impY = (targetY - self.pY > 0) and 1 or -1

    return impX, impY
end