/-  spider, *bord
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ [ships=(list ship)]] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%bord %add-ships %done]))
;<  ~  bind:m  (poke-our:strandio %bord bord-command+!>([%add-watch i.ships]))
$(ships t.ships)
