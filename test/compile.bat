set projectName=MASM3_test
del *.lst *.obj *.exe
\masm32\bin\ml /c /Zd /coff /Zi /Fl %projectName%.asm
\masm32\bin\ml /c /Zd /coff /Zi /Fl StringSet2.asm
\masm32\bin\Link /SUBSYSTEM:CONSOLE /out:%projectName%.exe %projectName%.obj StringSet2.obj ..\Irvine\User32.Lib  \masm32\lib\kernel32.lib  ..\Irvine\Irvine32.lib ..\macros\convutil201604.obj ..\macros\utility201609.obj
%projectName%.exe