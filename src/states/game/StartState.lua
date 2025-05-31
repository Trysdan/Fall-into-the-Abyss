--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class StartState for the game.
]]
StartState = Class{__includes = BaseState}
local options = { 'play', 'credits', 'quit game' }

function StartState:init()
    SOUNDS['start']:setVolume(0.2)
    SOUNDS['start']:setLooping(true)
    SOUNDS['start']:play()
    self.option = 1
end

function StartState:update(dt)
    if wasPressedAny(CONTROLS.MOVE_UP) and self.option > 1 then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()
        self.option = self.option - 1
        
    elseif wasPressedAny(CONTROLS.MOVE_DOWN) and self.option < 3 then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()
        self.option = self.option + 1
       
    elseif wasPressedAny(CONTROLS.SELECT) then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()
        if self.option == 1 then
            stateMachine:change('select')
        elseif self.option == 2 then
            stateMachine:change('credits')
        else
            love.event.quit()
        end
    end
end

function StartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0,
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())

    love.graphics.setFont(FONTS['title'])
    
    love.graphics.setColor(love.math.colorFromBytes(34, 34, 34, 255))
    love.graphics.printf('Fall into the', OFFSET_TITLE_X + 2, OFFSET_TITLE_Y + 2, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Abyss', OFFSET_TITLE_X + 12, OFFSET_TITLE_Y + 32, VIRTUAL_WIDTH, 'left')
    
    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf('Fall into the', OFFSET_TITLE_X, OFFSET_TITLE_Y, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Abyss', OFFSET_TITLE_X + 10, OFFSET_TITLE_Y + 30, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(FONTS['title-small'])

    for i, label in ipairs(options) do
        local yOffset = VIRTUAL_HEIGHT / 2 + 16 + (i - 1) * 24
        love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))
        love.graphics.printf(label, OFFSET_TITLE_X + 1, yOffset + 1, VIRTUAL_WIDTH, 'left')

        if self.option == i then
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 0, 255))
        else
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
        end
        love.graphics.printf(label, OFFSET_TITLE_X, yOffset, VIRTUAL_WIDTH, 'left')
    end
end