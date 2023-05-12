/-  spider, *ahoy
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ [ships=(list ship) t=(unit @dr)]] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%ahoy %set-heartbeats %done]))
;<  ~  bind:m  (poke-our:strandio %ahoy ahoy-command+!>([%set-heartbeat i.ships t]))
$(ships t.ships)
