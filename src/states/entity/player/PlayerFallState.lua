PlayerFallState = Class{__includes = EntityFallState}

function PlayerFallState:init(entity, world)
    self.entity = entity
    self.world = world
    self.entity:changeAnimation('fall')
end

function PlayerFallState:update(dt)
    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    if wasPressedAny(CONTROLS.JUMP) and self.entity.dobleJump then
        self.entity.dy = -self.entity.jumpVelocity
        self.entity:changeState('jump')
    elseif wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end
    
    EntityFallState.update(self, dt)
end
