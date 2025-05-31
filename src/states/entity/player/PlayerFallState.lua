PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:init(player)
    self.entity = player
    self.entity:changeAnimation('fall')
end

function PlayerFallState:update(dt)
    if self.entity.isOnGround then
        SOUNDS['landing']:stop()
        SOUNDS['landing']:play()
        if math.abs(self.entity.dx) > 0 then
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end

    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    if wasPressedAny(CONTROLS.JUMP) and self.entity.dobleJump then
        self.entity:changeState('jump')
        self.entity.dobleJump = false
    elseif wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end
end
