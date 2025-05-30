PlayerDeadState = Class{__includes = BaseState}

function PlayerDeadState:init(player)
    self.entity = player
    self.entity:changeAnimation('dead')
    self.entity.dead = true
    self.entity.currentAnimation.looping = false
end