--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Alejandro Mujica
    alejandro.j.mujic4@gmail.com
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the game settings that include dependencies, constants of values to set
    up the game, sounds, textures, frames, and fonts.
]]
Class = require 'lib/class'
push = require 'lib/push'

require 'src/StateMachine'

require 'src/states/BaseState'

require 'src/states/game/StartState'


VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

OFFSET_TITLE_X = 20
OFFSET_TITLE_Y = 30

TEXTURES = {
    ['background'] = love.graphics.newImage('assets/textures/background.png')
}

FRAMES = {}

FONTS = {
    ['title'] = love.graphics.newFont('assets/fonts/title.otf', 40),
    ['title-small'] = love.graphics.newFont('assets/fonts/title.otf', 24)
}

SOUNDS = {
    ['start-music'] = love.audio.newSource('assets/sounds/start_music.mp3', 'static')
}
