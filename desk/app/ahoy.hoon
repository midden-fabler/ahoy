::  ahoy: ship monitoring
::
::    get notified if last-contact with a ship
::    exceeds a specified amount of time,
::    and when that ship is subsequently contacted
::
::  usage:
::    :ahoy|set-heartbeat ~sampel `~d1
::    :ahoy|set-heartbeat ~sampel ~
::    :ahoy|set-send-alerts |
::    :ahoy|set-run-interval ~m30
::    :ahoy|set-default-threshold ~m30
::    -ahoy!ahoy-set-heartbeats [~sampel ~sampel-palnet ~] `~h1
::    -ahoy!ahoy-set-heartbeats [~sampel ~sampel-palnet ~] ~
::
::  scrys:
::    .^((map @p (unit @da)) %gx /=ahoy=/downed/noun)
::    .^((map @p @dr) %gx /=ahoy=/heartbeats/noun)
::    .^(? %gx /=ahoy=/send-alerts/noun)
::    .^(@dr %gx /=ahoy=/run-interval/noun)
::    .^(@dr %gx /=ahoy=/default-threshold/noun)
::
/-  *ahoy, hark
/+  default-agent, dbug, rudder
/~  pages  (page:rudder records-1 command)  /app/ahoy/webui
=>
  |%
  +$  card  $+(card card:agent:gall)
  +$  versioned-state  $%(state-0 state-1)
  +$  state-0  [%0 records]
  +$  state-1  [%1 records-1]
  --
