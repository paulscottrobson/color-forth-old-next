@echo off
set ZOPTIONS="--noconfigfile --nowelcomemessage --quickexit  --machine tbblue --tbblue-fast-boot-mode --sna-no-change-machine --enable-esxdos-handler --disablemenu   --zoomx 3 --zoomy 3  "
d:\install\zesarux\zesarux.exe %ZOPTIONS% --esxdos-root-dir $1 $1\$2
