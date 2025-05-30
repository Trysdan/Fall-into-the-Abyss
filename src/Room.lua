--[[
    Author: Ramón Belandria

    Room class
    This class represents a room inside a graph
]]

Room = Class{}

RoomDimensions = {}
RoomDimensions["normal"] = {}
RoomDimensions["normal"]["width"] = 20
RoomDimensions["normal"]["length"] = 20
RoomDimensions["entrance"] = {}
RoomDimensions["entrance"]["width"] = 30
RoomDimensions["entrance"]["length"] = 20
RoomDimensions["exit"] = {}
RoomDimensions["exit"]["width"] = 16
RoomDimensions["exit"]["length"] = 7

RoomExits = {}
RoomExits["normal"] = {"topLeft","bottomLeft","bottomRight"}
RoomExits["entrance"] = {"right"}
RoomExits["exit"] = {"left","right"}

ExitOffsets = {}
ExitOffsets["normal"] = {}
ExitOffsets["normal"]["topLeft"] = {x = 2, y = 1}
ExitOffsets["normal"]["bottomLeft"] = {x = -1, y = 14}
ExitOffsets["normal"]["bottomRight"] = {x = 20, y = 14}
ExitOffsets["entrance"] = {}
ExitOffsets["entrance"]["right"] = {x = 30, y = 3}
ExitOffsets["exit"] = {}
ExitOffsets["exit"]["left"] = {x = -1, y = 1}
ExitOffsets["exit"]["right"] = {x = 16, y = 1}


function Room:init(params)
    self.x = params.x
    self.y = params.y
    self.type = params.roomtype
    self.usedExits = {}
    for index, value in ipairs(RoomExits[params.type]) do
        self.usedExits[value] = false
    end
    self.index = params.index
end

function Room:getWidth()
    return RoomDimensions[self.type]["width"]
end

function Room:getLength()
    return RoomDimensions[self.type]["length"]
end