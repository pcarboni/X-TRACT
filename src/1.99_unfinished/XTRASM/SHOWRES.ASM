showsystemresources:
                        mov al,[byte cs:swapmethod]
showxms:
                        test al,001b
                        jz showems
                        mov dx,offset xms
                        call far main:print
                        push cs
                        pop es
                        mov di,offset string32bit
                        mov al,[byte cs:xmsver]
                        mov ah,al
                        and al,0f0h
                        or al,al
                        jz other1
                        stosb
other1:
                        mov al,ah
                        and al,0fh
                        add al,030h
                        stosb
                        mov al,'.'
                        stosb
                        mov al,[byte cs:xmsver+1]
                        mov ah,al
                        and al,0f0h
                        add al,030h
                        stosb
                        mov al,ah
                        and al,0fh
                        add al,030h
                        stosb
                        mov al,'$'
                        stosb
                        mov dx,offset string32bit
                        call far main:print
                        mov dx,offset detected
                        call far main:print
showems:
                        mov al,[byte cs:swapmethod]
                        test al,010b
                        jz showdisk
                        mov dx,offset ems
                        call far main:print
                        push cs
                        pop es
                        mov di,offset string32bit
                        mov al,[byte cs:emsver]
                        mov ah,al
                        and al,0f0h
                        clc
                        mov cl,4
                        shr al,cl
                        add al,030h
                        stosb
                        mov al,'.'
                        stosb
                        mov al,ah
                        and al,0fh
                        add al,030h
                        stosb
                        mov al,' '
                        stosb
                        mov al,'$'
                        stosb
                        mov dx,offset string32bit
                        call far main:print
                        mov dx,offset detected
                        call far main:print
showdisk:
                        mov al,[byte cs:swapmethod]
                        test al,100b
                        jz showresend
showresend:
                        mov dx,offset disk
                        call far main:print
                        mov ah,019h
                        int 21h
                        mov di,offset string32bit
                        add al,041h
                        stosb
                        mov ax,'$:'
                        stosw
                        mov dx,offset string32bit
                        call far main:print
                        ret

