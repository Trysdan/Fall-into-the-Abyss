--[[
    ISPPV1 2024
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.

    Adapted by Jesus Diaz (jdanieldp99@gmail.com) for "Fall into the Abyss" - ULA Game Dev Class 2025

    This file contains the definition for entities.
]]
ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 120,
        animations = {
            ['attack'] = {
                frames = {1, 2, 3, 4, 5, 6},
                interval = 0.08,
                looping = false,
                texture = 'character',
                collisionBoxes = {
                    {x = 6, y = 5, width = 12, height = 27},
                    {x = 6, y = 5, width = 12, height = 27},
                    {x = 6, y = 5, width = 12, height = 27},
                    {x = 6, y = 5, width = 12, height = 27},
                    {x = 6, y = 5, width = 12, height = 27},
                    {x = 6, y = 5 , width = 12, height = 27}
                    --{x = 6, y = 5, width = 14, height = 27},
                    --{x = 6, y = 5, width = 14, height = 27} 
                }
            },
            ['dead'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                looping = false,
                texture = 'character',
                collisionBoxes = {
                    {x = 6, y = 4, width = 12, height = 28},
                    {x = 6, y = 6, width = 12, height = 26},
                    {x = 3, y = 21, width = 25, height = 11},
                    {x = 0, y = 24, width = 30, height = 8}
                }
            },
            ['fall'] = {
                frames = {17, 18, 19},
                interval = 0.2,
                texture = 'character',
                collisionBoxes = {
                    {x = 6, y = 1, width = 14, height = 31},
                    {x = 6, y = 1, width = 14, height = 31},
                    {x = 6, y = 0, width = 14, height = 32}
                }
            },
            ['idle'] = {
                frames = {25, 26, 27, 28, 29, 30},
                interval = 0.15,
                texture = 'character',
                collisionBoxes = {
                    {x = 6, y = 1, width = 12, height = 31},
                    {x = 6, y = 1, width = 12, height = 31},
                    {x = 6, y = 2, width = 12, height = 30},
                    {x = 6, y = 2, width = 12, height = 30},
                    {x = 6, y = 2, width = 12, height = 30},
                    {x = 6, y = 1, width = 12, height = 31}
                }
            },
            ['jump'] = {
                frames = {33, 34},
                interval = 0.2,
                texture = 'character',
                collisionBoxes = {
                    {x = 6, y = 1, width = 14, height = 31},
                    {x = 6, y = 1, width = 14, height = 27}
                }
            },
            ['walk'] = {
                frames = {41, 42, 43, 44, 45, 46, 47},
                interval = 0.1,
                texture = 'character',
                collisionBoxes = {
                    {x = 4, y = 2, width = 16, height = 30},
                    {x = 4, y = 3, width = 16, height = 29},
                    {x = 4, y = 3, width = 16, height = 29},
                    {x = 6, y = 4, width = 16, height = 28},
                    {x = 8, y = 3, width = 16, height = 29},
                    {x = 6, y = 3, width = 16, height = 29},
                    {x = 4, y = 2, width = 16, height = 30}
                }
            }
        }
    },
    ['skeleton'] = {
        walkSpeed = 60,

        animations = {
            ['attack'] = {
                texture = 'skeleton_attack',
                frames = {
                    1, 2, 3, 4, 5, 6, 7, 8, 9,
                    10, 11, 12, 13, 14, 15, 16, 17, 18
                },
                interval = 0.08,
                looping = false,
                collisionBoxes = {
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24},
                    {x = 5, y = 13, width = 9, height = 24}
                }
            },
            ['dead'] = {
                texture = 'skeleton_dead',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10,
                    11, 12, 13, 14, 15
                },
                interval = 0.1,
                looping = false,
                collisionBoxes = {
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 6, width = 20, height = 26},
                    {x = 5, y = 25, width = 20, height = 7},
                    {x = 5, y = 25, width = 20, height = 7},
                    {x = 5, y = 25, width = 20, height = 7}
                }
            },
            ['idle'] = {
                texture = 'skeleton_idle',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10, 11
                },
                interval = 0.15,
                collisionBoxes = {
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25}
                }
            },
            ['walk'] = {
                texture = 'skeleton_walk',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10, 11, 12, 13
                },
                interval = 0.05,
                collisionBoxes = {
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25},
                    {x = 2, y = 8, width = 9, height = 25}
                }
            }
        }
    },
    ['goblin'] = {
        walkSpeed = 80,

        animations = {
            ['attack'] = {
                texture = 'goblin_attack',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10, 11
                },
                interval = 0.08,
                looping = false,
                collisionBoxes = {
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 26, y = 30, width = 20, height = 38},
                }
            },
            ['dead'] = {
                texture = 'goblin_die',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10, 11
                },
                interval = 0.1,
                looping = false,
                collisionBoxes = {
                    {x = 26, y = 30, width = 20, height = 38},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 36, width = 37, height = 31},
                    {x = 14, y = 55, width = 42, height = 12},
                    {x = 14, y = 55, width = 42, height = 12},
                    {x = 14, y = 55, width = 42, height = 12},
                }
            },
            ['idle'] = {
                texture = 'goblin_idle',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9
                },
                interval = 0.15,
                collisionBoxes = {
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                }
            },
            ['walk'] = {
                texture = 'goblin_walk',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9
                },
                interval = 0.15,
                collisionBoxes = {
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                }
            },
            ['run'] = {
                texture = 'goblin_run',
                frames = {
                    1, 2, 3, 4, 5,
                    6, 7, 8, 9, 10, 11
                },
                interval = 0.08,
                collisionBoxes = {
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                    {x = 26, y = 29, width = 20, height = 38},
                }
            }
        }
    }
}

-- Auxiliary function to obtain the collision box according to the current frame
function getEntityCollisionBox(entity)
    local currentAnim = entity.currentAnimation
    local defaultBox = {x = 6, y = 2, width = 12, height = 30}

    --to deactivate custom collisions
    if CONST_COLLISION then
        return defaultBox
    end
    
    if not currentAnim or not currentAnim.collisionBoxes then
        return defaultBox
    end
    
    local frameIndex = currentAnim.currentFrame or 1
    return currentAnim.collisionBoxes[frameIndex] 
           or currentAnim.collisionBoxes[1] 
           or defaultBox
end