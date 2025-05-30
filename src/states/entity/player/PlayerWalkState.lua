PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity:changeAnimation('walk')
end

function PlayerWalkState:update(dt)
    self.entity.dx = 0
    
    if self.entity.dy > 0 then
        self.entity:changeState('fall')
    end

    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    else
        self.entity:changeState('idle')
    end

    if wasPressedAny(CONTROLS.JUMP) and self.entity.isOnGround then
        self.entity.dy = -self.entity.jumpVelocity
        self.entity:changeState('jump')
    elseif wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end
end