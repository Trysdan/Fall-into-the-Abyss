PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('walk')
end

function PlayerWalkState:update(dt)
    self.entity.dx = 0

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

    EntityWalkState.update(self, dt)
end