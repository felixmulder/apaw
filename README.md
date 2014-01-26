Awesome Pulseaudio Widget Text
==============================
A widget using Mokasin's pulesaudio library for lua.


Clone this repo in your .config/awesome dir and add this to your rc.lua:

```
local APWT = require("apwt/widget")
...
right_layout:add(APWT)
...
awful.key({}, "XF86AudioRaiseVolume", APWT.Up),
awful.key({}, "XF86AudioLowerVolume", APWT.Down),
...
```
