@echo off
del /Q boot.img
call build.bat
..\bin\CSpect.exe -zxnext -brk -esc -w3 ..\files\bootloader.sna
