PlayerDeadState = Class{__includes = EntityDeadState}

function PlayerDeadState:init(player)
    self.entity = player
    self.entity:changeAnimation('dead')
    self.entity.dead = true
end
