function love.load()
    wW = 500
    wH = 500

    grids = {}
    rows = 100
    size = wW / rows
    cols = wH / size


    for i = 1, rows do
        grids[i] = {}
        for j = 1, cols do
            grids[i][j] = {
                x = (i - 1) * size,
                y = (j - 1) * size,
                holding = nil

            }
        end
    end

    love.window.setMode(wW, wH)

    particles = {}
    for i = 1, 30 do
        posX = (love.math.random(1, rows))
        posY = (love.math.random(1, cols))
        local particle = createParticle("ants", posX, posY, 1, 1)
        grids[posX][posY].holding = particle
    end

    createParticle("ants", love.math.random(1, 30), love.math.random(1, 30), 1, 1, {0,1,0})
end

function love.update(dt)
    for i, v in ipairs(particles) do
        if v.type == "ants" then
            local xImp = love.math.random() * 2 - 1
            local yImp = love.math.random() * 2 - 1

            local oldGX, oldGY = v.gX, v.gY

            -- pick a direction, checking bounds safely
            local function inBounds(gx, gy)
                return grids[gx] ~= nil and grids[gx][gy] ~= nil
            end

            if inBounds(v.gX - xImp, v.gY - yImp) then
                v.xImpDir = xImp
                v.yImpDir = yImp
            elseif inBounds(v.gX - xImp, v.gY + yImp) then
                v.xImpDir = xImp
                v.yImpDir = -yImp
            elseif inBounds(v.gX + xImp, v.gY + yImp) then
                v.xImpDir = -xImp
                v.yImpDir = yImp
            else
                v.xImpDir = -xImp
                v.yImpDir = -yImp
            end

            -- move in continuous space
            v.pX = v.pX + v.acceleration * v.xImpDir * dt
            v.pY = v.pY + v.acceleration * v.yImpDir * dt

            -- clamp to grid bounds (in "cell units")
            v.pX = math.max(1, math.min(rows, v.pX))
            v.pY = math.max(1, math.min(cols, v.pY))

            v.gX = math.floor(v.pX)
            v.gY = math.floor(v.pY)

            -- update grid occupancy if the particle moved to a new cell
            if v.gX ~= oldGX or v.gY ~= oldGY then
                if grids[oldGX] and grids[oldGX][oldGY] and grids[oldGX][oldGY].holding == v then
                    grids[oldGX][oldGY].holding = nil
                end
                if grids[v.gX] and grids[v.gX][v.gY] then
                    grids[v.gX][v.gY].holding = v
                end
            end
        end
    end
end

function love.draw()
    for i, v in ipairs(particles) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle("fill", math.floor(v.gX * size), math.floor(v.gY * size), size, size)
    end
end

function love.mouspressed(x, y, button)
    if button == "1" then
        createParticle("")
    end
end

function createParticle(type, gX, gY, xDir, yDir, color)
    local particle = {
        gX = gX or 1,
        gY = gY or 1,
        pX = gX or 1,
        pY = gY or 1,
        color = { 1, 1, 1 } or color,
        xImpDir = xDir or 1,
        yImpDir = yDir or 1,
        acceleration = 100,
        type = type or "ants"
    }
    table.insert(particles, particle)
    return particle
end