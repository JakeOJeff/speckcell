local ui = {}

function ui:load()
    local IAC = {

        {
            x = 0,
            y = 0,
            shapes = {
                { type = "fill", shape = "circle", radius = 100, { 0.5, 0.5, 0.5 }, x = 0, y = 0 },
                { type = "fill", shape = "circle", radius = 80,  { 0.3, 0.3, 0.3 }, x = 0, y = 0 },
            }
        },

    }
end

function ui:update(dt)

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
end

return ui
