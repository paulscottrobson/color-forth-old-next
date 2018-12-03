@echo off
python ..\scripts\makecompasm.py
..\bin\snasm -next -vice wrapper.asm code.bin
python ..\scripts\makebootstrap.py
copy bootstrap.cf ..\files
