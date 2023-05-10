/-  spider, *ahoy
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ [ships=(list ship) t=@dr]] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%ahoy %add-ships %done]))
;<  ~  bind:m  (poke-our:strandio %ahoy ahoy-command+!>([%add-watch i.ships t]))
$(ships t.ships)
