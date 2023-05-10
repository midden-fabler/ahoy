/-  *clamore
/+  rudder, ahoy, ahoy-style
^-  (page:rudder records command)
=<
|_  [=bowl:gall =order:rudder records]
+*  cor   ~(. +> bowl)
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder command)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'what')  ~
  ?+    u.what  ~
      ?(%add-watch %del-watch)
    ?~  who=(slaw %p (~(gut by args) 'who' ''))  ~
    ?-  u.what
      %add-watch  [%add-watch u.who]
      %del-watch  [%del-watch u.who]
    ==
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
        ;title:"%clamore"
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

        ;h4:"ship monitoring"

        ping timer

        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;table
          ;form(method "post")
            ::  table header
            ;tr(style "font-weight: bold")
              ;td(align "center"):"~"
              ;td(align "center"):"@p"
              ;td(align "center"):"~"
              ;td(align "center"):"elapsed"
              ;td(align "center"):"direct route"
              ;td(align "center"):"last-contact `@dr"
            ==
            ::  first row for adding new ships
            ;tr
              ;td
                ;button(type "submit", name "what", value "add-watch"):"+"
              ==
              ;td
                ;input(type "text", name "who", placeholder "~sampel");
              ==
              ;td(align "center"):"~"  ::  ping button
              ;td(align "right"):"~"   ::  elapsed
              ;td(align "center"):"~"  ::  direct route
              ;td(align "center"):"~"  ::  last-contact
            ==  ::  first row
          ==    ::  form
          ;*  work
          ;*  (extra (~(del in (sy (saxo:title [our now our]:bowl))) our.bowl))
          ;*  (extra targets:cor)
        ==
      ==  ::  body
    ==    ::  html
  ::
  ++  extra
    |=  ships=(set ship)
    =/  clips=(set ship)  (~(dif in ships) ~(key by watchlist))
    ^-  (list manx)
    %+  turn  ~(tap in clips)
    |=  =ship
    ;tr
      ;td
        ::  %del-watch
        ;form(method "post")
          ;button(type "submit", name "what", value "del-watch"):"-"
          ;input(type "hidden", name "who", value "{(scow %p ship)}");
        ==
        ::  ship
        ;td
          ; {(scow %p ship)}
        ==
        ::  ping button
        ;form(method "post")
          ;td
            ;input(type "hidden", name "what", value "add-watch");
            ;input(type "hidden", name "who", value "{(scow %p ship)}");
            ;input(type "submit", name "~", value "ping");
          ==
        ==
        ::  elapsed
        ;td(align "right")
          ~
        ==
        ::  route
        ;td(align "center")
          ~
        ==
        ::  last-contact
        ;td(align "right")
          ; {<(~(last-contact ahoy bowl) ship)>}
        ==
      ==
    ==
  ::
  ++  work
    ^-  (list manx)
    %+  turn  ~(tap by watchlist)
    |=  [=ship =elapsed]
    ;tr
      ;td
        ::  %del-watch
        ;form(method "post")
          ;button(type "submit", name "what", value "del-watch"):"-"
          ;input(type "hidden", name "who", value "{(scow %p ship)}");
        ==
        ::  ship
        ;td
          ; {(scow %p ship)}
        ==
        ::  ping button
        ;form(method "post")
          ;td
            ;input(type "hidden", name "what", value "add-watch");
            ;input(type "hidden", name "who", value "{(scow %p ship)}");
            ;input(type "submit", name "~", value "ping");
          ==
        ==
        ::  elapsed
        ;td(align "right")
          ;+  ?~  end.elapsed
                ;p.red:"{<(mill:milly `@dr`(sub now.bowl begin.elapsed))>}"
              ;p:"{<(mill:milly `@dr`(sub u.end.elapsed begin.elapsed))>}"
        ==
        ::  route
        ;td(align "center")
          ; {<(direct ship)>}
        ==
        ::  last-contact
        ;td(align "right")
          ; {<(~(last-contact ahoy bowl) ship)>}
        ==
      ==
    ==
  ::
  ++  direct
    |=  who=ship
    =/  ss  
      .^  ship-state:ames 
        %ax
        /(scot %p our.bowl)//(scot %da now.bowl)/peers/(scot %p who)
      ==
    ?>  ?=([%known *] ss)
    ?~  route.+.ss  ~
    direct.u.route.ss
  --  ::  |^
--    ::  |_
::
|_  =bowl:gall
+*  our  (scot %p our.bowl)
    now  (scot %da now.bowl)
++  mutuals
  ^-  (set ship)
  ?.  .^(? %gu /[our]/pals/[now]/$)  ~
  .^((set ship) %gx /[our]/pals/[now]/mutuals/noun)
::
++  targets
  ^-  (set ship)
  ?.  .^(? %gu /[our]/pals/[now]/$)  ~
  .^((set ship) %gx /[our]/pals/[now]/targets/noun)
::
++  leeches
  ^-  (set ship)
  ?.  .^(? %gu /[our]/pals/[now]/$)  ~
  .^((set ship) %gx /[our]/pals/[now]/leeches/noun)
--
