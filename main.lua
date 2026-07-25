

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
        local particle = createParticle("ants", posX, posY, 1, 1)
        grids[posX][posY].holding = particle
    end
end

function love.update(dt)
    for i = 1, #particles do
        local v = particles[i]
        grids[v.x][v.y] = v or nil
    end
    for i, v in ipairs(particles) do
        if v.type == "ants" then
            local xImp = math.random() * 2 - 1
            local yImp = math.random() * 2 - 1
            if grids[particles[i].gX - xImp][particles[i].gY - yImp] then
                v.xImpDir = xImp
                v.yImpDir = yImp
            elseif grids[particles[i].gX - xImp][particles[i].gY - yImp] then
                
            end
            v.gX = v.gX + v.acceleration * v.xImpDir * dt
            v.gY = v.gY + v.acceleration * v.yImpDir * dt
        end

    end
end

function love.draw()
    for i, v in ipairs(particles) do
        love.graphics.rectangle("fill", math.floor(v.gX * size), math.floor(v.gY * size), size, size)
    end
end

function love.mouspressed(x, y, button)
    if button == "1" then
        createParticle("")
    end
end
function createParticle(type, gX, gY, xDir, yDir)
    particle =         {
            gX = gX or 0,
            gY = gY or 0,
            color = {1,1,1},
            xImpDir = xDir or 1,
            yImpDir = yDir or 1,
            acceleration = 10,
            type = type or "ants"
        }
    table.insert(particles,
        particle
    )
    return particle
end