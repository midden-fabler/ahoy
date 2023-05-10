/-  spider, *yoho
/+  strandio
^-  thread:spider
|=  arg=vase
=+  !<([~ ships=(list ship)] arg)
=/  m  (strand:rand ,vase)
|-  ^-  form:m
?~  ships  (pure:m !>([%yoho %del-ships %done]))
;<  ~  bind:m  (poke-our:strandio %yoho yoho-command+!>([%del-watch i.ships]))
$(ships t.ships)
