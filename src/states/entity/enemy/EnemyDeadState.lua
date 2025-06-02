--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class EnemyDeadState for the enemies.
]]

EnemyDeadState = Class{__includes = BaseState}

function EnemyDeadState:init(enemy)
    SOUNDS['dead']:stop()
    SOUNDS['dead']:play()
    self.entity = enemy
    self.entity:changeAnimation('dead')
    self.entity.currentAnimation.looping = false
    self.entity.dx = 0
end