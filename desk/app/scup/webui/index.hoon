/-  *scup
/+  ahoy-style,
    rudder,
    scup
::
^-  (page:rudder records command)
|_  [=bowl:gall =order:rudder records]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder command)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'what')  ~
  ?+    u.what  ~
      %add-watch
    ?~  who=(slaw %p (~(gut by args) 'who' ''))     ~
    ?~  freq=(slaw %dr (~(gut by args) 'freq' ''))  ~
    ?~  hhmm=(slaw %dr (~(gut by args) 'hhmm' ''))  ~
    [%add-watch u.who u.freq u.hhmm]
  ::
      %del-watch
    ?~  who=(slaw %p (~(gut by args) 'who' ''))  ~
    [%del-watch u.who]
  ==
::
++  final  (alert:rudder (cat 3 '/' dap.bowl) build)
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  |^  [%page page]
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"%scup"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style:ahoy-style)}"
      ==
      ;body
        ::  links
        ;a/"/ahoy"
          ;h2:"%ahoy"
        ==
        ;a/"/yoho"
          ;h2:"%yoho"
        ==
        ;a/"/bord"
          ;h2:"%bord"
        ==
        ;a/"/scup"
          ;h2:"%scup"
        ==
        ;a/"/doot"
          ;h2:"%doot"
        ==
        ;a/"/clamore"
          ;h2:"%clamore"
        ==

        ;h4:"ship maintenance"

        schedule a recurring pack and meld

        e.g. every day at 08:30 UTC: ~d1 ~h8.m30

        now (UTC): {<now.bowl>}

        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;+  ?:  (~(has by watchlist) our.bowl)
              (existing our.bowl)
            (new our.bowl)
      ==  ::  body
    ==    ::  html
  ::
  ++  header
    ^-  manx
    ;tr(style "font-weight: bold")
      ;td(align "center"):"~"
      ;td(align "center"):"@p"
      ;td(align "left"):"frequency (days)"
      ;td(align "left"):"hh:mm"
      ;td(align "right"):""  ::  update button
      ;td(align "center"):"next pack/meld"
    ==
  ::
  ++  new
    |=  =ship
    ^-  manx
    ;table#ahoy
      ;+  header
      ;form(method "post")
        ;input(type "hidden", name "who", value "{(scow %p ship)}");
        ;tr
          ;td
            ;button(type "submit", name "what", value "add-watch"):"+"
          ==
          ::  ship
          ;td
            ; {(scow %p ship)}
          ==
          ;td
            ;input(type "text", name "freq", placeholder "~d7");
          ==
          ;td
            ;input(type "text", name "hhmm", placeholder "~h8.m30");
          ==
          ;td(align "center")
            ;
          ==
          ::  next pack/meld
          ;td(align "center")
            ; {<(~(next scup bowl) ship)>}
          ==
        ==
      ==
    ==
  ::
  ++  existing
    |=  =ship
    ^-  manx
    ;table#ahoy
      ;+  header
      ;tr
        ::  button
        ;td
          ;form(method "post")
            ;input(type "hidden", name "who", value "{(scow %p ship)}");
            ;button(type "submit", name "what", value "del-watch"):"-"
          ==
        ==
        ::  ship
        ;td
          ; {(scow %p ship)}
        ==
        ::  input
        ;form(method "post")
          ;input(type "hidden", name "who", value "{(scow %p ship)}");
          ;input(type "hidden", name "what", value "add-watch");
          ;td
            ;input(type "text", name "freq", placeholder "{<`@dr`(yule freq:(~(got by watchlist) ship))>}");
          ==
          ;td
            ;input(type "text", name "hhmm", placeholder "{<`@dr`(yule hhmm:(~(got by watchlist) ship))>}");
          ==
          ;td
            ;input(type "submit", name "~", value "update");
          ==
        ==
        ::  next pack/meld
        ;td(align "right")
          ; {<(~(next scup bowl) ship)>}
        ==
      ==
    ==
  --  ::  |^
--    ::  |_
