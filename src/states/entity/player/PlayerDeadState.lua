PlayerDeadState = Class{__includes = BaseState}

function PlayerDeadState:init(player)
    SOUNDS['dead']:stop()
    SOUNDS['dead']:play()
    self.entity = player
    self.entity:changeAnimation('dead')
    self.entity.dead = true
    self.entity.currentAnimation.looping = false
end