--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

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

    local swordbox = {
        offsetX = 12,
        offsetY = 0,
        width = 20,
        height = 28
    }

    if self.entity.direction == 'left' then
        self.entity.attackBox = {
            x = self.entity.x - swordbox.offsetX,
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
    self.frameAttack = 3
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

    if not self.didAttack and (self.frameAttack == self.entity.currentAnimation.currentFrame) then
        self:performAttack()
        self.didAttack = true
    end

    if self.timer >= self.attackDuration then
        if self.entity.dy > 0 then
            self.entity:changeState('fall')
        else
            self.entity:changeState('idle')
        end
    end
end

function PlayerAttackState:performAttack()
    local targets, len = self.entity.world:queryRect(
        self.entity.attackBox.x, self.entity.attackBox.y,
        self.entity.attackBox.w, self.entity.attackBox.h,
        function(item)
            return item.isEnemy
        end
    )

    for i = 1, len do
        local enemy = targets[i]
        self.entity:attack(enemy)
    end
end