--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class EnemyAttackState for the player.
]]

EnemyAttackState = Class{__includes = BaseState}

function EnemyAttackState:init(enemy)
    SOUNDS['sword']:stop()
    SOUNDS['sword']:play()
    self.entity = enemy
    self.attackCooldown = 0
    self.attackInterval = 1.5
    self.entity:changeAnimation('attack')
    self.entity.dx = 0
    self.entity.dy = 0

    local swordbox = {
        offsetX = 15,
        offsetY = 1,
        width = 28,
        height = 36
    }

    if self.entity.direction == 'left' then
        self.entity.attackBox = {
            x = self.entity.x - swordbox.offsetX - swordbox.width/2,
            y = self.entity.y + swordbox.offsetY,
            w = swordbox.width,
            h = swordbox.height
        }
    else
        self.entity.attackBox = {
            x = self.entity.x + swordbox.offsetX - 6,
            y = self.entity.y + swordbox.offsetY,
            w = swordbox.width,
            h = swordbox.height
        }
    end
    self.didAttack = false
    self.frameAttack = 8
end

function EnemyAttackState:update(dt)
    self.attackCooldown = self.attackCooldown + dt

    if not self.entity:isPlayerInAttackRange() then
        self.entity:changeState('chase')
        return
    end

    self.entity.direction = self.entity.player.x < self.entity.x and 'left' or 'right'

    if not self.didAttack and (self.frameAttack == self.entity.currentAnimation.currentFrame) then
        self:performAttack()
        self.didAttack = true
    end

    if self.attackCooldown >= self.attackInterval then
        self.entity:changeState('idle')
    end
end

function EnemyAttackState:performAttack()
    local targets, len = self.entity.world:queryRect(
        self.entity.attackBox.x, self.entity.attackBox.y,
        self.entity.attackBox.w, self.entity.attackBox.h,
        function(item)
            return item.isPlayer
        end
    )

    for i = 1, len do
        local player = targets[i]
        self.entity:attack(player)
    end
end