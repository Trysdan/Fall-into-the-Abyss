EntityDeadState = Class{__includes = BaseState}

function EntityDeadState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('dead')
    self.entity.dead = true
end