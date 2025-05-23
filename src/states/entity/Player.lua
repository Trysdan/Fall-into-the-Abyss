-- Basic playe test

Player = Class{}

function Player:init(world, x, y)
    self.world = world
    self.x = x
    self.y = y
    self.width = 16
    self.height = 16
    self.speed = 100
    self.dy = 0
    self.jumpVelocity = -220
    self.gravity = 500
    self.isOnGround = false
    self.world:add(self, self.x, self.y, self.width, self.height)
end

function Player:update(dt)
    local dx = 0

    if isDownAny(CONTROLS.MOVE_LEFT) then
        dx = -self.speed * dt
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        dx = self.speed * dt
    end

    self.dy = self.dy + self.gravity * dt

    if wasPressedAny(CONTROLS.JUMP) and self.isOnGround then
        self.dy = self.jumpVelocity
        self.isOnGround = false
    end

    local goalX = self.x + dx
    local goalY = self.y + self.dy * dt

    local actualX, actualY, cols, len = self.world:move(self, goalX, goalY, function(item, other)
        return 'slide'
    end)

    self.isOnGround = false
    for i = 1, len do
        local col = cols[i]
        if col.normal.y < 0 then
            self.isOnGround = true
            self.dy = 0
        end
    end

    self.x, self.y = actualX, actualY
end

function Player:render()
    --is only a square
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end