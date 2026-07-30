particles = {}
particle = require "particle"
require "movements"
require "target"

require "helper"
require "collide"
uiEnabled = true
ui = require "ui"


function love.load()
    wW = 1000
    wH = 1000

    rows = 500
    size = wW / rows
    cols = wH / size
    love.window.setMode(wW, wH)

    infectAudio = love.audio.newSource("audio/infect.mp3", "static")
    ui:load()
    resetGame()
end

function resetGame()
    particles = {}
    enableInfection = false
    grids = {}

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

    time = 0
    particleCount = love.math.random(300, 2500)
    for i = 1, particleCount do
        posX = (love.math.random(1, rows))
        posY = (love.math.random(1, cols))
        local part = particle:new("life", posX, posY, 1, 1)

        grids[posX][posY].holding = part
    end

    aX, aY = love.math.random(1, rows), love.math.random(1, cols)
    local part = particle:new("infected", aX, aY, 1, 1, { 0, 1, 0 },
        particle.targetedMovement,
        spreadColor,
        particle.findUninfectedTarget
    )
    part.target = "life"
    grids[aX][aY].holding = part
end

function love.update(dt)
    updateAllParticles(dt)
    ui:update(dt)
    if countParticleType("infected") ~= #particles then
        time = time + dt
    end

    local x, y = love.mouse.getPosition()
    if love.mouse.isDown(1) then
        local pX, pY = math.floor(x / size) + 1, math.floor(y / size) + 1
        local part = particle:new("food", pX, pY, 1, 1, { 1, 1, 0 })
        part.movable = false
        grids[pX][pY].holding = part
    end
end

function love.draw()
    drawAllParticles()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(countParticleType("infected") .. "/" .. #particles .. " | Time: " .. math.floor(time))
    ui:draw()
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
    elseif button == 2 then
        local pX, pY = math.floor(x / size) + 1, math.floor(y / size) + 1
        local part = particle:new("food", pX, pY, 1, 1, { 1, 1, 0 })
        part.movable = false
        grids[pX][pY].holding = part
    elseif button == 3 then
        resetGame()
    end
end
