# luaprettyprint
## What's this ?
luaprettyprint is a simple and small library to pretty print tables in lua.

It handles "recursive" tables and all that kind of shenenigans.

It also displays colors !

## Alright, but what does it look like ?
See by yourself:

![Screenshot](screenshot.png?raw=true)
## That looks great ! How do I use it ?
Simply download prettyprint.lua and put it in the same folder as your script (er somewhere in your package.path).

Then add something like `local prettyprint = require("prettyprint")` at the beginning of your file, then just call `prettyprint.pprint(yourtable)` and there you go !

To add colors just add as a second argument `true`

Tadaaa you're done !
## Cool ! Can I use it in my project ?
This is distributed under MIT Licence, which means you can do pretty much anything with my code as long as you write somewhere that I did this original code and you copy that license (read LICENSE for more info)
