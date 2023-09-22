::  doot: dot post
::
::    dot post in a channel; get a ping time reply
::
/-  *doot, chat
/+  default-agent, dbug, rudder
/~  pages  (page:rudder records-1 command)  /app/doot/webui
=>
  |%
  +$  card  card:agent:gall
  +$  versioned-state
    $%  state-0
        state-1
    ==
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
    [~[connect:cor watch-chat-ui:cor] this(trigger '.')]
  ::
  ++  on-save  !>(state)
  ++  on-load
    |=  =vase
    ^-  (quip card _this)
    =/  old  !<(versioned-state vase)
    ?-  -.old
      %0  [[connect:cor]~ this(trigger trigger.old, watchlist watchlist.old)]
      %1  `this(state old)
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state  abet:(poke:cor mark vase)
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?>  =(our src):bowl
    ?+  path  (on-watch:def path)
      [%http-response *]  [~ this]
    ==
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =^  cards  state  abet:(agent:cor wire sign)
    [cards this]
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?+  sign-arvo  (on-arvo:def wire sign-arvo)
      [%eyre %bound *]  [~ this]
    ==
  ++  on-fail  on-fail:def
  --
=|  cards=(list card)
|_  =bowl:gall
++  cor   .
++  abet  [(flop cards) state]
++  emit  |=(=card cor(cards [card cards]))
++  emil  |=(caz=(list card) cor(cards (welp (flop caz) cards)))
++  connect  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]
++  watch-chat-ui  [%pass /ui %agent [our.bowl %chat] %watch /ui] 
++  send-ping
  |=  [=id:chat =flag:chat]
  ^-  card
  =/  =wire  /ping/(scot %p p.id)/(scot %da q.id)/(scot %da now.bowl)
  [%pass wire %agent [p.flag %ping] %poke noun+!>(~)]
::
++  send-chat-reply
  |=  [=id:chat =flag:chat =story:chat]
  ^-  card
  =/  replying=(unit id:chat)  `id
  =/  author=ship  our.bowl
  =/  sent=time    now.bowl
  =/  =content:chat        [%story story]
  =/  =memo:chat           [replying author sent content]
  =/  =delta:writs:chat    [%add memo]
  =/  new-id=id:chat       [our.bowl now.bowl]
  =/  dwc=diff:writs:chat  [new-id delta]
  =/  =diff:chat           [%writs dwc]
  =/  =update:chat         [now.bowl diff]
  =/  =action:chat         [flag update]
  =/  =cage                chat-action-0+!>(action)
  [%pass /chat %agent [our.bowl %chat] %poke cage]
::
++  poke
  |=  [=mark =vase]
  ?>  =(our src):bowl
  ^+  cor
  ?+    mark  ~|(funny-mark/mark !!)
      %noun  cor(enabled !<(? vase))
      %doot-command
    =+  !<(cmd=command vase)
    ?-  -.cmd
      %set-trigger  cor(trigger trigger.cmd)
      %enable       cor(enabled flag.cmd)
    ==
  ::
      %handle-http-request
    =;  out=(quip card _+.state)
      =.  +.state  +.out
      (emil -.out)
    ^-  (quip card _+.state)
    %.  [bowl !<(order:rudder vase) +.state]
    %-  (steer:rudder _+.state command)
    :^    pages
        (point:rudder /[dap.bowl] & ~(key by pages))
      (fours:rudder +.state)
    |=  cmd=command
    ^-  $@(brief:rudder [brief:rudder (list card) _+.state])
    =*  success  `brief:rudder`'Processed succesfully.'
    =.  cor  (poke doot-command+!>(cmd))
    [success cards +.state]
  ==
::
++  agent
  |=  [=(pole knot) =sign:agent:gall]
  ^+  cor
  ?+    pole  ~|(bad-agent-wire/pole !!)
      [%chat ~]  cor
      [%ping ship=@ time=@ pinged=@ ~]
    ?.  =(%poke-ack -.sign)  cor
    =/  =ship        (slav %p ship.pole)
    =/  =time        (slav %da time.pole)
    =/  pinged=@da   (slav %da pinged.pole)
    =/  =id:chat     [ship time]
    ?.  (~(has by watchlist) id)  cor
    =/  =flag:chat   (~(got by watchlist) id)
    =/  elapsed=@dr  (sub now.bowl pinged)
    =/  msg=cord  
      (crip "> %ping response time from {<p.flag>}: {<(mill:milly elapsed)>}")
    =/  block=(list block:chat)    ~
    =/  inline=(list inline:chat)  ~[[%inline-code msg] [%break ~]]
    =/  =story:chat  [block inline]
    =.  watchlist  (~(del by watchlist) id)
    (emit (send-chat-reply id flag story))
  ::
      [%ui ~]
    ?+    -.sign  cor
        %kick  (emit watch-chat-ui)
        %fact
      ?.  enabled  cor
      ?+    p.cage.sign  ~|(funny-mark/p.cage.sign !!)
          %chat-action-0
        =+  !<([=flag:chat [=time =diff:chat]] q.cage.sign)
        ?:  =(p.flag our.bowl)  cor
        ?+    -.diff  cor
            %writs
          =/  dwc=diff:writs:chat  p.diff
          ?+    -.q.dwc  cor
              %add
            =/  =id:chat    p.dwc
            =/  =memo:chat  p.q.dwc
            ?.  =(author.memo our.bowl)    cor
            ?.  ?=(%story -.content.memo)  cor
            =/  block=(list block:chat)    p.p.content.memo
            ?.  =(~ block)                 cor
            =/  inline=(list inline:chat)  q.p.content.memo
            =/  target=(list inline:chat)  ~[trigger [%break ~]]
            ?.  =(inline target)           cor
            =.  watchlist  (~(put by watchlist) id flag)
            (emit (send-ping id flag))
          ==
        ==
      ==
    ==
  ==
--
