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

    self.stateMachine = StateMachine(def.states or {})
    
    self.direction = 'right'

    self.animations = self:createAnimations(def.animations or {})
    self.currentAnimation = def.currentAnimation or self.animations['idle']

    self.x = def.x or 0
    self.y = def.y or 0
    self.width = def.width or 16
    self.height = def.height or 32
    
    self.dx = 0
    self.dy = 0
    
    self.hitbox = {
        x = self.x + 6,
        y = self.y + 4,
        width = 16,
        height = 28,
        offsetX = 6,
        offsetY = 4
    }

    self.updateHitbox(self)
    self.world:add(self, self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)

    self.walkSpeed = def.walkSpeed or 120
    self.jumpVelocity = def.jumpVelocity or GRAVITY/3

    self.health = def.health or 1

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0

    self.dead = false
    
    self.bumped = false
    self.isOnGround = false
    self.dobleJump = true
end

function Entity:createAnimations(animations)
    local result = {}
    for k, animDef in pairs(animations) do
        result[k] = Animation {
            texture = animDef.texture,
            frames = animDef.frames,
            interval = animDef.interval,
            looping = animDef.looping or true,
            collisionBoxes = animDef.collisionBoxes
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
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    self.stateMachine:update(dt)
    
    self:updatePosition(dt)
    
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:updatePosition(dt)
    self:updateHitbox()
    
    if not self.isOnGround then
        self.dy = self.dy + GRAVITY * dt
    end

    local goalX = self.x + self.dx * dt
    local goalY = self.y + self.dy * dt

    self.world:update(self, self.hitbox.x, self.hitbox.y, 
                     self.hitbox.width, self.hitbox.height)

    local actualX, actualY, cols, len = self.world:move(
        self, 
        goalX,
        goalY + self.hitbox.offsetY,
        function(other) return 'slide' end
    )
    
    self.x = actualX
    self.y = actualY - self.hitbox.offsetY

    self.isOnGround = false
    self.bumped = false

    for i = 1, len do
        local col = cols[i]
        
        if col.normal.y == -1 then
            self.isOnGround = true
            self.dobleJump = true
            self.dy = 0
        elseif col.normal.y == 1 then
            self.dy = 0
        end
        
        if col.normal.x ~= 0 then
            self.bumped = true
            self.dx = 0
        end
    end
end

function Entity:updateHitbox()
    local box = getEntityCollisionBox(self)
    self.hitbox = {
        x = self.x,
        y = self.y + box.y,
        width = box.width,
        height = box.height,
        offsetX = box.x,
        offsetY = box.y
    }
end

function Entity:render()
    -- draw sprite slightly transparent if invulnerable every 0.06 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 64))
    end

    local anim = self.currentAnimation
    local frameIndex = anim:getCurrentFrame()
    local box = getEntityCollisionBox(self)

    local scaleX = self.direction == 'right' and 1 or -1
    local offsetX = self.direction == 'right' and box.x or -(box.width + box.x)
    
    self:updateHitbox()

    love.graphics.draw(
        TEXTURES[anim.texture],
        FRAMES[anim.texture][frameIndex],
        math.floor(self.x - offsetX),
        math.floor(self.y),
        0, scaleX, 1
    )

    if SHOW_HITBOXES then
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
        love.graphics.rectangle('line', self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))            
    end
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end