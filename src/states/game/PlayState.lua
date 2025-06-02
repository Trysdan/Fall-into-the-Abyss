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
    SOUNDS['abyss']:setVolume(0.2)
    SOUNDS['abyss']:setLooping(true)
    SOUNDS['abyss']:play()
end

function PlayState:enter(params)
    -- fast reset
    self.params = params
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
        jumpVelocity = -250,
        health = 5,
        power = 5
    }

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player) end,
        ['fall'] = function() return PlayerFallState(self.player) end,
        ['attack'] = function() return PlayerAttackState(self.player) end,
        ['dead'] = function() return PlayerDeadState(self.player) end
    }
    self.player:changeState('idle')

    self.skeleton = Enemy {
        animations = ENTITY_DEFS['skeleton'].animations,
        walkSpeed = ENTITY_DEFS['skeleton'].walkSpeed,
        x = 640,
        y = 1584,
        world = self.world,
        player = self.player
    }
    self.skeleton2 = Enemy {
        animations = ENTITY_DEFS['skeleton'].animations,
        walkSpeed = ENTITY_DEFS['skeleton'].walkSpeed,
        x = 640-200,
        y = 1584,
        world = self.world,
        player = self.player
    }
    self.skeleton3 = Enemy {
        animations = ENTITY_DEFS['skeleton'].animations,
        walkSpeed = ENTITY_DEFS['skeleton'].walkSpeed,
        x = 640+200,
        y = 1584,
        world = self.world,
        player = self.player
    }
    self.boss = Enemy {
        animations = ENTITY_DEFS['goblin'].animations,
        walkSpeed = ENTITY_DEFS['goblin'].walkSpeed,
        x = 752,
        y = 1120,
        world = self.world,
        player = self.player,
        health = 20,
        power = 2
    }

    self.camera = camera()

    self.time = 0
    self.timer = 3
end 

function PlayState:update(dt)
    if self.boss.dead then
        self.time = self.time + dt
        
        if self.time > self.timer then
            stateMachine:change('win')
            return
        end
    end

    -- fast reset
    if wasPressedAny(CONTROLS.SELECT) then
        stateMachine:change('new', self.params)
    end
    -- fast dead
    if  wasPressedAny(CONTROLS.INTERACT) and not self.player.dead then
        self.player:changeState('dead')
    end

    self.player:update(dt)
    self.skeleton:update(dt)
    self.skeleton2:update(dt)
    self.skeleton3:update(dt)
    self.boss:update(dt)
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
        
        if SHOW_HITBOXES then
            self.map:bump_draw()
        end
        
        self.skeleton:render()
        self.skeleton2:render()
        self.skeleton3:render()
        self.boss:render()
        self.player:render()
    self.camera:detach()
end