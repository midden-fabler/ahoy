/-  spider, *clamore
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ [ships=(list ship)]] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%clamore %add-ships %done]))
;<  ~  bind:m  (poke-our:strandio %clamore clamore-command+!>([%add-watch i.ships]))
$(ships t.ships)
