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

    explosionParticles = {}
    
end

function createExplosionParticle()
    local part = {}
    part.life = 4
    part.size = 1/part.life * 30
    table.insert(explosionParticles, part)
end

function ui:update(dt)
    for i = 1, #IAC do
        IAC[i].x = IAC[i].x - math.cos(love.timer.getTime() * 30) * 1
        IAC[i].y = IAC[i].y + math.cos(love.timer.getTime() * 30) * 1
    end
    for i, v in ipairs(explosionParticles) do
        if v.life > 0 then
            v.life = v.life - dt
        else
            table.remove(explosionParticles, i)
        end
    end
    if #explosionParticles < 300 then
        createExplosionParticle()
    end
end
function iAm()
    local a = 5
    a = a/5
    b = a * 6
    c = b * a * 5
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
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, wW, wH)
    love.graphics.setColor(0, 1, 0)
    for i, v in ipairs(explosionParticles) do
        love.graphics.circle("fill", wW/2 - (1/v.life * 5), wH/2 - (1/v.life * 5), v.size)
    end
    for i = 1, #IAC do
        drawShapeGroup(IAC[i])
    end
end

return ui
