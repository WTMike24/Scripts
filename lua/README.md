# Lua Scripts

##### reactorMonitor.lua

A script I created to monitor and manage my Big Reactors reactor at a glance. Requires a setup like the screenshot below if "plug and play" operation is desired. The very minimum that must be changed is the name of the reactor on line 18. The reactor will shut down when the internal power reaches 80% and will restart when the internal power drops to 10%. If the computer powers down, the reactor will need to be restarted manually.

To have this script run automatically when the game loads, create a file called 'startup' and add the line `shell.run("reactorMonitor.lua")`. This file can be saved to your computer in game by navigating to `%YOUR MODPACK FOLDER%\saves\%SAVE NAME%\computer\%COMPUTER ID%` where computer id is the id of your computer (run the `id` command)

![Screenshot of Reactor](https://github.com/WTMike24/Scripts/blob/master/Screenshots/Scripts-Lua-reactorMonitor.png?raw=true)
