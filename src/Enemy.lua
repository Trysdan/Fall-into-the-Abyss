--[[
    Fall into the Abyss (Platformer)

    Author: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class Enemy for the enemies.
]]

Enemy = Class{__includes = Entity}

function Enemy:init(def)
    Entity.init(self, def)
    self.player = def.player
    self.health = 1

    self.visionRange = def.visionRange or 100
    self.attackRange = def.attackRange or 32

    self.isEnemy = true

    self.stateMachine = StateMachine {
        ['idle'] = function() return EnemyIdleState(self) end,
        ['patrol'] = function() return EnemyPatrolState(self) end,
        ['chase'] = function() return EnemyChaseState(self) end,
        ['attack'] = function() return EnemyAttackState(self) end,
        ['dead'] = function() return EnemyDeadState(self) end
    }

    self:changeState('idle')
end

function Enemy:update(dt)
    Entity.update(self, dt)
end

function Enemy:render()
    Entity.render(self)
    if SHOW_HITBOXES then
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
        love.graphics.rectangle('line', self.attackBox.x, self.attackBox.y, self.attackBox.w, self.attackBox.h)
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    end
end

function Enemy:isPlayerInVision()
    if self.player.dead then
        return false
    end

    local dx = self.player.x - self.x
    
    if math.abs(dx) > self.visionRange then
        return false
    end
    
    if (dx <= 0 and self.direction == 'left') or (dx >= 0 and self.direction == 'right') then
        return true
    end
    
    return false
end

function Enemy:isPlayerInAttackRange()
    local dx = math.abs(self.player.x - self.x)
    return dx <= self.attackRange and not self.player.dead
end

function Enemy:willFallNextStep(dt)
    local futureX = self.x + self.dx * dt

    local checkX
    if self.dx > 0 then
        checkX = futureX + self.hitbox.offsetX + self.hitbox.width
    else
        checkX = futureX + self.hitbox.offsetX
    end

    local checkY = self.y + self.hitbox.offsetY + self.hitbox.height + 1

    local items, len = self.world:queryRect(
        -- small margin to avoid precision errors
        checkX - 1, checkY - 1,
        2, 2,
        function(item)
            return item ~= self
        end
    )
    return len == 0
end