::  clamore: ping timer
::
::  usage:
::    :clamore|add-watch ~sampel
::    :clamore|del-watch ~sampel
::    -ahoy!clamore-add-ships [~sampel ~sampel-palnet ~]
::    -ahoy!clamore-del-ships [~sampel ~sampel-palnet ~]
::
::  scrys:
::    .^((map ship [@da (unit @da)]) %gx /=clamore=/watchlist/noun)
::
/-  *clamore
/+  default-agent, dbug, rudder
/~  pages  (page:rudder records command)  /app/clamore/webui
=>
  |%
  +$  card  $+(card card:agent:gall)
  +$  state-0  [%0 records]
  --
=|  state-0
=*  state  -
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]~
::
++  on-save  !>(state)
++  on-load  |=(=vase `this(state !<(state-0 vase)))
++  on-poke
  |=  [=mark =vase]
  ?>  =(our src):bowl
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %clamore-command
    =+  !<(cmd=command vase)
    ?-    -.cmd
        %del-watch  `this(watchlist (~(del by watchlist) ship.cmd))
        %add-watch
      =/  ss
        .^  ship-state:ames
          %ax
          /(scot %p our.bowl)//(scot %da now.bowl)/peers/(scot %p ship.cmd)
        ==
      ?.  ?=([%known *] ss)  [~ this]
      =.  watchlist  (~(put by watchlist) ship.cmd [now.bowl ~])
      :_  this  :_  ~
      :*  %pass   /ping/(scot %p ship.cmd)/(scot %da now.bowl)
          %agent  [ship.cmd %ping]
          %poke   noun+!>(~)
      ==
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
    ^-  $@(brief:rudder [brief:rudder (list card) _+.state])
    =*  success  `brief:rudder`'Processed succesfully.'
    =^  cards  this
      (on-poke %clamore-command !>(cmd))
    [success cards +.state]
  ==
::
++  on-leave  on-leave:def
++  on-watch
  |=  =path
  ?>  =(our src):bowl
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%http-response *]  [~ this]
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
  ?+    pole  (on-agent:def pole sign)
      [%ping ship=@ time=@ ~]
    ?.  =(%poke-ack -.sign)  [~ this]
    =/  =ship  (slav %p ship.pole)
    =/  =time  (slav %da time.pole)
    ?~  old=(~(get by watchlist) ship)  [~ this]
    ?.  =(time begin.u.old)             [~ this]
    `this(watchlist (~(put by watchlist) ship [begin.u.old `now.bowl]))
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  [~ this]
    [%eyre %connect ~]  [~ this]
  ==
++  on-fail   on-fail:def
--
