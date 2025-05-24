--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.

    This file contains the definition for entities.
]]
ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        animations = {
            ['attack'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.1,
                looping = false,
                texture = 'character'
            },
            ['dead'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                looping = false,
                texture = 'character'
            },
            ['fall'] = {
                frames = {17, 18, 19},
                interval = 0.2,
                texture = 'character'
            },
            ['idle'] = {
                frames = {25, 26, 27, 28, 29, 30},
                interval = 0.2,
                texture = 'character'
            },
            ['jump'] = {
                frames = {33, 34},
                interval = 0.25,
                texture = 'character'
            },
            ['walk'] = {
                frames = {41, 42, 43, 44, 45, 46, 47},
                interval = 0.15,
                texture = 'character'
            }
        }
    }
}
