@echo off
del /Q boot.img
call build.bat
python ..\scripts\importcode.py demo.cf
..\bin\CSpect.exe -zxnext -brk -esc -w3 ..\files\bootloader.sna
