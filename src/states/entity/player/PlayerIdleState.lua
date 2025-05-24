PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('idle')
end

function PlayerIdleState:update(dt)
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
