PlayerAttackState = Class{__includes = EntityAttackState}

function PlayerAttackState:init(player)
    self.entity = player
    self.entity:changeAnimation('attack')
    self.attackDuration = 0.8
    self.timer = 0
end

function PlayerAttackState:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.attackDuration then
        self.entity:changeState('idle')
    end
end
