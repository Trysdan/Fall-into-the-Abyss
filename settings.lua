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
sti = require 'lib/sti'
bump = require 'lib/bump'      
camera = require 'lib/camera'    

require 'src/Animation'
require 'src/StateMachine'
require 'src/Entity'
require 'src/Player'

require 'src/definitions/entity'

require 'src/states/BaseState'

require 'src/states/game/StartState'
require 'src/states/game/SelectState'
require 'src/states/game/CreditsState'
require 'src/states/game/NewState'
require 'src/states/game/ContinueState'
require 'src/states/game/PlayState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntityFallState'
require 'src/states/entity/EntityAttackState'
require 'src/states/entity/EntityDeadState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerAttackState'
require 'src/states/entity/player/PlayerDeadState'

require 'src/utilities/quads'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = VIRTUAL_WIDTH * 3
WINDOW_HEIGHT = VIRTUAL_HEIGHT * 3

OFFSET_TITLE_X = 20
OFFSET_TITLE_Y = 30

CONTROLS = {
    MOVE_UP = {'up', 'w'},
    MOVE_DOWN = {'down', 's'},
    MOVE_LEFT = {'left', 'a'},
    MOVE_RIGHT = {'right', 'd'},

    JUMP = {'space'},                
    ROLL = {'lshift', 'rshift'},    
    INTERACT = {'f'},

    ATTACK_PRIMARY = {'e'},
    ATTACK_SECONDARY = {'q'},
    
    SKILL = {'r'},

    PAUSE = {'escape', 'p'},
    INVENTORY = {'tab', 'i'},
    MAP = {'m'},
    SELECT = {'enter', 'return'},
    BACK = {'escape', 'backspace'}
}

TEXTURES = {
    ['background'] = love.graphics.newImage('assets/textures/background.png'),
    ['character'] = love.graphics.newImage('assets/textures/character/spritesheet.png')
}

FRAMES = {
    ['character'] = generateQuads(TEXTURES['character'], 32, 32)
}

FONTS = {
    ['title'] = love.graphics.newFont('assets/fonts/title.otf', 40),
    ['title-small'] = love.graphics.newFont('assets/fonts/title.otf', 24),
    ['credits'] = love.graphics.newFont('assets/fonts/credits.ttf', 10)
}

SOUNDS = {
    ['start-music'] = love.audio.newSource('assets/sounds/start_music.mp3', 'static'),
    ['switch'] = love.audio.newSource('assets/sounds/switch.mp3', 'static'),
    ['dungeon-music'] = love.audio.newSource('assets/sounds/dungeon_music.mp3', 'static')
}

function wasPressedAny(keys)
    for _, key in ipairs(keys) do
        if love.keyboard.wasPressed(key) then
            return true
        end
    end
    return false
end

function isDownAny(keys)
    for _, key in ipairs(keys) do
        if love.keyboard.isDown(key) then
            return true
        end
    end
    return false
end