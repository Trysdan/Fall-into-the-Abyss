EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity, world)
    self.entity = entity
    self.world = world
    self.waitDuration = 2
    self.timer = 0
    self.dx = 0
    self.entity:changeAnimation('idle')
end

function EntityIdleState:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.waitDuration then
        self.entity:changeState('walk')
    end
end
