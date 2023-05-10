/-  spider, *yoho
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ [ships=(list ship)]] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%yoho %add-ships %done]))
;<  ~  bind:m  (poke-our:strandio %yoho yoho-command+!>([%add-watch i.ships]))
$(ships t.ships)
