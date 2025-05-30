PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player)
    self.entity = player
    self.entity:changeAnimation('attack')
    self.attackDuration = 0.5
    self.timer = 0
end

function PlayerAttackState:update(dt)
    self.entity.dx = 0
    
    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    self.timer = self.timer + dt
    if self.timer >= self.attackDuration then  
        self.entity:changeState('idle')      
    end
end
