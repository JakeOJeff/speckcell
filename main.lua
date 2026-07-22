

function love.load()
    particles = {}
    for i = 1, 30 do
        createParticle(i * math.floor(math.randomseed(1,4)), i * math.floor(math.randomseed(1,4)), "right", "bottom")
    end

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
                
            }
        end
    end


end

function love.update(dt)
    for i, v in ipairs(particles) do

    end
end

function love.draw()
    
end

function createParticle(gX, gY, xDir, yDir)
    table.insert(particles,
        {
            gX = gX or 0,
            gY = gY or 0,
            color = {1,1,1},
            xImpDir = xDir or "right",
            yImpDir = yDir or "bottom",
            acceleration = 1,
            type = "ants"
        }
    )
end