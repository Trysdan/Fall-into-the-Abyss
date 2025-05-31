--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class NewState for the game.
]]
NewState = Class{__includes = BaseState}

function NewState:init()
    SOUNDS['intro']:setVolume(0.2)
    SOUNDS['intro']:setLooping(true)
    SOUNDS['intro']:play()

    self.paragraphs = {
        "Era un día como cualquier otro en la vida de un herrero.\n"..
        "Después de una semana de trabajo, los fines de semana\n"..
        "los pasaba con sus amigos, bebiendo y contemplando\n"..
        "esa vista espectacular cerca del borde del abismo.",
        
        "Su mejor amigo, como siempre, lo acompañaba.\n"..
        "Juntos reían y recordaban viejas historias mientras\n"..
        "el sol se ponía sobre el precipicio. La vida era\n"..
        "simple pero satisfactoria para un hombre como él.",
        
        "Pero ese día... algo salió mal. Un resbalón, un grito,\n"..
        "y luego... oscuridad. Cuando despertó, no recordaba\n"..
        "cómo había llegado allí. Solo sabía que debía\n"..
        "encontrar el camino de regreso a casa.",
        
        "En su viaje a través de este lugar desconocido,\n"..
        "tendrá que descubrir no solo el camino a casa,\n"..
        "sino también qué fue lo que realmente sucedió\n"..
        "ese fatídico día en el borde del abismo."
    }
    
    self.currentParagraph = 1
    self.enterMessage = "Presiona ENTER para comenzar tu viaje..."
end

function NewState:exit()
    SOUNDS['intro']:stop()
end

function NewState:update(dt)
    if wasPressedAny(CONTROLS.MOVE_LEFT) and self.currentParagraph > 1 then
        self.currentParagraph = self.currentParagraph - 1

    elseif wasPressedAny(CONTROLS.MOVE_RIGHT) and self.currentParagraph < 4 then
        self.currentParagraph = self.currentParagraph + 1

    elseif wasPressedAny(CONTROLS.SELECT) then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()

        stateMachine:change('play', {
            map = 'entrance',
            playerStartX = 64,
            playerStartY = 64
        })
    end
end
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))

function NewState:render()
    love.graphics.setFont(FONTS['text'])
    
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
    love.graphics.printf(self.paragraphs[self.currentParagraph], 
                        0, 
                        VIRTUAL_HEIGHT/2 - 60,
                        VIRTUAL_WIDTH, 
                        'center')
    
    local arrows = ""
    if self.currentParagraph == 1 then
        arrows = ">"
    elseif self.currentParagraph == 4 then
        arrows = "<"
    else
        arrows = "< >"
    end
    
    love.graphics.printf(arrows, 0, VIRTUAL_HEIGHT/2 + 40, VIRTUAL_WIDTH, 'center')
    
    love.graphics.printf(self.enterMessage, 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
end