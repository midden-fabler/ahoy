/-  spider, *ahoy
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ ships=(list ship)] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%ahoy %del-ships %done]))
;<  ~  bind:m  (poke-our:strandio %ahoy ahoy-command+!>([%del-watch i.ships]))
$(ships t.ships)
