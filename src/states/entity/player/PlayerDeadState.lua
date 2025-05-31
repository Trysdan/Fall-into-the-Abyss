--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class PlayerDeadState for the player.
]]

PlayerDeadState = Class{__includes = BaseState}

function PlayerDeadState:init(player)
    SOUNDS['dead']:stop()
    SOUNDS['dead']:play()
    self.entity = player
    self.entity:changeAnimation('dead')
    self.entity.dead = true
    self.entity.currentAnimation.looping = false
end