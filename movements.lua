function randomMovement(v, targetX, targetY)
    return love.math.random() * 2 - 1, love.math.random() * 2 - 1
end

function targetedMovement(v, targetX, targetY)
    local impX, impY

    if targetX - v.pX > 0 then
        impX = 1
    else
        impX = -1
    end

    if targetY - v.pY > 0 then
        impY = 1
    else
        impY = -1
    end

    return impX, impY
end