local lpp = require("prettyprint")

tab = {a={1,2,3}, b=1, c=print, d="text"}

lpp.print(tab)
print("And now with colors !")
lpp.print(tab,true)

