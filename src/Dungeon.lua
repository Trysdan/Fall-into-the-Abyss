--[[
    Author: Ramón Belandria

    Room class
    This class contains all the rules to insert and storage the rooms and corridors
    inside a graph.
]]

Dungeon = Class{}

function Dungeon:init()
    self.graph = Graphs
end

function Dungeon:insertRoom(x,y,roomtype)
    self.graph.addVertexIfNotExists(self.graph:vertexCount(),Room {
        x = x,
        y = y,
        roomtype = roomtype,
        index = self.graph.vertexCount
    })
end

function Dungeon:isRoomInsertable(room, x, y)
end

function Dungeon:insertCorridor(fromIndex, toIndex, fromExit, toExit)
    local corridor = Corridor{
        from = self.graph.vertexAt(fromIndex),
        to = self.graph.vertexAt(toIndex),
        fromExit = fromExit,
        toExit = toExit
    }
    self.graph:addEdge(fromIndex, toIndex, corridor)
    self.graph.vertexAt(fromIndex).usedExits[fromExit] = true
    self.graph.vertexAt(toIndex).usedExits[toExit] = true
end