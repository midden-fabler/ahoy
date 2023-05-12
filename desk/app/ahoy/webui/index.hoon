/-  *ahoy
/+  rudder, ahoy-style, sigil-svg=sigil
::
^-  (page:rudder records-1 command)
|_  [=bowl:gall =order:rudder records-1]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder command)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'what')  ~
  ?+    u.what  ~
      %set-heartbeat
    ?~  who=(slaw %p (~(gut by args) 'who' ''))     ~
    ?~  when=(slaw %dr (~(gut by args) 'when' ''))
      [%set-heartbeat u.who ~]
    [%set-heartbeat u.who `u.when]
  ==
::
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
        ;title:"%ahoy"
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

        get notified if last-contact with a ship
        exceeds a specified amount of time,
        and when that ship is subsequently contacted
        
        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;table#ahoy
          ;form(method "post")
            ::  table header
            ;tr(style "font-weight: bold")
              ;td(align "center"):"~"
              ;td(align "center"):"status"
              ;td(align "center"):"ship"
              ;td(align "center"):"notify after @dr"
              ;td(align "center"):"last-contact `@dr"
            ==
            ::  first row for adding new ships
            ;tr
              ;td
                ;button(type "submit", name "what", value "set-heartbeat"):"+"
              ==
              ::  status
              ;td(align "center"):"~"
              ::  ship
              ;td
                ;input(type "text", name "who", placeholder "~sampel");
              ==
              ::  notify
              ;td
                ;input(type "text", name "when", placeholder "~d1.h12.m30");
              ==
              ::
              ;td(align "center"):"~"
            ==  ::  first row
          ==    ::  form
          ;*  work
        ==
      ==  ::  body
    ==    ::  html
  ++  work
    ^-  (list manx)
    %+  turn  (sort ~(tap by heartbeats) aor)
    |=  [=ship t=@dr]
    =/  threshold=(unit @dr)  (~(get by heartbeats) ship)
    =/  last=(unit @dr)
      ?~  last=(last-contact ship)  ~
      `(sub now.bowl u.last)
    ;tr
      ;td
        ::  %set-heartbeat
        ;form(method "post")
          ;button(type "submit", name "what", value "set-heartbeat"):"-"
          ;input(type "hidden", name "who", value "{(scow %p ship)}");
        ==
        ::  status
        ::
        ;td(align "center")
          ;+  ?:  (is-down ship (last-contact ship))
                ;p.red:"⬤"
              ;p.green:"⬤"
        ==
        ::  ship
        ;td(align "right"):"{(scow %p ship)}"
        ::  when to notify
        ;form(method "post")
          ;td
            ;input(type "hidden", name "what", value "set-heartbeat");
            ;input(type "hidden", name "who", value "{(scow %p ship)}");
            ;input(type "text", name "when", value "{?~(threshold ~ (scow %dr u.threshold))}");
          ==
        ==
        ::  last-contact
        ;td(align "right")
          ;+  ?~  last
                ;p:"~"
              ;p:"{<u.last>}"
        ==
      ==
    ==
  ::
  ++  last-contact
    |=  =ship
    ^-  (unit @da)
    =+  [our=(scot %p our.bowl) now=(scot %da now.bowl) ship=(scot %p ship)]
    .^((unit @da) %ax /[our]//[now]/peers/[ship]/last-contact)
  ::
  ++  is-down
    |=  [=ship last=(unit @da)]
    ^-  ?
    ?:  =(ship our.bowl)
      %|
    ?~  last
      %&
    =/  threshold=@dr  (~(gut by heartbeats) ship default-threshold)
    (gte `@dr`(sub now.bowl u.last) threshold)
  --  ::  |^
--    ::  |_
