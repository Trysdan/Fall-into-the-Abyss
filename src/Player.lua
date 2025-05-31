--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.

    This file contains the class PLayer.
]]
Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)

    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end