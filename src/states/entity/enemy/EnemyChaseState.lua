--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class EnemyChaseState for the enemies.
]]

EnemyChaseState = Class{__includes = BaseState}

function EnemyChaseState:init(enemy)
    self.entity = enemy
    self.entity:changeAnimation('walk')
end

function EnemyChaseState:update(dt)

    if not self.entity:isPlayerInVision() then
        self.entity:changeState('idle')
        return
    end

    if self.entity.player.x < self.entity.x then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    else
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    if self.entity.player.y + self.entity.player.height < self.entity.y and self.entity.isOnGround then
        self.entity.dy = -self.entity.jumpVelocity
        self.entity.isOnGround = false
    end

    if self.entity:isPlayerInAttackRange() then
        self.entity:changeState('attack')
    end
end
