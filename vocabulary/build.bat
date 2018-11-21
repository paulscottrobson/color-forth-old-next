@echo off
del /Q __words.asm
python ..\scripts\buildwords.py 
copy __words.asm ..\kernel\temp
