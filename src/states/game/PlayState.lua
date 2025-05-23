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
    self.map = sti('assets/maps/' .. params.map .. '.lua', { 'bump' })
    self.map:bump_init(self.world)

    for _, layer in pairs(self.map.layers) do
        if layer.properties and layer.properties.collidable then
            if (self.map.bump_addLayer ~= nil) then
                self.map:bump_addLayer(layer.name)
            end
        end
    end

    self.player = Player(self.world, params.playerStartX, params.playerStartY)
end

function PlayState:update(dt)
    if wasPressedAny(CONTROLS.SELECT) then
        stateMachine:change('new')
    end
    self.player:update(dt)
    self.map:update(dt)
end

function PlayState:render()
    self.map:draw()
    self.player:render()
end