# g3pd - Gen 3 Pokemon Display

## What?

This script allows streamers to display their current party to their viewers.

## Setup

1. Get [Viusal Boy Advanced Rerecording](https://github.com/TASVideos/vba-rerecording/releases) if you don't already use it.

2. [Get the latest version of g3pd](https://github.com/PeachIceTea/g3pd/archive/master.zip).

3. Get sprites you like. I used [these](https://veekun.com/dex/downloads). Sprites have the following additional requirements:

    3.1 A "0.png" that matches the dimensions of the other sprites, but is emtpy.

    3.2 An "egg.png" for, well, eggs.

4. Extract g3pd into its own folder.

5. Extract the sprites into the "sprites" folder.

6. Use a text editor to set the game in the "SetGameInHere.lua" file. 1 for Emerald, 2 for FireRed/LeafGreen, and 3 for Dark Rising.

7. Run VBA and when the game is loaded, load the script from Tools/Lua Scripting/New Lua Script Window...

8. Add the png files in the "party" folder to your OBS overlay.
