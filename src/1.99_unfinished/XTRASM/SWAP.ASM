detectswapmethodandmembase:
                        mov ax,dummy
                        mov bx,menu
                        sub ax,bx
                        mov [word cs:swapsizepara],ax
detectxms:
                        mov ax,4300h
                        int 2fh
                        cmp al,080h
                        jnz detectems
                        mov ax,4310h
                        int 2fh
                        mov [word cs:xmsdriver],bx
                        mov [word cs:xmsdriver+2],es
                        xor ax,ax
                        call [dword cs:xmsdriver]
                        mov [byte cs:xmsver],ah
                        mov [byte cs:xmsver+1],al
                        mov ah,08h
                        mov bl,0
                        call [dword cs:xmsdriver]
                        or bl,bl
                        jnz detectems
                        mov [word cs:xmssize],ax
                        or [byte cs:swapmethod],001b ; XMS disponible! :)
detectems:
                        push cs
                        pop ds
                        mov ax,3d00h
                        mov dx,offset emsid
                        int 21h
                        jnc checkmorevalidems
                        jmp checkcurrdiskspace
checkmorevalidems:
                        mov [word cs:handle1],ax
                        mov ax,4400h
                        mov bx,[word cs:handle1]
                        int 21h
                        test dx,10000000b
                        jz closedevice
                        mov ax,4407h
                        mov bx,[word cs:handle1]
                        int 21h
                        jc closedevice
                        cmp al,0ffh
                        jnz closedevice
                        mov ah,40h
                        int 67h
                        cmp ah,00
                        jnz closedevice
                        mov ah,046h
                        int 67h
                        mov [byte cs:emsver],al
                        mov ah,042h
                        int 67h
                        mov [word cs:emsparasize],bx
                        or [byte cs:swapmethod],010b ; EMS disponible! :)
closedevice:
                        mov ah,03eh
                        mov bx,[word cs:handle1]
                        int 21h
checkcurrdiskspace:
                        mov ah,036h
                        xor dl,dl
                        int 21h
                        cmp ax,0ffffh
                        jz nodisk
                        call calcaxbxcx
                        or [byte cs:swapmethod],100b ; Disco disponible! :)
nodisk:
                        mov bx,dummy      ; Longitud de TODO el ejecutable
                                          ; en par grafos (Si paramount = 0)
                        cmp [byte cs:paramamount],0 ;
                        jz resizememblock
                        mov bx,menu      ; Longitud del todo el programa menos
                                         ; la parte del men£ shell.
resizememblock:
                        sub bx,[word cs:pspxtract]
                        mov [word cs:xtractparasize],bx
                        mov ah,04ah
                        mov es,[word cs:pspxtract]
                        int 21h
                        mov ah,048h
                        mov bx,0ffffh
                        int 21h
                        mov ax,1001h ; 64k + 16 bytes de cabecera del MCB
                        cmp ax,bx    ; tendr¡a que haber de memoria
                        jbe allocatesegment1
                        stc ; Indico que falta memoria base
                        ret
allocatesegment1:
                        mov ah,048h
                        mov bx,1000h
                        int 21h
                        mov [word cs:segment1],ax
                        clc
                        ret
calcaxbxcx:
                        push bx
                        mov bx,ax
                        xor ax,ax
                        xor dx,dx
                        clc
                        jcxz calcbx
firstsumdisk:
                        add ax,bx
                        adc dx,0000h
                        loop firstsumdisk
calcbx:
                        pop bx
                        mov cx,bx
                        clc
                        jcxz endsumdisk
secondsumdisk:
                        add [word cs:lodiskfree],ax
                        adc [word cs:hidiskfree],dx
                        loop secondsumdisk
endsumdisk:
                        ret
freememory:
                        mov ah,049h
                        mov es,[word cs:segment1]
                        int 21h
                        ret
