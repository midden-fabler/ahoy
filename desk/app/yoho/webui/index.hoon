/-  *yoho
/+  yoho, rudder, ahoy-style
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
    ?~  who=(slaw %p (~(gut by args) 'who' ''))  ~
    [%add-watch u.who]
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
        ;title:"%yoho"
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

        get notified when a ship is contacted

        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;table#ahoy
          ;form(method "post")
            ::  table header
            ;tr(style "font-weight: bold")
              ;td(align "center"):"~"
              ;td(align "center"):"@p"
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
              ;td(align "center"):"~"
            ==  ::  first row
          ==    ::  form
          ;*  work
        ==
      ==  ::  body
    ==    ::  html
  ++  work
    ^-  (list manx)
    %+  turn  ~(tap in watchlist)
    |=  [=ship]
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
        ::  last-contact
        ;td(align "right")
          ; {<(~(last-contact yoho bowl) ship)>}
        ==
      ==
    ==
  --  ::  |^
--    ::  |_
