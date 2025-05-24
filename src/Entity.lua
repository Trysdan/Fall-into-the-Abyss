--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class Entity.
]]
Entity = Class{}

function Entity:init(def)
    self.world = def.world
    self.x = def.x or 0
    self.y = def.y or 0
    self.dx = 0
    self.dy = 0

    self.width = def.width or 16
    self.height = def.height or 32

    self.walkSpeed = def.walkSpeed or 60
    self.jumpVelocity = def.jumpVelocity or -200
    self.gravity = def.gravity or 500

    self.health = def.health or 1
    self.invulnerable = false
    self.invulnerableTimer = 0
    self.invulnerableDuration = 0

    self.dead = false

    self.stateMachine = StateMachine(def.states or {})
    self.animations = self:createAnimations(def.animations or {})
    self.currentAnimation = {
        frames = {25, 26, 27, 28, 29, 30},
        interval = 0.2,
        texture = 'character'
    }

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.direction = 'right'
    
    self.bumped = false
    self.isOnGround = false
    self.dobleJump = false
    self.world:add(self, self.x, self.y, self.width, self.height)
end

function Entity:createAnimations(animations)
    local result = {}
    for k, animDef in pairs(animations) do
        result[k] = Animation {
            texture = animDef.texture,
            frames = animDef.frames,
            interval = animDef.interval,
            looping = animDef.looping or true
        }
    end
    return result
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:changeState(state)
    self.stateMachine:change(state)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
    
    self:updatePosition(dt)
    
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
    
    if self.invulnerable then
        self.invulnerableTimer = self.invulnerableTimer + dt
        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
        end
    end
end

function Entity:updatePosition(dt)
    if not self.isOnGround then
        self.dy = self.dy + self.gravity * dt
    end

    local goalX = self.x + self.dx * dt
    local goalY = self.y + self.dy * dt

    local actualX, actualY, cols, len = self.world:move(
        self, 
        goalX, 
        goalY, 
        function(other) return 'slide' end
    )
    self.x, self.y = actualX, actualY

    self.isOnGround = false
    self.bumped = false

    for i = 1, len do
        local col = cols[i]
        
        if col.normal.y ~= 0 then
            self.isOnGround = col.normal.y == -1
            self.dobleJump = self.isOnGround
            self.dy = 0
        end
        
        if col.normal.x ~= 0 then
            self.bumped = true
            self.dx = 0
        end
    end
end

function Entity:render()
    local anim = self.currentAnimation
    local scaleX = self.direction == 'left' and -1 or 1
    local offsetX = self.direction == 'left' and self.width or 0

    love.graphics.draw(
        TEXTURES[anim.texture],
        FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.x - self.offsetX + offsetX),
        math.floor(self.y - self.offsetY),
        0, scaleX, 1
    )
end

function Entity:collides(target)
    return not (
        self.x + self.width < target.x or self.x > target.x + target.width or
        self.y + self.height < target.y or self.y > target.y + target.height
    )
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end