--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class CreditsState for the game.
]]
CreditsState = Class{__includes = BaseState}

function CreditsState:init()
    self.credits = {
        "CREDITS",
        "",
        "DEVELOPMENT",
        "Jesus Diaz",
        "Ramon Belandria",
        "",
        "SPECIAL THANKS",
        "Prof. Alejandro Mujica",
        "",
        "ASSETS",
        "Music: Kaden_Cook (Pixabay)",
        "Background: Google AI Tools",
        "Font: The Legend of the Princess"
    }
end

function CreditsState:update(dt)
    if wasPressedAny(CONTROLS.SELECT) then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()
        stateMachine:change('start')
    end
end

function CreditsState:render()
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

    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))
    love.graphics.printf('back', OFFSET_TITLE_X + 1, VIRTUAL_HEIGHT / 2 + 64+ 1, VIRTUAL_WIDTH, 'left')
    
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 0, 255))
    love.graphics.printf('back', OFFSET_TITLE_X, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(FONTS['credits'])
    
    local y_offset = VIRTUAL_HEIGHT / 4 + 10

    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))
    for i, text in ipairs(self.credits) do
        love.graphics.printf(text, OFFSET_TITLE_X + 1, y_offset + (i * 9) + 1, VIRTUAL_WIDTH, 'center')
    end
    
    for i, text in ipairs(self.credits) do
        if i == 3 or i == 7 or i == 10 then
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 0, 255))
        else
            love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
        end
        love.graphics.printf(text, OFFSET_TITLE_X, y_offset + (i * 9), VIRTUAL_WIDTH, 'center')
    end
end