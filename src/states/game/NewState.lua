--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class NewState for the game.
]]
    
NewState = Class{__includes = BaseState}

function NewState:init()
    self.introText = {
        "Hace mucho tiempo, una oscuridad cayó sobre el mundo.",
        "Solo tú puedes enfrentarte al abismo.",
        "",
        "Presiona ENTER para comenzar tu viaje..."
    }
end

function NewState:update(dt)
    if wasPressedAny(CONTROLS.SELECT) then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()

        stateMachine:change('play', {
            map = 'entrance',
            playerStartX = 64,
            playerStartY = 64
        })
    end
end

function NewState:render()
    love.graphics.setFont(FONTS['credits'])
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    for i, line in ipairs(self.introText) do
        love.graphics.printf(line, 0, 100 + (i - 1) * 30, VIRTUAL_WIDTH, 'center')
    end
end