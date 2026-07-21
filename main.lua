

function love.load()
    particles = {}
    for i = 1, 30 do
        createParticle(i * math.floor(math.randomseed(1,4)), i * math.floor(math.randomseed(1,4)), "right", "bottom")
    end
end

function love.update(dt)
    for i, v in ipairs(particles) do
        if v.type == "ants" do
            
        end
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
            xImpDir = "right",
            yImpDir = "bottom",
            acceleration = 1,
            type = "ants"
        }
    )
end