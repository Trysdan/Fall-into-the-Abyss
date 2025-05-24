EntityFallState = Class{__includes = BaseState}

function EntityFallState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('fall')
end

function EntityFallState:update(dt)
    if self.entity.isOnGround then
        if math.abs(self.entity.dx) > 0 then
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end
end