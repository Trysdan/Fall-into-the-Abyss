--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class PlayState for the game.
]]
PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.world = bump.newWorld(16)
    self.map = sti('assets/maps/' .. params.map .. '.lua', { 'bump' })
    self.map:bump_init(self.world)

    for _, layer in pairs(self.map.layers) do
        if layer.properties and layer.properties.collidable then
            if (self.map.bump_addLayer ~= nil) then
                self.map:bump_addLayer(layer.name)
            end
        end
    end

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        world = self.world,
        x = params.playerStartX or 64,
        y = params.playerStartY or 64,
        width = 32,
        height = 32,
        jumpVelocity = -250
    }

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player) end,
        ['fall'] = function() return PlayerFallState(self.player) end,
        ['attack'] = function() return PlayerAttackState(self.player) end,
        ['dead'] = function() return PlayerDeadState(self.player) end
    }

    self.bot = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        world = self.world,
        x = 120,
        y = 120,
        width = 32,
        height = 32,
        jumpVelocity = -250,
        gravity = 500
    }

    self.bot.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.bot) end,
        ['walk'] = function() return PlayerWalkState(self.bot) end,
        ['jump'] = function() return PlayerJumpState(self.bot) end,
        ['fall'] = function() return PlayerFallState(self.bot) end,
        ['attack'] = function() return PlayerAttackState(self.bot) end,
        ['dead'] = function() return PlayerDeadState(self.bot) end
    }

    self.bot:changeState('dead')
    self.player:changeState('idle')

    self.camera = camera()
end 

function PlayState:update(dt)
    if wasPressedAny(CONTROLS.SELECT) then
        stateMachine:change('new')
    end
    self.bot:update(dt)
    self.player:update(dt)
    self.map:update(dt)
    
    local mapWidth = self.map.width * self.map.tilewidth
    local mapHeight = self.map.height * self.map.tileheight
    
    local camX = math.max(VIRTUAL_WIDTH/2, math.min(self.player.x, mapWidth - VIRTUAL_WIDTH/2))
    local camY = math.max(VIRTUAL_HEIGHT/2, math.min(self.player.y, mapHeight - VIRTUAL_HEIGHT/2))
    
    self.camera:lookAt(camX, camY)
end

function PlayState:render()        
    self.camera:attach(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        local cx, cy = self.camera:position()        
        self.map:draw(-(cx - VIRTUAL_WIDTH/2), -(cy - VIRTUAL_HEIGHT/2), self.camera.scale, self.camera.scale)
        
        self.player:render()
        self.bot:render()
    self.camera:detach()
end