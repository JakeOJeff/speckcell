local ui = {}

function ui:load()
    IAC = {

        {
            x = 0,
            y = 0,
            shapes = {
                { type = "fill", shape = "circle", radius = 100, color = { 0.5, 0.5, 0.5 }, x = wW / 2, y = wH / 2 },
                { type = "fill", shape = "circle", radius = 80,  color = { 0.3, 0.3, 0.3 }, x = wW / 2, y = wH / 2 },
            }
        }

    }
    t = 0

    explosionParticles = {}
end

function createExplosionParticle()
    local part = {}
    part.life = 2
    local minAngle = math.rad(180)
    local maxAngle = math.rad(230)
    part.angle = minAngle + love.math.random() * (maxAngle - minAngle)

    part.speed = love.math.random(200, 700)

    part.size = 1 / part.life * 30
    table.insert(explosionParticles, part)
end

function ui:update(dt)
    if uiEnabled then
        t = t + dt
        for i = 1, #IAC do
            IAC[i].x = IAC[i].x - math.cos(love.timer.getTime() * 30) * 1 * t
            IAC[i].y = IAC[i].y + math.cos(love.timer.getTime() * 30) * 1 * t
        end
        for i = #explosionParticles, 1, -1 do
            local v = explosionParticles[i]
            if v.life > 0 then
                v.life = v.life - dt
                if v.life > 1 then
                    v.size = 1 / v.life * 10
                end
            else
                table.remove(explosionParticles, i)
            end
        end
        if #explosionParticles < 800 then
            for i = 1, math.floor(t) do
                createExplosionParticle()
            end
        end
        if t > 5 then
            uiEnabled = false
        end
    end
end

function drawShapeGroup(table)
    for i, v in ipairs(table.shapes) do
        love.graphics.setColor(v.color)
        if v.shape == "circle" then
            love.graphics.circle(v.type, table.x + v.x, table.y + v.y, v.radius)
        elseif v.shape == "rectangle" then
            love.graphics.rectangle(v.type, table.x + v.x, table.y + v.y, v.width, v.height)
        end
    end
end

function ui:draw()
    if uiEnabled then
        love.graphics.setColor(0.1, 0.1, 0.1)
        love.graphics.rectangle("fill", 0, 0, wW, wH)
        love.graphics.setColor(1, 1, 1)
        for i, v in ipairs(explosionParticles) do
            local dist = (2 - v.life) * v.speed
            local px = wW * 2 + math.cos(v.angle) * dist
            local py = wH * 2 + math.sin(v.angle) * dist
            love.graphics.circle("fill", px, py, 6)
        end
        love.graphics.setColor(1, 0, 0)

        for i, v in ipairs(explosionParticles) do
            local dist = (2 - v.life) * v.speed
            local px = IAC[1].x + wW / 2 + math.cos(v.angle) * dist
            local py = IAC[1].y + wH / 2 + math.sin(v.angle) * dist
            love.graphics.circle("fill", px, py, v.size)
        end
        for i = 1, #IAC do
            drawShapeGroup(IAC[i])
        end
        love.graphics.setColor(1,1,1)
        love.graphics.print("5000 years ago", 50, 50)
    end
end

return ui
