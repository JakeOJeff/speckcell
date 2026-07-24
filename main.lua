

function love.load()


    wW = 500
    wH = 500

    grids = {}
    rows = 250
    size = wW/rows
    cols = wH/size


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
        posX = i * (love.math.random(1,4))
        posY = i * (love.math.random(1,4))
        local particle = createParticle(posX, posY, "right", "bottom")
        grids[posX][posY].holding = particle
    end
end

function love.update(dt)
    for i, v in ipairs(particles) do
        if v.xImpDir == "right" then
            v.gX = v.gX + 1 * dt
        end
    end
end

function love.draw()
    for i, v in ipairs(particles) do
        love.graphics.rectangle("fill", v.gX * size, v.gY * size, size, size)
    end
end

function createParticle(gX, gY, xDir, yDir)
    particle =         {
            gX = gX or 0,
            gY = gY or 0,
            color = {1,1,1},
            xImpDir = xDir or "right",
            yImpDir = yDir or "bottom",
            acceleration = 1,
            type = "ants"
        }
    table.insert(particles,
        particle
    )
    return particle
end