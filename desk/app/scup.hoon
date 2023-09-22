::  scup: ship maintenance
::
::    schedule a recurring pack and meld
::
::  usage:
::    :scup|add-watch our ~d1 ~h8.m30  ::  every day @ 08:30 UTC
::    :scup|del-watch our
::    :scup %now
::    :scup %next
::
::  scrys:
::    .^((map ship schedule) %gx /=scup=/watchlist/noun)
::    .^((set ship) %gx /=scup=/watchlist/keys/noun)
::    .^((unit @da) %gx /=scup=/next/(scot %p ~zod)/noun)
::
/-  *scup
/+  default-agent,
    rudder,
    dbug,
    scup
/~  pages  (page:rudder records command)  /app/scup/webui
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
      hc    ~(. +> bowl)
  ++  on-init
    ^-  (quip card _this)
    :_  this
    [%pass /eyre/connect %arvo %e %connect `/[dap.bowl] dap.bowl]~
  ++  on-save  !>(state)
  ++  on-load  |=(=vase `this(state !<(state-0 vase)))
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    mark  (on-poke:def mark vase)
        %noun
      ?+    q.vase  (on-poke:def mark vase)
          %now
        =^  cards  state  abet:(on-scup:hc our.bowl)
        [cards this]
      ::
          %next
        =/  next=(unit @da)  (~(next scup bowl) our.bowl)
        ~&  >  [%scup %next %da ?~(next ~ u.next)]
        ~&  >  [%scup %next %dr ?~(next ~ `@dr`(sub u.next now.bowl))]
        [~ this]
      ==
    ::
        %scup-command
      =+  !<(cmd=command vase)
      ?-    -.cmd
          %add-watch
        |^  ?>  =(our.bowl ship.cmd)
            =/  =schedule
              [(freq freq.cmd) (hhmm hhmm.cmd)]
            =.  watchlist  (~(put by watchlist) ship.cmd schedule)
            :_  this
            (make-appt:hc ship.cmd)
        ::  days from @dr
        ::
        ++  freq
          |=  days=@dr
          ^-  tarp
          =/  minimum-days=@ud  1
          =|  freq=tarp
          freq(d (max d:(yell days) minimum-days))
        ::  hours and minutes from @dr
        ::
        ++  hhmm
          |=  clock=@dr
          ^-  tarp
          =/  c=tarp  (yell clock)
          =|  hhmm=tarp
          hhmm(h h.c, m m.c)
        --
      ::
          %del-watch
        :-  (cancel-appt:hc ship.cmd)
        this(watchlist (~(del by watchlist) ship.cmd))
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
        (on-poke %scup-command !>(cmd))
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
    |=  [=(pole knot) =sign-arvo]
    ^-  (quip card _this)
    ?+    pole  (on-arvo:def pole sign-arvo)
        [%eyre %connect ~]  [~ this]
        [%scup ship=@ ~]
      =/  =ship  (slav %p ship.pole)
      ?.  (~(has by watchlist) ship)  
        [~ this]
      =^  cards  state  abet:(on-scup:hc ship)
      [cards this]
    ==
  ::
  ++  on-peek
    |=  =(pole knot)
    ^-  (unit (unit cage))
    ?+    pole  (on-peek:def pole)
        [%x %watchlist ~]        ``noun+!>(watchlist)
        [%x %watchlist %keys ~]  ``noun+!>(~(key by watchlist))
        [%x %next ship=@ ~]
      =/  =ship  (slav %p ship.pole)
      ``noun+!>((~(next scup bowl) ship))
    ==
  ::
  ++  on-agent
    |=  [=(pole knot) =sign:agent:gall]
    ^-  (quip card _this)
    ?+  pole  ~|(bad-agent-wire/pole !!)
      [%hood ~]  `this
    ==
  ++  on-fail   on-fail:def
  --
=|  cards=(list card)
|_  =bowl:gall
+*  cor   .
++  abet  [(flop cards) state]
++  emit  |=(=card cor(cards [card cards]))
++  emil  |=(caz=(list card) cor(cards (welp (flop caz) cards)))
::  pack, meld, and schedule next occurrence
::
++  on-scup
  |=  =ship
  ^+  cor
  =.  cor  (emil (make-appt ship))
  =.  cor  (emit [%pass /hood %agent [ship %hood] %poke helm-pack+!>(~)])
  (emit [%pass /hood %agent [ship %hood] %poke helm-meld+!>(~)])
::
++  make-appt
  |=  =ship
  ^-  (list card)
  =/  until=@da  (next-appt ship)
  %+  welp
    (cancel-appt ship)
  [%pass /scup/(scot %p ship) %arvo %b %wait until]~
::
++  next-appt
  |=  who=ship
  ^-  @da
  =/  =schedule  (~(got by watchlist) who)
  =|  =tarp
  %-  yule
  %=  tarp
    d  (add d:(yell now.bowl) d.freq.schedule)
    h  h.hhmm.schedule
    m  m.hhmm.schedule
  ==
::
++  cancel-appt
  |=  who=ship
  ^-  (list card)
  %+  murn
    .^  (list [@da duct])
      %bx
      /(scot %p our.bowl)//(scot %da now.bowl)/debug/timers
    ==
  |=  [t=@da =duct]
  ?~  duct  ~
  ?.  ?=([%gall %use %scup @ @ @ @ ~] i.duct)
    ~
  `[%pass t.t.t.t.t.i.duct %arvo %b %rest t]
--
