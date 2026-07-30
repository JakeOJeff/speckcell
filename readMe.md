# SpeckCell

A particle based 2 dimensioned terrarium system which works on the concept of real life cell systems.

## How does it work?

Each grid has a particle object assigned to it. These particle objects have three main helper functions based on its surroundings
 - **collide** : what should happen when it collides with another particle
 - **target** : what kind of target lock-on should be initiated ( finding other particles )
 - **movement** : what way the particle should move ( randomized or irregular )

Other than these vital properties, it also has other factors which makes it lifelike. Tweaking it makes it showcase different outputs and behaviours!


## How to use!

Enter the simulation after the loading ends. Press **Left Mouse Butotn** to start infection ( A random infection is assigned) and **Right Mouse Butotn** to place sturdy blocks ( These do not have a feature other than freeze a few surrounding particles sometimes ). Press '**Middle Mouse Button**' to restart the simulation.
