EntityJumpState = Class{__includes = BaseState}

function EntityJumpState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('jump')
    
    self.entity.dx = self.entity.direction == 'right' and self.entity.walkSpeed or -self.entity.walkSpeed
end

function EntityJumpState:update(dt)  
    if self.entity.dy > 0 then
        self.entity:changeState('fall')
    end
end