local particle = {}
particle.__index = particle

function particle:new(type, gX, gY, xDir, yDir, color, movementType, onCollide, targetType)
    local self = setmetatable({}, particle)

    self.gX, self.gY = gX or 1, gY or 1
    self.pX, self.pY = gX or 1, gY or 1

    self.color = color or { 1, 1, 1 }
    self.xImpDir = xDir or 1
    self.yImpDir = yDir or 1
    self.acceleration = 100
    self.type = type or "life"
    self.collidable = true
    self.movable = true
    self.target = nil
    self.items = {}     -- items the creatures carry or have consumed
    self.locations = {} -- Locations the creatures or whatever remembers

    self.movementType = movementType
    self.onCollide = onCollide
    self.targetType = targetType
    table.insert(particles, self)
    return self
end

function particle:update(dt)
    if self.movable then
        local xImp, yImp

        if self.movementType and self.targetType and love.math.random(1, 2) ~= 1 then
            local targetX, targetY = self.targetType(self, self.target)
            xImp, yImp = self:movementType(targetX, targetY)
        else
            xImp, yImp = self:randomMovement()
        end
        local oldGX, oldGY = self.gX, self.gY

        -- pick a direction, checking bounds safely
        local function inBounds(gx, gy)
            return grids[gx] ~= nil and grids[gx][gy] ~= nil
        end

        if inBounds(self.gX + xImp, self.gY + yImp) then
            self.xImpDir = xImp
            self.yImpDir = yImp
        elseif inBounds(self.gX + xImp, self.gY - yImp) then
            self.xImpDir = xImp
            self.yImpDir = -yImp
        elseif inBounds(self.gX - xImp, self.gY + yImp) then
            self.xImpDir = -xImp
            self.yImpDir = yImp
        else
            self.xImpDir = -xImp
            self.yImpDir = -yImp
        end

        -- move in continuous space
        self.pX = self.pX + self.acceleration * self.xImpDir * dt
        self.pY = self.pY + self.acceleration * self.yImpDir * dt

        -- clamp to grid bounds (in "cell units")
        self.pX = math.max(1, math.min(rows, self.pX))
        self.pY = math.max(1, math.min(cols, self.pY))

        self.gX = math.floor(self.pX)
        self.gY = math.floor(self.pY)

        local newGX = self.gX
        local newGY = self.gY

        if newGX ~= oldGX or newGY ~= oldGY then
            local targetCell = grids[newGX] and grids[newGX][newGY]

            if targetCell and targetCell.holding and targetCell.holding ~= self then
                local hP = targetCell.holding
                if self.onCollide and self.collidable then
                    self.onCollide(self, hP)
                end
                -- update grid occupancy if the particle moved to a new cell
            else
                if grids[oldGX] and grids[oldGX][oldGY] and grids[oldGX][oldGY].holding == self then
                    grids[oldGX][oldGY].holding = nil
                end
                if grids[self.gX] and grids[self.gX][self.gY] then
                    grids[self.gX][self.gY].holding = self
                end
                self.gX, self.gY = newGX, newGY
            end
        end
    end
end

function particle:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", math.floor(self.gX * size), math.floor(self.gY * size), size, size)
end

function updateAllParticles(dt)
    for i, v in ipairs(particles) do
        v:update(dt)
    end
end

function drawAllParticles()
    for i, v in ipairs(particles) do
        v:draw()
    end
end

return particle
