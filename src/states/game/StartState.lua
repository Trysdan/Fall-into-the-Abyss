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

function StartState:init()
    SOUNDS['start-music']:setVolume(0.3)
    SOUNDS['start-music']:setLooping(true)
    SOUNDS['start-music']:play()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    end
end

function StartState:render()
    love.graphics.draw(TEXTURES['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / TEXTURES['background']:getWidth(),
        VIRTUAL_HEIGHT / TEXTURES['background']:getHeight())
    
    love.graphics.setFont(FONTS['title'])
    
    love.graphics.setColor(love.math.colorFromBytes(34, 34, 34, 255))
    love.graphics.printf('Fall into the', OFFSET_TITLE_X + 2, OFFSET_TITLE_Y + 2, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Abyss', OFFSET_TITLE_X + 10 + 2, OFFSET_TITLE_Y + 30 + 2, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(love.math.colorFromBytes(175, 53, 42, 255))
    love.graphics.printf('Fall into the', OFFSET_TITLE_X, OFFSET_TITLE_Y, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Abyss', OFFSET_TITLE_X + 10, OFFSET_TITLE_Y + 30, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(FONTS['title-small'])
        
    love.graphics.setColor(love.math.colorFromBytes(0, 0, 0, 255))
    love.graphics.printf('play', OFFSET_TITLE_X + 1, VIRTUAL_HEIGHT / 2 + 16 + 1, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('option', OFFSET_TITLE_X + 1, VIRTUAL_HEIGHT / 2 + 40 + 1, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('quit game', OFFSET_TITLE_X + 1, VIRTUAL_HEIGHT / 2 + 64 + 1, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    love.graphics.printf('play', OFFSET_TITLE_X, VIRTUAL_HEIGHT / 2 + 16 , VIRTUAL_WIDTH, 'left')
    love.graphics.printf('option', OFFSET_TITLE_X, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('quit game', OFFSET_TITLE_X, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'left')
end