--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class PlayerIdleState for the player.
]]

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.entity = player
    self.entity:changeAnimation('idle')
    self.entity.dy = 0 --revisar luego
    self.entity.dx = 0
end

function PlayerIdleState:update(dt)
    if self.entity.dy > 0 then
        self.entity:changeState('fall')
    end
    
    if isDownAny(CONTROLS.MOVE_LEFT) or isDownAny(CONTROLS.MOVE_RIGHT) then
        if isDownAny(CONTROLS.MOVE_LEFT) then
            self.entity.direction = 'left'
        else
            self.entity.direction = 'right'
        end
        self.entity:changeState('walk')
    end

    if wasPressedAny(CONTROLS.JUMP) and self.entity.isOnGround then
        self.entity:changeState('jump')
    elseif wasPressedAny(CONTROLS.ATTACK_PRIMARY) then
        self.entity:changeState('attack')
    end
end
