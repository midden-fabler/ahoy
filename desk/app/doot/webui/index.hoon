/-  *doot
/+  rudder, ahoy-style
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
      %enable   [%enable %&]
      %disable  [%enable %|]
  ::
      %set-trigger
    ?~  trigger=(~(get by args) 'trigger')  ~
    [%set-trigger u.trigger]
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
        ;title:"%doot"
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

        dot post in a channel; get a ping time reply
        
        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;table#ahoy
          ::  table header
          ;tr(style "font-weight: bold")
            ;td(align "center"):"trigger"
            ;td(align "center"):"~"
          ==
          ::  first row
          ;tr
            ;td
              ;form(method "post")
                ;input(type "hidden", name "what", value "set-trigger");
                ;input(type "text", name "trigger", placeholder "{(trip trigger)}");
              ==
            ==
            ;td
              ;+  ?:(enabled disable-button enable-button)
            ==
          ==  ::  row
        ==
      ==  ::  body
    ==    ::  html
  ++  disable-button
    ^-  manx
    ;form(method "post")
      ;button(type "submit", name "what", value "disable"):"disable"
    ==
  ++  enable-button
    ^-  manx
    ;form(method "post")
      ;button(type "submit", name "what", value "enable"):"enable"
    ==
  --  ::  |^
--    ::  |_
