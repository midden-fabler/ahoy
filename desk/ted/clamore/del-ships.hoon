/-  spider, *clamore
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ ships=(list ship)] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%clamore %del-ships %done]))
;<  ~  bind:m  (poke-our:strandio %clamore clamore-command+!>([%del-watch i.ships]))
$(ships t.ships)
