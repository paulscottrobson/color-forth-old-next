@echo off
python ..\scripts\makecompasm.py
copy __words.asm ..\kernel\temp
