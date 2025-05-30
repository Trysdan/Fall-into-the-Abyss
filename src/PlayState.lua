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
    self.world = bump.newWorld(64)
    --[[self.map = sti('assets/maps/' .. params.map .. '.lua', { 'bump' })
    self.map:bump_init(self.world)

    for _, layer in pairs(self.map.layers) do
        if layer.properties and layer.properties.collidable then
            if (self.map.bump_addLayer ~= nil) then
                self.map:bump_addLayer(layer.name)
            end
        end
    end]]

    self.map1 = sti('assets/maps/normal.lua', { 'bump' })
    self.map1:bump_init(self.world)
    for _, layer in pairs(self.map1.layers) do
        layer.x = 432
        layer.y = 32
    end
    
    for _, layer in pairs(self.map1.layers) do
        if layer.properties and layer.properties.collidable then
            if (self.map1.bump_addLayer ~= nil) then
                self.map1:bump_addLayer(layer.name)
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
        jumpVelocity = -200,
        gravity = 500
    }

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player, self.world) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.world) end,
        ['jump'] = function() return PlayerJumpState(self.player, self.world) end,
        ['fall'] = function() return PlayerFallState(self.player, self.world) end,
        ['attack'] = function() return PlayerAttackState(self.player, self.world) end,
        ['dead'] = function() return PlayerDeadState(self.player, self.world) end
    }

    self.player:changeState('idle')
    
    self.camera = camera()
end

function PlayState:update(dt)
    if wasPressedAny(CONTROLS.SELECT) then
        stateMachine:change('new')
    end
    self.player:update(dt)
    --self.map:update(dt)
    self.map1:update(dt)
    self.camera:lookAt(self.player.x, self.player.y)
end

function PlayState:render()
    --self.map:draw()
    self.map1:draw()
    self.map1:bump_draw()
    self.player:render()
end