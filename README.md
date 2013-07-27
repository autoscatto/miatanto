miatanto
========
crap utility for awesome 3.5

---


eclipsemc.lua
-

Simple vicious widget for [Eclipse Mining Consortium](https://eclipsemc.com/) user information.
The widget uses the API offered by EclipseMC to live show account status and workers data.


**Install**

```sh
git clone https://github.com/autoscatto/miatanto.git
cp eclipsemc.lua $viciuswidgetsdir [mine is in ~/.config/awesome/vicious/widgets]
luarocks install luasec
luarocks install luajson (or install lua-json and lua-sec with your distro packet manager)
profit
```

**Config**

register standard vicious widget, the only parameter to specify is the API key provided by EclipseMC

> es: vicious.register(eclipse, vicious.widgets.eclipsemc, "CR:${CR} UR:${UR} ER:${ER} TP:${TP} BF:${BF}", 5, APIKEY )

you can use this general account info format:

> "{CR}": confirmed reward
> "{UR}": unconfirmed reward
> "{ER}": estimated reward
> "{TP}": total payout
> "{BF}": blocks found

for the details relating to worker (substitute *workername* with existing worker name):

> "{workername.hash_rate}":       hash rate
> "{workername.round_shares}":    round shares
> "{workername.reset_shares}":    reset shares
> "{workername.total_shares}":    total shares
> "{workername.last_activity}":   last activity

es: i want confirmed reward, total payout, and hash rate of my worker named *Giorgio*

    vicious.register(eclipse, vicious.widgets.eclipsemc, "confimed: ${CR} payout: ${TP} Giorgio hashrate: ${Giorgio.hash_rate}", 3, APIKEY )

simple.





License
=========

```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2013 Romain Lespinasse <romain.lespinasse@gmail.com>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
