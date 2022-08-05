TITLE Suma y resta (SumaRestaAlt.asm)
; Este programa suma y resta enteros de 32 bits.
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
DumpRegs PROTO
.code
main PROC
 mov eax,10000h ; EAX = 10000h
 add eax,40000h ; EAX = 50000h
 sub eax,20000h ; EAX = 30000h
 call DumpRegs
 INVOKE ExitProcess,0
main ENDP
END main