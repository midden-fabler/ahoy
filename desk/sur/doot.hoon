/-  chat
|%
+$  records
  $:  trigger=@t
      watchlist=(map =id:chat =flag:chat)
  ==
+$  records-1
  $:  trigger=@t
      watchlist=(map =id:chat =flag:chat)
      enabled=_|
  ==
+$  command
  $%  [%set-trigger trigger=@t]
      [%enable =flag]
  ==
--
