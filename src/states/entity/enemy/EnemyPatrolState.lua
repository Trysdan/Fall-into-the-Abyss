--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class EnemyPatrolState for the enemies.
]]

EnemyPatrolState = Class{__includes = BaseState}

function EnemyPatrolState:init(enemy)
    self.entity = enemy
    self.timer = 0
    self.duration = math.random(2, 4)
    self.entity:changeAnimation('walk')
end

function EnemyPatrolState:update(dt)
    self.timer = self.timer + dt

    self.entity.dx = 0

    if self.timer >= self.duration or self.entity:willFallNextStep(dt) or self.entity.bumped then
        self.entity.direction = self.entity.direction == 'right' and 'left' or 'right'
        self.entity.bumped = false
        self.entity:changeState('idle')
    end
    
    if self.entity:isPlayerInVision() then
        self.entity:changeState('chase')
    else
        self.entity.dx = self.entity.direction == 'left' and -self.entity.walkSpeed or self.entity.walkSpeed
    end
end
