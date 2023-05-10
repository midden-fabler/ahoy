::  ahoy: ship monitoring
::
::    get notified if last-contact with a ship
::    exceeds a specified amount of time,
::    and when that ship is subsequently contacted
::
::  usage:
::    :ahoy|add-watch ~sampel ~d1
::    :ahoy|del-watch ~sampel
::    :ahoy|set-update-interval ~m30
::    -ahoy!ahoy-add-ships [~sampel ~sampel-palnet ~] ~h1
::    -ahoy!ahoy-del-ships [~sampel ~sampel-palnet ~]
::
::  scrys:
::    .^((map @p @dr) %gx /=ahoy=/watchlist/noun)
::    .^((set ship) %gx /=ahoy=/watchlist/ships/noun)
::    .^(@dr %gx /=ahoy=/update-interval/noun)
::
/-  *ahoy, hark
/+  default-agent, dbug, rudder, ahoy 
/~  pages  (page:rudder records command)  /app/ahoy/webui
=>
  |%
  +$  card  $+(card card:agent:gall)
  +$  state-0  [%0 records]
  --
=|  state-0
=*  state  -
%-  agent:dbug
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bowl)
      cor   ~(. +> [bowl ~])
  ++  on-init
    ^-  (quip card _this)
    =+  sponsor=(sein:title [our now our]:bowl)
    =^  cards  this
      (on-poke ahoy-command+!>(`command`[%add-watch sponsor ~d1]))
    :_  this
    :*  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]
        (set-timer update-interval)
        cards
    ==
  ::
  ++  on-save  !>(state)
  ++  on-load  |=(=vase `this(state !<(state-0 vase)))
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    mark  (on-poke:def mark vase)
        %ahoy-command
      =+  !<(cmd=command vase)
      ?-  -.cmd
        %set-update-interval  `this(update-interval t.cmd)
        %del-watch  `this(watchlist (~(del by watchlist) ship.cmd))
      ::
          %add-watch
        =/  ss=(unit ship-state:ames)
          (~(ship-state ahoy bowl) ship.cmd)
        ?~  ss
          ~&  >>  [%ahoy '%alien ship not added']
          [~ this]
        :-  [(send-ping:cor ship.cmd)]~
        this(watchlist (~(put by watchlist) ship.cmd t.cmd))
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
    ?+  wire  (on-arvo:def wire sign-arvo)
      [%ahoy @ ~]         [~ this]
      [%eyre %connect ~]  [~ this]
    ::
        [%update-interval ~]
      =^  cards  state  abet:on-update-interval:cor
      [cards this]
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
      [%x %watchlist ~]         ``noun+!>(watchlist)
      [%x %update-interval ~]   ``noun+!>(update-interval)
      [%x %watchlist %ships ~]  ``noun+!>(~(key by watchlist))
    ==
  ::
  ++  on-agent
    |=  [=(pole knot) =sign:agent:gall]
    ^-  (quip card _this)
    ?+  pole  ~|(bad-agent-wire/pole !!)
      [%ping @ ~]  `this
      [%yoho ~]    `this
    ::
        [%hark ~]
      ?.  ?=(%poke-ack -.sign)  (on-agent:def pole sign)
      ?~  p.sign  [~ this]
      ((slog 'ahoy: failed to notify' u.p.sign) [~ this])
    ==
  ++  on-fail   on-fail:def
  --
|_  [=bowl:gall cards=(list card)]
+*  cor   .
++  abet  [(flop cards) state]
++  emit  |=(=card cor(cards [card cards]))
++  emil  |=(caz=(list card) cor(cards (welp (flop caz) cards)))
++  set-timer
  |=  t=@dr  ^-  card
  [%pass /update-interval %arvo %b %wait (add t now.bowl)]
::
++  send-ping
  |=  =ship  ^-  card
  [%pass /ping/(scot %p ship) %agent [ship %ping] %poke noun+!>(~)]
::
++  on-update-interval
  ^+  cor
  ::  reset timer
  =.  cor  (emit (set-timer update-interval))
  ::  send pings
  =.  cor
    %-  emil
    %+  turn  ~(tap in ~(key by watchlist))
    |=(=ship (send-ping ship))
  =/  down  down-status
  ::  send notifications
  =.  cor
    %-  emil
    %-  zing
    %+  turn  ~(tap in down)
    |=(=ship (send-hark ship))
  ::  add to %yoho
  %-  emil
  %+  turn  ~(tap in down)
  |=  =ship
  =/  =cage  yoho-command+!>([%add-watch ship])
  [%pass /yoho %agent [our.bowl %yoho] %poke cage]
::
++  down-status
  ^-  (set ship)
  %-  silt
  %+  murn  ~(tap in ~(key by watchlist))
  |=  =ship
  =/  when=(unit @dr)  (~(last-contact ahoy bowl) ship)
  ?~  when  ~
  ?.  (gte u.when (~(got by watchlist) ship))
    ~
  `ship
::
++  send-hark
  |=  [who=ship]
  ^-  (list card)
  ?.  .^(? %gu /(scot %p our.bowl)/hark/(scot %da now.bowl)/$)
    ~
  =/  when=@dr  (need (~(last-contact ahoy bowl) who))
  =/  con=(list content:hark)
    =-  [ship+who - ~]
    emph+(crip " has not been contacted in {<when>}")
  =/  =id:hark      (end 7 (shas %ahoy-notification eny.bowl))
  =/  =rope:hark    [~ ~ q.byk.bowl /(scot %p who)/[dap.bowl]]
  =/  =action:hark  [%add-yarn & & id rope now.bowl con /[dap.bowl] ~]
  =/  =cage         [%hark-action !>(action)]
  [%pass /hark %agent [our.bowl %hark] %poke cage]~
--
