|%
+$  records
  $:  watchlist=(map ship @dr)
      update-interval=_~m5
  ==
+$  command
  $%  [%add-watch =ship t=@dr]
      [%del-watch =ship]
      [%set-update-interval t=@dr]
  ==
--
