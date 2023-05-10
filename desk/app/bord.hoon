::  bord: ship monitoring
::
::    breach notifications
::
::  usage:
::    :bord|add-watch ~sampel
::    :bord|del-watch ~sampel
::    -ahoy!bord-add-ships [~sampel ~sampel-palnet ~]
::    -ahoy!bord-del-ships [~sampel ~sampel-palnet ~]
::
::  scrys:
::    .^((set ship) %gx /=bord=/watchlist/noun)
::
/-  *bord, hark
/+  default-agent, 
    rudder,
    dbug
/~  pages  (page:rudder records command)  /app/bord/webui
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
    [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]~
  ++  on-save  !>(state)
  ++  on-load  |=(=vase `this(state !<(state-0 vase)))
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    mark  (on-poke:def mark vase)
        %bord-command
      =+  !<(cmd=command vase)
      ?-    -.cmd
          %add-watch
        :_  this(watchlist (~(put in watchlist) ship.cmd))
        [%pass /breach %arvo %j %public-keys (sy [ship.cmd]~)]~
      ::
          %del-watch
        :_  this(watchlist (~(del in watchlist) ship.cmd))
        [%pass /breach %arvo %j %nuke (sy [ship.cmd]~)]~
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
        (on-poke %bord-command !>(cmd))
      ['Processed succesfully.' cards +.state]
    ==
  ::
  ++  on-leave  on-leave:def
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+    path  (on-watch:def path)
      [%http-response *]  `this
    ==
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?+    wire  (on-arvo:def wire sign-arvo)
        [%eyre %connect ~]  [~ this]
        [%breach ~]
      ?>  ?=([%jael %public-keys *] sign-arvo)
      ?.  ?=(%breach -.public-keys-result.sign-arvo)
        [~ this]
      :_  this
      (send-notification:hc who.public-keys-result.sign-arvo)
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
      [%x %watchlist ~]  ``noun+!>(watchlist)
    ==
  ::
  ++  on-agent
    |=  [=(pole knot) =sign:agent:gall]
    ^-  (quip card _this)
    ?+    pole  ~|(bad-agent-wire/pole !!)
        [%hark ~]
      ?.  ?=(%poke-ack -.sign)  (on-agent:def pole sign)
      ?~  p.sign  [~ this]
      ((slog 'bord: failed to notify' u.p.sign) [~ this])
    ==
  ++  on-fail   on-fail:def
  --
|_  =bowl:gall
++  send-notification
  |=  [who=ship]
  ^-  (list card)
  ?.  .^(? %gu /(scot %p our.bowl)/hark/(scot %da now.bowl)/$)
    ~
  =/  con=(list content:hark)  [ship+who emph+' has sunk' ~]
  =/  =id:hark      (end 7 (shas %bord-notification eny.bowl))
  =/  =rope:hark    [~ ~ q.byk.bowl /(scot %p who)/[dap.bowl]]
  =/  =action:hark  [%add-yarn & & id rope now.bowl con /[dap.bowl] ~]
  =/  =cage         [%hark-action !>(action)]
  [%pass /hark %agent [our.bowl %hark] %poke cage]~
--
