--[[
    ISPPV1 2025
    Study Case: Fall into the Abyss (Platformer)

    Based on: Super Martian (Platformer)
    Author: Alejandro Mujica (alejandro.j.mujic4@gmail.com)

    Adapted by: Jesus Diaz (jdanieldp99@gmail.com)
    For ULA Game Dev Class 2025

    This file contains the class PlayerAttackState for the player.
]]
PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player)
    SOUNDS['sword']:stop()
    SOUNDS['sword']:play()
    self.entity = player
    self.entity:changeAnimation('attack')
    self.attackDuration = 0.5
    self.timer = 0
end

function PlayerAttackState:update(dt)
    self.entity.dx = 0
    
    if isDownAny(CONTROLS.MOVE_LEFT) then
        self.entity.direction = 'left'
        self.entity.dx = -self.entity.walkSpeed
    elseif isDownAny(CONTROLS.MOVE_RIGHT) then
        self.entity.direction = 'right'
        self.entity.dx = self.entity.walkSpeed
    end

    self.timer = self.timer + dt
    if self.timer >= self.attackDuration then
        if self.entity.dy > 0 then
            self.entity:changeState('fall')
        else
            self.entity:changeState('idle')    
        end
    end
end
