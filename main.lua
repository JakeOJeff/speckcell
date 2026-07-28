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
    particle = require "particle"
    require "movements"

    time = 0

    for i = 1, 3000 do
        posX = (love.math.random(1, rows))
        posY = (love.math.random(1, cols))
        local part = particle:new("life", posX, posY, 1, 1)
        grids[posX][posY].holding = part
    end

    aX, aY = love.math.random(1, 30), love.math.random(1, 30)
    local part = particle:new("infected", aX, aY, 1, 1, { 0, 1, 0 }, particle.targetedMovement, spreadColor, findUninfected)
    part.target = "life"
    grids[aX][aY].holding = part
end

function love.update(dt)
    updateAllParticles(dt)
    if countParticleType("infected") ~= #particles then
        time = time + dt
    end
end

function love.draw()
    drawAllParticles()
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

