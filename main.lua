require "movements"
require "helper"
require "collide"
require "target"

function love.load()
    wW = 1000
    wH = 1000

    grids = {}
    rows = 500
    size = wW / rows
    cols = wH / size

    infectAudio = love.audio.newSource("audio/infect.mp3", "static")

    enableInfection = false
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
    time = 0
    for i = 1, 1000 do
        posX = (love.math.random(1, rows))
        posY = (love.math.random(1, cols))
        local particle = createParticle("life", posX, posY, 1, 1)
        grids[posX][posY].holding = particle
    end

    aX, aY = love.math.random(1, 30), love.math.random(1, 30)
    local particle = createParticle("infected", aX, aY, 1, 1, { 0, 1, 0 }, targetedMovement, spreadColor, findUninfected)
    particle.target = "life"
    grids[aX][aY].holding = particle
end

function love.update(dt)
    for i, v in ipairs(particles) do
        local xImp, yImp

        if v.movementType and v.targetType then
            local targetX, targetY = v.targetType(v, v.target)
            xImp, yImp = v.movementType(v, targetX, targetY)
        else
            xImp, yImp = randomMovement(v)
        end
        local oldGX, oldGY = v.gX, v.gY

        -- pick a direction, checking bounds safely
        local function inBounds(gx, gy)
            return grids[gx] ~= nil and grids[gx][gy] ~= nil
        end

        if inBounds(v.gX + xImp, v.gY + yImp) then
            v.xImpDir = xImp
            v.yImpDir = yImp
        elseif inBounds(v.gX + xImp, v.gY - yImp) then
            v.xImpDir = xImp
            v.yImpDir = -yImp
        elseif inBounds(v.gX - xImp, v.gY + yImp) then
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

        local newGX = v.gX
        local newGY = v.gY

        if newGX ~= oldGX or newGY ~= oldGY then
            local targetCell = grids[newGX] and grids[newGX][newGY]

            if targetCell and targetCell.holding and targetCell.holding ~= v then
                local hP = targetCell.holding
                if v.onCollide and v.collidable then
                    v.onCollide(v, hP)
                end

                -- update grid occupancy if the particle moved to a new cell
            else
                if grids[oldGX] and grids[oldGX][oldGY] and grids[oldGX][oldGY].holding == v then
                    grids[oldGX][oldGY].holding = nil
                end
                if grids[v.gX] and grids[v.gX][v.gY] then
                    grids[v.gX][v.gY].holding = v
                end
                v.gX, v.gY = newGX, newGY
            end
        end
    end
    if countParticleType("infected") ~= #particles then
        time = time + dt
    end
end

function love.draw()
    for i, v in ipairs(particles) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle("fill", math.floor(v.gX * size), math.floor(v.gY * size), size, size)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(countParticleType("infected") .. "/" .. #particles .. " | Time: " .. math.floor(time))
end

function love.mousepressed(x, y, button)
    if button == 1 then
        enableInfection = not enableInfection
        for i, v in ipairs(particles) do
            if v.type == "life" then
                if enableInfection then
                    v.collidable = true
                else
                    v.collidable = false
                end
            end
        end
    end
end

function createParticle(type, gX, gY, xDir, yDir, color, movementType, onCollide, targetType)
    local particle = {
        gX = gX or 1,
        gY = gY or 1,
        pX = gX or 1,
        pY = gY or 1,
        color = color or { 1, 1, 1 },
        xImpDir = xDir or 1,
        yImpDir = yDir or 1,
        acceleration = 100,
        type = type or "life",
        collidable = true,
        target = nil,
        items = {},     -- items the creatures carry or have consumed
        locations = {}, -- Locations the creatures or whatever remembers

        movementType = movementType,
        onCollide = onCollide,
        targetType = targetType

    }
    table.insert(particles, particle)
    return particle
end
