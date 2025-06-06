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
Graphs = require 'lib/luagraphs/data/graph'    
Room = require 'src/Room'
Corridor = require 'src/Corridor'
Dungeon = require 'src/Dungeon'
WorldManager = require 'src/WorldManager'

require 'src/Animation'
require 'src/StateMachine'
require 'src/Entity'
require 'src/Player'
require 'src/Enemy'

require 'src/definitions/entity'

require 'src/states/BaseState'

require 'src/states/game/StartState'
require 'src/states/game/SelectState'
require 'src/states/game/CreditsState'
require 'src/states/game/NewState'
require 'src/states/game/ContinueState'
require 'src/states/game/PlayState'
require 'src/states/game/WinState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerAttackState'
require 'src/states/entity/player/PlayerDeadState'

require 'src/states/entity/enemy/EnemyAttackState'
require 'src/states/entity/enemy/EnemyChaseState'
require 'src/states/entity/enemy/EnemyIdleState'
require 'src/states/entity/enemy/EnemyPatrolState'
require 'src/states/entity/enemy/EnemyDeadState'

require 'src/utilities/quads'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = VIRTUAL_WIDTH * 3
WINDOW_HEIGHT = VIRTUAL_HEIGHT * 3

OFFSET_TITLE_X = 20
OFFSET_TITLE_Y = 30

GRAVITY = 500

--------DEBUG---------
SHOW_HITBOXES = false
CONST_COLLISION = false
----------------------

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
    ['character'] = love.graphics.newImage('assets/textures/character/spritesheet.png'),
    ['skeleton_attack'] = love.graphics.newImage('assets/textures/enemies/skeleton_attack.png'),
    ['skeleton_dead'] = love.graphics.newImage('assets/textures/enemies/skeleton_dead.png'),
    ['skeleton_idle'] = love.graphics.newImage('assets/textures/enemies/skeleton_idle.png'),
    ['skeleton_walk'] = love.graphics.newImage('assets/textures/enemies/skeleton_walk.png'),
    ['goblin_attack'] = love.graphics.newImage('assets/textures/enemies/goblin/goblin_attack.png'),
    ['goblin_die'] = love.graphics.newImage('assets/textures/enemies/goblin/goblin_die.png'),
    ['goblin_idle'] = love.graphics.newImage('assets/textures/enemies/goblin/goblin_idle.png'),
    ['goblin_run'] = love.graphics.newImage('assets/textures/enemies/goblin/goblin_run.png'),
    ['goblin_walk'] = love.graphics.newImage('assets/textures/enemies/goblin/goblin_walk.png')
}

FRAMES = {
    ['character'] = generateQuads(TEXTURES['character'], 32, 32),
    ['skeleton_attack'] = generateQuads(TEXTURES['skeleton_attack'], 43, 37),
    ['skeleton_dead'] = generateQuads(TEXTURES['skeleton_dead'], 33, 32),
    ['skeleton_idle'] = generateQuads(TEXTURES['skeleton_idle'], 24, 32),
    ['skeleton_walk'] = generateQuads(TEXTURES['skeleton_walk'], 22, 32),
    ['goblin_attack'] = generateQuads(TEXTURES['goblin_attack'], 70, 70),
    ['goblin_die'] = generateQuads(TEXTURES['goblin_die'], 70, 70),
    ['goblin_idle'] = generateQuads(TEXTURES['goblin_idle'], 70, 70),
    ['goblin_run'] = generateQuads(TEXTURES['goblin_run'], 70, 70),
    ['goblin_walk'] = generateQuads(TEXTURES['goblin_walk'], 70, 70)
}

FONTS = {
    ['title'] = love.graphics.newFont('assets/fonts/title.otf', 40),
    ['title-small'] = love.graphics.newFont('assets/fonts/title.otf', 24),
    ['credits'] = love.graphics.newFont('assets/fonts/credits.ttf', 10),
    ['text'] = love.graphics.newFont('assets/fonts/credits.ttf', 12)
}

SOUNDS = {
    ['start'] = love.audio.newSource('assets/sounds/start.mp3', 'static'),
    ['intro'] = love.audio.newSource('assets/sounds/intro.mp3', 'static'),
    ['switch'] = love.audio.newSource('assets/sounds/switch.mp3', 'static'),
    ['abyss'] = love.audio.newSource('assets/sounds/abyss.mp3', 'static'),
    ['landing'] = love.audio.newSource('assets/sounds/landing.mp3', 'static'),
    ['jump'] = love.audio.newSource('assets/sounds/jump.mp3', 'static'),
    ['dead'] = love.audio.newSource('assets/sounds/dead.mp3', 'static'),
    ['sword'] = love.audio.newSource('assets/sounds/sword.mp3', 'static')
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