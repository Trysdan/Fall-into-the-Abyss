--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.
    
    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the class WinState for the game.
]]
WinState = Class{__includes = BaseState}

function WinState:init()
    SOUNDS['intro']:setVolume(0.2)
    SOUNDS['intro']:setLooping(true)
    SOUNDS['intro']:play()

    self.paragraphs = {
        "Finalmente, frente a los restos del enemigo derrotado,\n"..
        "una luz familiar brilló en la distancia. Era el mismo\n"..
        "borde del abismo donde todo comenzó, ahora bañado\n"..
        "por los primeros rayos del amanecer.",

        "Los recuerdos regresaron en un torrente: la caída,\n"..
        "el miedo, pero también la fuerza que no sabía\n"..
        "que poseía. Cada herida, cada batalla, había sido\n"..
        "un paso más en este viaje de regreso.",

        "Con las manos aún temblorosas por el combate,\n"..
        "recogió el martillo de herrero que lo acompañó\n"..
        "durante toda la aventura. Ahora no era solo\n"..
        "una herramienta, sino un símbolo de su supervivencia.",

        "El camino a casa estaba claro ahora, y con él,\n"..
        "la verdad de aquel día. No fue un accidente,\n"..
        "sino el comienzo de una prueba que lo transformó\n"..
        "en alguien más fuerte, más sabio... más vivo."
    }
    
    self.currentParagraph = 1
    self.enterMessage = "Presiona ENTER para volver al inicio"
end

function WinState:exit()
    SOUNDS['intro']:stop()
end

function WinState:update(dt)
    if wasPressedAny(CONTROLS.MOVE_LEFT) and self.currentParagraph > 1 then
        self.currentParagraph = self.currentParagraph - 1

    elseif wasPressedAny(CONTROLS.MOVE_RIGHT) and self.currentParagraph < 4 then
        self.currentParagraph = self.currentParagraph + 1

    elseif wasPressedAny(CONTROLS.SELECT) then
        SOUNDS['switch']:stop()
        SOUNDS['switch']:play()

        stateMachine:change('start', {
            map = 'entrance',
            playerStartX = 64,
            playerStartY = 64
        })
    end
end
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))

function WinState:render()
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