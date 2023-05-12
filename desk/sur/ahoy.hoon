|%
+$  records  $:(=heartbeats =run-interval)
+$  records-1
  $:  =heartbeats
      =downed
      =send-alerts
      =run-interval
      =default-threshold
  ==
::
+$  heartbeats  (map ship @dr)
+$  downed      (map ship last=(unit @da))
+$  send-alerts        _&
+$  run-interval       _~m5
+$  default-threshold  _~h1
::
+$  command
  $%  [%set-heartbeat =ship t=(unit @dr)]
      [%set-send-alerts flag=?]
      [%set-run-interval t=@dr]
      [%set-default-threshold t=@dr]
  ==
--
