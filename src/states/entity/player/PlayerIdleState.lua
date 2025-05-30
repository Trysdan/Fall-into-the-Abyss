PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.entity = player
    self.entity:changeAnimation('idle')
end

function PlayerIdleState:update(dt)
    if self.entity.dy > 0 then
        self.entity:changeState('fall')
    end
    
    if isDownAny(CONTROLS.MOVE_LEFT) or isDownAny(CONTROLS.MOVE_RIGHT) then
        if isDownAny(CONTROLS.MOVE_LEFT) then
            self.entity.direction = 'left'
        else
            self.entity.direction = 'right'
        end
        self.entity:changeState('walk')
    end

    if wasPressedAny(CONTROLS.JUMP) and self.entity.isOnGround then
        self.entity.dy = -self.entity.jumpVelocity
        self.entity:changeState('jump')
    elseif wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end
end
