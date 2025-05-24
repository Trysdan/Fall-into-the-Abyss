PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('jump')
    self.entity.dy = self.entity.jumpVelocity
end

function PlayerJumpState:update(dt)
    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    if wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end

    EntityJumpState.update(self, dt)
end
