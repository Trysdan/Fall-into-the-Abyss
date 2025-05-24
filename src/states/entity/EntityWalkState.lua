EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('walk')
end

function EntityWalkState:enter(params)
    self.walkDuration = 3
    self.timer = 0
    self.entity.dx = self.entity.direction == 'right' and self.entity.walkSpeed or -self.entity.walkSpeed
end
function EntityWalkState:update(dt)
    self.timer = self.timer + dt

    if not self.entity.isOnGround then
        self.entity:changeState('fall')
    elseif self.timer >= self.walkDuration or self.entity.bumped then
        self.entity.direction = self.entity.direction == 'right' and 'left' or 'right'
        self.entity:changeState('idle')
    end
end