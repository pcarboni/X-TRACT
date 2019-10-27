; HEX2ASC.ASM - Rutina de conversi¢n de n£meros de 32 bits a un string ASCII
; (c) 1996 by Pablo Carboni (Fidonet: 4:900/466.1)
;
; Entrada:  DX:AX = n£mero de 32 bits
;           ES:DI = Buffer de almacenamiento del string num‚rico
;
; Salida:   String num‚rico depositado en el buffer
;           ES:DI = puntero al £ltimo n£mero+1 del buffer
;
; Llamar a la rutina con "call hex2asc"
;
hex2asc:
                push ds
                push si
                push ax
                push bx
                push cx
                push dx
                pushf

                push cs
                pop ds
                mov [word cs:hexnumber],ax
                mov [word cs:hexnumber+2],dx
                push di
                mov di,offset tempasciinumber+1
starthex2asc:
                mov bx,[word cs:hexnumber]
                mov ax,[word cs:hexnumber+2]
                mov cx,000ah
                xor dx,dx
                clc
                div cx
                mov [word cs:hexnumber+2],ax
                mov ax,bx
                clc
                div cx
                mov [word cs:hexnumber],ax
                add dl,030h
                mov [byte cs:di],dl
                inc di
                cmp [word cs:hexnumber+2],0000
                jne starthex2asc
                cmp [word cs:hexnumber],0000
                jne starthex2asc
                xor al,al
                mov [byte cs:di],al
changetonormal:
                mov si,offset tempasciinumber+1
                pop di
scanstn:
                mov al,[byte cs:si+1]
                or al,al
                jz thelastcount
                inc si
                jmp scanstn
thelastcount:
                std
                lodsb
                or al,al
                jz endcount
                cld
                stosb
                jmp thelastcount
endcount:
                popf
                pop dx
                pop cx
                pop bx
                pop ax
                pop si
                pop ds
                retf
hexnumber:
                dw 0,0 ; N£mero original
tempasciinumber:
                db 0ah dup (0),0  ;  String ascii + "$"
