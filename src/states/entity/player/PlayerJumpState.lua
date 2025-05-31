--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class PlayerJumpState for the player.
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player)
    SOUNDS['jump']:stop()
    SOUNDS['jump']:play()
    self.entity = player
    self.entity:changeAnimation('jump')
    self.entity.dy = self.entity.jumpVelocity
end

function PlayerJumpState:update(dt)
    if self.entity.dy > 0 then
        self.entity:changeState('fall')
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
