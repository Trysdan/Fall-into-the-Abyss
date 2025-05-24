EntityAttackState = Class{__includes = BaseState}

function EntityAttackState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('attack')
end