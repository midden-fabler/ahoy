::  yoho: ship monitoring
::
::    get notified when a ship is contacted
::
::  usage:
::    :yoho|add-watch ~sampel
::    :yoho|del-watch ~sampel
::    -ahoy!yoho-add-ships [~sampel ~sampel-palnet ~]
::    -ahoy!yoho-del-ships [~sampel ~sampel-palnet ~]
::
::  scrys:
::    .^((set ship) %gx /=yoho=/watchlist/noun)
::
/-  *yoho, hark
/+  default-agent, 
    rudder,
    dbug,
    yoho 
/~  pages  (page:rudder records command)  /app/yoho/webui
=>
  |%
  +$  card  card:agent:gall
  +$  versioned-state  $%(state-0)
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
    [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]~
  ++  on-save  !>(state)
  ++  on-load
    |=  =vase
    ^-  (quip card _this)
    =+  !<(old=versioned-state vase)
    =/  cards=(list card)
      %+  turn  ~(tap in watchlist)
      |=(=ship (send-ping ship))
    [cards this(state old)]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    mark  (on-poke:def mark vase)
        %yoho-command
      =+  !<(cmd=command vase)
      ?-    -.cmd
          %add-watch
        :-  [(send-ping:hc ship.cmd)]~
        this(watchlist (~(put in watchlist) ship.cmd))
      ::
          %del-watch
        `this(watchlist (~(del in watchlist) ship.cmd))
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
        (on-poke %yoho-command !>(cmd))
      ['Processed succesfully.' cards +.state]
    ==
  ::
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
      [%eyre %connect ~]  [~ this]
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
      [%x %watchlist ~]  ``noun+!>(watchlist)
    ==
  ::
  ++  on-leave  on-leave:def
  ++  on-agent
    |=  [=(pole knot) =sign:agent:gall]
    ^-  (quip card _this)
    ?+    pole  ~|(bad-agent-wire/pole !!)
        [%yoho ship=@ ~]
      =/  =ship  (slav %p ship.pole)
      ?.  (~(has in watchlist) ship)
        [~ this]
      :-  (send-notification:hc ship)
      this(watchlist (~(del in watchlist) ship))
    ::
        [%hark ~]
      ?.  ?=(%poke-ack -.sign)  (on-agent:def pole sign)
      ?~  p.sign  [~ this]
      ((slog 'yoho: failed to notify' u.p.sign) [~ this])
    ==
  ++  on-fail   on-fail:def
  --
=|  cards=(list card)
|_  =bowl:gall
++  send-ping
  |=  =ship  ^-  card
  [%pass /yoho/(scot %p ship) %agent [ship %ping] %poke noun+!>(~)]
::
++  send-notification
  |=  [who=ship]
  ^-  (list card)
  ?.  .^(? %gu /(scot %p our.bowl)/hark/(scot %da now.bowl)/$)  ~
  =/  con=(list content:hark)
    =-  [ship+who - ~]
    ' has been hailed successfully'
  =/  =id:hark      (end 7 (shas %yoho-notification eny.bowl))
  =/  =rope:hark    [~ ~ q.byk.bowl /(scot %p who)/[dap.bowl]]
  =/  =action:hark  [%add-yarn & & id rope now.bowl con /[dap.bowl] ~]
  =/  =cage         [%hark-action !>(action)]
  [%pass /hark %agent [our.bowl %hark] %poke cage]~
--
