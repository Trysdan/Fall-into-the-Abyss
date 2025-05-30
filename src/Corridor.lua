--[[
    Author: Ramón Belandria

    Corridor class
    This class represents the corridors that connect two neighbor rooms.
    It is designated to go inside the arcs of the Level Graph
]]

Corridor = Class{}

function Corridor:init(params)
    self.from = params.from
    self.to = params.to
    self.x = ExitOffsets[self.from.type][params.fromExit].x + self.from.x
    local destinyX = ExitOffsets[self.to.type][params.toExit].x + self.to.x
    if self.x > destinyX then
        self.x, destinyX = destinyX, self.x
    end
    self.y = ExitOffsets[self.from.type][params.fromExit].y + self.from.y
    local destinyY = ExitOffsets[self.to.type][params.toExit].y + self.to.y
    if self.y > destinyY then
        self.y, destinyY = destinyY, self.y
    end
    self.width = destinyX - self.x + 1
    self.height = destinyY - self.y + 1
    if self.width == 1 then
        self.type = "vertical"
        self.width = 5
    elseif self.height == 1 then
        self.type = "horizontal"
        self.height = 7
    end
end