--[[
    Author: Ramón Belandria

    WorldManager

    This class is used to manage the the templates for rooms and corridors.
]]

WorldManager = Class{}

function WorldManager:init()
    self.world = bump.newWorld(16)
    self.loadedChunks = {rooms = {}, corridors = {}}
    self.activeChunks = {rooms = {}, corridors = {}}
    self.chunkSize = {}
end

function MoveMapTo(map, x, y)
    for _, layer in pairs(map.layers) do
        layer.x = x
        layer.y = y
    end
end

function WorldManager:loadRoom(room)
    if self.loadedChunks.rooms[room.index] then
        self.activeChunks.room[room.index] = self.loadedChunks[room.index]
        return
    end

    local chunkPattern = 'assets/maps/rooms/' .. room.type .. '.lua'

    if not love.filesystem.getInfo(chunkPattern) then
        return
    end
    local map = sti(chunkPattern, {'bump'})
    local wX, wY = room.x * 16, room.y * 16
    self.moveMap(map, wX, wY*16)
    map:bump_init(self.world)
    for _, layer in pairs(map.layers) do
        if layer.properties and layer.properties.collidable then
            if map.bump_addLayer ~= nil then
                map:bump_addLayer(layer.name)
            end
        end
    end
    self.loadedChunks.rooms[room.index] = {
        map = map,
        x = room.x,
        y = room.y,
        worldX = wX,
        worldY = wY,
    }
    self.activeChunks.rooms[room.index] = self.loadedChunks[room.index]
end

function WorldManager:unloadRoom(roomIndex)
    if self.activeChunks.rooms[roomIndex] then
        self.activeChunks.rooms[roomIndex] = nil
    end
end