=|  state-1
=*  state  -
%-  agent:dbug
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bowl)
      cor   ~(. +> bowl)
  ++  on-init
    ^-  (quip card _this)
    :_  this
    :-  (set-timer:cor run-interval)
    [%pass /eyre %arvo %e %connect `/[dap.bowl] dap.bowl]~
  ::
  ++  on-save  !>(state)
  ++  on-load
    |=  =vase
    ^-  (quip card _this)
    =+  !<(old=versioned-state vase)
    ?-    -.old
        %0
      :-  reset-timer:cor
      this(heartbeats heartbeats.old, run-interval run-interval.old)
    ::
      %1  [reset-timer:cor this(state old)]
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    mark  (on-poke:def mark vase)
        %ahoy-command
      =+  !<(cmd=command vase)
      ?-    -.cmd
          %set-send-alerts        `this(send-alerts flag.cmd)
          %set-default-threshold  `this(default-threshold t.cmd)
      ::
          %set-heartbeat
        ?~  t.cmd
          =.  downed  (~(del by downed) ship.cmd)
          `this(heartbeats (~(del by heartbeats) ship.cmd))
        `this(heartbeats (~(put by heartbeats) ship.cmd u.t.cmd))
      ::
          %set-run-interval
        =.  run-interval  t.cmd
        [reset-timer:cor this]
      ==
    ::
        %handle-http-request
      =;  out=(quip card _+.state)
        [-.out this(+.state +.out)]
      %.  [bowl !<(order:rudder vase) +.state]
      %-  (steer:rudder _+.state command)
      :^    pages
          (point:rudder /[dap.bowl] & ~(key by pages))
        (fours:rudder +.state)
      |=  cmd=command
      ^-  $@  brief:rudder
          [brief:rudder (list card) _+.state]
      =^  cards  this
        (on-poke %ahoy-command !>(cmd))
      ['Processed succesfully.' cards +.state]
    ==
  ::
  ++  on-leave  on-leave:def
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+  path  (on-watch:def path)
      [%http-response *]  `this
    ==
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    =^  cards  state  abet:(arvo:cor wire sign-arvo)
    [cards this]
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
      [%x %downed ~]             ``noun+!>(downed)
      [%x %heartbeats ~]         ``noun+!>(heartbeats)
      [%x %send-alerts ~]        ``noun+!>(send-alerts)
      [%x %run-interval ~]       ``noun+!>(run-interval)
      [%x %default-threshold ~]  ``noun+!>(default-threshold)
    ==
  ::
  ++  on-agent
    |=  [=(pole knot) =sign:agent:gall]
    ^-  (quip card _this)
    ?+    pole  ~|(bad-agent-wire/pole !!)
        [%hark ~]  `this
        [%ping sent=@ ~]
      ?:  (~(has by downed) src.bowl)
        =^  cards  state
          abet:(handle-revived:cor src.bowl)
        [cards this]
      [~ this]
    ==
  ++  on-fail  on-fail:def
  --
=|  cards=(list card)
|_  =bowl:gall
+*  cor   .
++  abet  [(flop cards) state]
++  emit  |=(=card cor(cards [card cards]))
++  set-timer  |=(t=@dr [%pass /interval %arvo %b %wait (add t now.bowl)])
++  reset-timer
  ^-  (list card)
  (welp cancel-timers (set-timer run-interval)^~)
::
++  cancel-timers
  ^-  (list card)
  =+  [our=(scot %p our.bowl) now=(scot %da now.bowl)]
  %+  murn
    .^((list [@da duct]) %bx /[our]//[now]/debug/timers)
  |=  [t=@da =duct]
  ?~  duct  ~
  ?.  ?=([%gall %use %ahoy @ @ @ ~] i.duct)
    ~
  `[%pass t.t.t.t.t.i.duct %arvo %b %rest t]
::
++  send-ping
  |=  =ship
  ^+  cor
  ?:  =(ship our.bowl)  cor
  %-  emit
  [%pass /ping/(scot %da now.bowl) %agent [ship %ping] %poke noun+!>(~)]
::
++  arvo
  |=  [=(pole knot) =sign-arvo]
  ^+  cor
  ?+    pole  ~|([%bad-arvo-pole pole] !!)
      [%eyre ~]  cor
      [%interval ~]
    ?>  ?=([%behn %wake *] sign-arvo)
    ?^  error.sign-arvo
      %-  (slog '%ahoy %timer-error' u.error.sign-arvo)
      (emit (set-timer run-interval))
    on-interval
  ==
::
++  handle-revived
  |=  =ship
  ^+  cor
  =/  old=(unit @da)  (~(got by downed) ship)
  =.  downed          (~(del by downed) ship)
  ?.  (~(has by heartbeats) ship)
    cor
  =/  msg=cord
    %-  crip
    =/  time=tape  ?~(old "unknown" "{<`@dr`(sub now.bowl u.old)>}")
    " has been contacted. Downtime: {time}"
  (send-hark ship msg)

++  on-interval
  |^  ^+  cor
      ::  reset timer
      =.  cor  (emit (set-timer run-interval))
      =/  ships=(list ship)  ~(tap in ~(key by heartbeats))
      |-  ^+  cor
      ?~  ships
        cor
      =/  last=(unit @da)  (last-contact i.ships)
      =/  down=?  (is-down i.ships last)
      ::  revived
      =?  cor  &(!down (~(has by downed) i.ships))
        (handle-revived i.ships)
      ::  downed
      =?  cor  &(down !(~(has by downed) i.ships))
        (handle-downed i.ships last)
      ::  maybe ping
      =?  cor  !(pumping i.ships)
        (send-ping i.ships)
      $(ships t.ships)
  ::
  ++  last-contact
    |=  =ship
    ^-  (unit @da)
    =+  [our=(scot %p our.bowl) now=(scot %da now.bowl) who=(scot %p ship)]
    .^((unit @da) %ax /[our]//[now]/peers/[who]/last-contact)
  ::
  ++  is-down
    |=  [=ship last=(unit @da)]
    ^-  ?
    ?:  =(ship our.bowl)
      %|
    ?~  last
      %&
    =/  threshold=@dr  (~(got by heartbeats) ship)
    (gte `@dr`(sub now.bowl u.last) threshold)
  ::
  ++  handle-downed
    |=  [=ship last=(unit @da)]
    ^+  cor
    =.  downed  (~(put by downed) ship last)
    =/  msg=cord
      %-  crip
      =/  time=tape  ?~(last "unknown" "{<`@dr`(sub now.bowl u.last)>}")
      " has not been contacted in {time}"
    (send-hark ship msg)
  ::
  ++  pumping
    |=  =ship
    ^-  ?
    ?.  (~(has in peers) ship)
      %|
    =+  [our=(scot %p our.bowl) now=(scot %da now.bowl) ship=(scot %p ship)]
    =+  .^(=ship-state:ames %ax /[our]//[now]/peers/[ship])
    ?:  ?=([%known *] ship-state)
      %-  ~(any by snd.ship-state)
      |=  m=message-pump-state:ames
      !=(~ next-wake.packet-pump-state.m)
    ?>  ?=([%alien *] ship-state)
    ?~(messages.ship-state %| %&)
  ::
  ++  peers  ~+
    ^-  (set ship)
    =+  [our=(scot %p our.bowl) now=(scot %da now.bowl)]
    %~  key  by
    .^((map ship ?(%alien %known)) %ax /[our]//[now]/peers)
  --
::
++  send-hark
  |=  [who=ship msg=cord]
  ^+  cor
  ?.  send-alerts  cor
  ?.  .^(? %gu /(scot %p our.bowl)/hark/(scot %da now.bowl)/$)
    cor
  %-  emit
  =/  con=(list content:hark)  [ship+who msg ~]
  =/  =id:hark      (end 7 (shas %ahoy-notification eny.bowl))
  =/  =rope:hark    [~ ~ q.byk.bowl /(scot %p who)/[dap.bowl]]
  =/  =action:hark  [%add-yarn & & id rope now.bowl con /[dap.bowl] ~]
  =/  =cage         [%hark-action !>(action)]
  [%pass /hark %agent [our.bowl %hark] %poke cage]
--
