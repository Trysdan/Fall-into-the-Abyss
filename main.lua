--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Alejandro Mujica
    alejandro.j.mujic4@gmail.com

    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the framework configuration.
]]
require 'settings'

function love.load()
    love.window.setTitle("Fall into the Abyss")
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false
    })

    stateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['select'] = function() return SelectState() end,
        ['credits'] = function() return CreditsState() end,
        ['new'] = function() return NewState() end,
        ['continue'] = function() return ContinueState() end,
        ['play'] = function() return PlayState() end
    }

    stateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    stateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
        stateMachine:render()
    push:finish()
end
