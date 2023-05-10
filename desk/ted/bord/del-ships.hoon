/-  spider, *bord
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ ships=(list ship)] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%bord %del-ships %done]))
;<  ~  bind:m  (poke-our:strandio %bord bord-command+!>([%del-watch i.ships]))
$(ships t.ships)
