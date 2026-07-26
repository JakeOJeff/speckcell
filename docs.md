This function toggles infection on/off with a mouse click:

love.mousepressed fires whenever a mouse button is pressed, giving you the click coordinates x, y and which button was pressed.
if button == 1 checks for a left-click specifically (button 2 would be right-click, 3 middle-click, etc.).
enableInfection = not enableInfection flips a boolean flag each time you left-click — so clicking once turns it on, clicking again turns it off.
The loop then goes through every particle in your particles table, and for any particle whose type is "ants", it sets v.collidable to match enableInfection (true if infection is enabled, false otherwise).

So the net effect: left-clicking anywhere on the window toggles whether ants are "collidable" — which, looking at your love.update, controls whether an ant's onCollide callback (the actual infection-spreading logic, spreadColor for the infected particle) gets triggered when it touches another particle. Before you click, ants wander around ignoring each other; after you click, collisions between ants and the infected particle start actually spreading the infection.

One thing worth flagging: only particles of type == "ants" get collidable toggled — the "infected" particle's collidable field is never set at all in createParticle (it defaults to false and stays that way). That's fine as long as the infected particle is always the thing being collided into rather than the one initiating collision checks, but it's worth double-checking that your collision logic in love.update doesn't depend on the infected particle also being collidable in some code path.