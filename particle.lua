local particle = {}
particle.__index = particle

function particle:new(type, gX, gY, xDir, yDir, color, movementType, onCollide, targetType)
    local self = setmetatable({}, particle)

    self.gX, self.gY = gX or 1, gY or 1
    self.pX, self.pY = gX or 1, gY or 1
    
    self.color = color or { 1, 1, 1 }
    xImpDir = xDir or 1
    yImpDir = yDir or 1
    acceleration = 100
    type = type or "life"
    collidable = true
    target = nil
    items = {}         -- items the creatures carry or have consumed
    locations = {}     -- Locations the creatures or whatever remembers

    movementType = movementType
    onCollide = onCollide
    targetType = targetType
    table.insert(particles, particle)
    return particle
end

function particle:update(dt)

end

function particle:draw()

end

return particle
