--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class EnemyIdleState for the enemies.
]]

EnemyIdleState = Class{__includes = BaseState}

function EnemyIdleState:init(enemy)
    self.entity = enemy
    self.timer = 0
    self.duration = math.random(1, 2)
    self.entity:changeAnimation('idle')
end

function EnemyIdleState:update(dt)
    self.timer = self.timer + dt

    self.entity.dx = 0
    if self.entity:isPlayerInVision() then
        self.entity:changeState('chase')
        return
    end

    if self.timer >= self.duration then
        self.entity:changeState('patrol')
    end
end

