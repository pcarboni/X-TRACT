initmouse:
                        xor ax,ax
                        mov ds,ax
                        mov si,0033h*4        ; Me fijo que el vector de la
                        mov dx,[word ds:si]   ; int 33h (mouse) no apunte a
                        mov ax,[word ds:si+2] ; 0000:0000
                        or dx,ax
                        jnz checkfordriver
dontusemouse:
                        mov [byte cs:mouse],0ffh
                        ret
checkfordriver:
                        xor ax,ax
                        int 33h
                        cmp ax,0ffffh
                        jz setmouse
                        jmp dontusemouse
setmouse:
                        mov [byte cs:mouse],01h
                        mov ax,001dh
                        mov bl,[byte cs:videopage]
                        xor bh,bh
                        int 33h
                        mov ax,4
                        mov cx,2*8
                        mov dx,7*8
                        int 33h
                        mov ax,menu
                        mov es,ax
                        mov dx,offset mousehandler
                        mov ax,0014h
                        mov cx,0ffffh
                        int 33h
                        mov [word cs:oldmousepointer],dx
                        mov [word cs:oldmousepointer+2],es
                        mov [word cs:oldmouseevent],cx
                        mov ax,0001h
                        int 33h
                        call pushflags
                        mov ax,0040h
                        mov ds,ax
                        mov si,006ch
                        mov ax,menu
                        mov es,ax
                        mov di,offset sourcetics
                        mov ax,[word ds:si]
                        mov dx,[word ds:si+2]
                        mov [word es:di],ax
                        mov [word es:di+2],dx
                        mov di,offset targettics
                        clc
                        add ax,[word cs:tics]
                        adc dx,0
                        cmp dx,0018h
                        jb noadjust
                        cmp ax,00b0h
                        jb noadjust
                        clc
                        sub ax,00b0h
                        sbb dx,0018h
noadjust:
                        mov [word es:di],ax
                        mov [word es:di+2],dx
                        mov [byte cs:clicks],0
                        call popflags
                        mov [byte cs:insideint33],0
                        ret
mousehandler:
                        mov [byte cs:scrollrightbut],0
                        mov [byte cs:insideint33],1
                        call pushflags
                        call updatemousepos
                        test ax,1011b      ; No se puls¢ bot¢n alguno o movi¢ el
                        jz finmousehandler ; mouse?
                        cmp [byte cs:mouserow],07 ; Si est  fuera de los l¡mites
                        jae checkoutofframe       ; entonces chequeo flecha
                        and ax,11b
                        cmp [byte cs:mouserow],6
                        jnz checkforcontmovup
                        cmp [byte cs:mousecolumn],0
                        jnz checkforcontmovup
                        cmp ax,10b
                        jz pulsarflechaarriba
                        cmp ax,01b
                        jnz finmousehandler
                        cmp bx,1b
                        jnz finmousehandler
pulsarflechaarriba:
                        call flechamenos
finmousehandler:
                        jmp endmousehandler
checkforcontmovup:
                        cmp [byte cs:oldmouserow],7
                        jnz finmousehandler
                        cmp ax,01b
                        jnz finmousehandler
                        cmp bx,1b
                        jz jmpflecha1
                        cmp bx,10b
                        jnz finmousehandler
                        mov [byte cs:scrollrightbut],01h
jmpflecha1:
                        jmp flecha1
checkoutofframe:
                        cmp [byte cs:mouserow],13h
                        jbe insideframe
                        and ax,11b
                        cmp [byte cs:mouserow],20
                        jnz checkforcontmovdown
                        cmp [byte cs:mousecolumn],0
                        jnz checkforcontmovdown
                        cmp ax,10b
                        jz pulsarflechaabajo
                        cmp ax,01b
                        jnz finmousehandler
                        cmp bx,1b
                        jnz finmousehandler
pulsarflechaabajo:
                        call flechamas
                        jmp endmousehandler
checkforcontmovdown:
                        cmp [byte cs:oldmouserow],19
                        jnz finmousehandler
                        cmp ax,01b
                        jnz finmousehandler
                        cmp bx,1b
                        jz jmpflecha2
                        cmp bx,10b
                        jnz finmousehandler
                        mov [byte cs:scrollrightbut],01h
jmpflecha2:
                        jmp flecha2
checkengagepercentagecursor:
                        and ax,11b
                        cmp ax,10b ; ¨Fue solo bot¢n (Izq)?
                        jnz noengagepercent
engagepercentage:
                        call locatepercentage
                mov ax,menu                        ;  "Inserto" la pantalla
                mov ds,ax                          ;
                mov si,offset screen1              ;   del menu en el display
                les di,[dword cs:videooffset]      ;
                mov cx,2000                        ;   de la tarjeta de video
                cld                                ;
                rep movsw                          ;
                        call showdir
noengagepercent:
                        jmp endmousehandler

insideframe:
                        cmp [byte cs:mousecolumn],0
                        jz checkengagepercentagecursor
                                                ; Leo si fue movimiento y/o,
                        and ax,1011b            ; botones izquierdo o derecho
                        cmp ax,0011b            ; ¨Fue movimiento y Bot. Izq.?
                        jz engagebar            ; S¡
                        cmp ax,1001b            ; ¨Fue movimiento y Bot. Der.?
                        jz engagebarwithflecha
                        cmp ax,10b              ; Fue solo bot¢n (Izq) ?
                        jz checkclickcounter
                        cmp ax,1000b            ; Fue solo bot¢n (Der) ?
                        jz engagebarwithflecha
                        cmp ax,1b               ; Fue movimiento?
                        jnz endmousehandler
                        cmp bx,1b               ; Fue movimiento "Y" bot¢n Izq?
                        jz engagebar
                        cmp bx,10b              ; Fue movimiento "Y" bot¢n Der?
                        jz engagebarwithflecha
                        jmp endmousehandler
engagebarwithflecha:
                        call mousecursor2bar
                        call taguntagselective
                        jmp endmousehandler
engagebar:
                        call mousecursor2bar ; El cursor est  ubicado
                                             ; entre 7 y 13h
endmousehandler:
                        call popflags
                        mov [byte cs:insideint33],0
                        retf
checkclickcounter:
                        mov ax,5
                        xor bx,bx
                        int 33h
                        cmp ax,1
                        jnz engagebar
                        mov ax,0040h
                        mov es,ax
                        mov bx,006ch
                        mov ax,[word es:bx]
                        mov dx,[word es:bx+2]
                        clc
                        sub ax,[word cs:tics]
                        sbb dx,0
                        jns dontadjustlimit
                        neg ax
                        neg dx
                        mov bx,0018h
                        mov cx,00b0h
                        xchg ax,cx
                        xchg dx,bx
                        clc
                        sub ax,cx
                        sbb dx,bx
dontadjustlimit:
                        cmp dx,[word cs:sourcetics+2]
                        jb setonemoreclick
                        ja setclick1
                        cmp ax,[word cs:sourcetics]
                        jbe setonemoreclick
                        jmp setclick1
setonemoreclick:
                        inc [byte cs:clicks]
                        cmp [byte cs:clicks],01h
                        jz enteremulated
                        jmp engagebar
enteremulated:
                        mov [byte cs:clicks],0
                        mov ax,[word cs:filesentries]
                        cmp ax,13
                        jae clicksok
                        add ax,6
                        cmp [byte cs:mouserow],al
                        ja endclicks
clicksok:
                        mov ax,0002h
                        int 33h
                        call changeorgetinfo
                        mov ax,0001h
                        int 33h
endclicks:
                        call updatetics
                        jmp endmousehandler
noemulation:
                        call updatetics
                        jmp engagebar
setclick1:
                        mov [byte cs:clicks],0
                        jmp noemulation
updatetics:
                        mov ax,0040h
                        mov es,ax
                        mov bx,006ch
                        mov ax,[word es:bx]
                        mov dx,[word es:bx+2]
                        mov [word cs:sourcetics],ax
                        mov [word cs:sourcetics+2],dx
                        clc
                        add ax,[word cs:tics]
                        adc dx,0
                        cmp dx,0018h
                        jb noupdateadjust
                        cmp ax,00b0h
                        jb noupdateadjust
                        clc
                        sub ax,00b0h
                        sbb dx,0018h
noupdateadjust:
                        mov [word cs:targettics],ax
                        mov [word cs:targettics+2],dx
                        ret
updatetics2:
                        mov ax,0040h
                        mov es,ax
                        mov bx,006ch
                        mov ax,[word es:bx]
                        mov dx,[word es:bx+2]
                        mov [word cs:sourcetics],ax
                        mov [word cs:sourcetics+2],dx
                        clc
                        add ax,[word cs:waittics]
                        adc dx,0
                        cmp dx,0018h
                        jb noupdateadjust2
                        cmp ax,00b0h
                        jb noupdateadjust2
                        clc
                        sub ax,00b0h
                        sbb dx,0018h
noupdateadjust2:
                        mov [word cs:targettics],ax
                        mov [word cs:targettics+2],dx
                        ret
updmouse:
                mov ax,3
                int 33h
updatemousepos:
                push ax
                push bx
                push cx
                push dx
                pushf
                mov ax,dx
                mov bx,cx
                call backupoldmousepos
                mov cx,3
                clc
                shr ax,cl
                mov [byte cs:mouserow],al
                clc
                shr bx,cl
                mov [byte cs:mousecolumn],bl
                popf
                pop dx
                pop cx
                pop bx
                pop ax
endupdatemousepos:
                ret
backupoldmousepos:
                mov cx,[word cs:mouserow]
                mov dx,[word cs:mousecolumn]
                mov [word cs:oldmouserow],cx
                mov [word cs:oldmousecolumn],dx
                ret
mousecursor2bar:
                mov cl,[byte cs:filepointer]
                add cl,07
                cmp cl,[byte cs:mouserow]
                jz dontchangemousebar
                mov ax,[word cs:filesentries]
                cmp ax,13
                jae movemousebar
                add ax,6
                cmp [byte cs:mouserow],al
                ja dontchangemousebar
movemousebar:
                mov ax,0002h
                int 33h
                mov [byte cs:colorbar],31
                call showfilepointer
                xor ch,ch
                mov cl,[byte cs:mouserow]
                sub cl,07h
                mov [byte cs:filepointer],cl
                mov [word cs:currfileoffset],0
                jcxz showmousebar
addmouseoffset:
                add [word cs:currfileoffset],017h
                loop addmouseoffset
showmousebar:
                mov [byte cs:colorbar],63
                call showfilepointer
                mov ax,0001h
                int 33h
dontchangemousebar:
                ret
flechamenos:
                mov [word cs:waittics],9
flechamenosagain:
                call oneminusfile
                call updatetics2
                call waitxtics
                mov ax,0005
                xor bx,bx
                int 33h
                cmp ax,0001h
                jnz flechaend1
                cmp [byte cs:mouserow],06
                jnz flechaend1
                cmp [byte cs:mousecolumn],0
                jnz flechaend1
                mov [word cs:waittics],1
                jmp flechamenosagain
flechaend1:
                ret
setinsideup:
                mov ax,2
                int 33h
                mov ax,3
                int 33h
                mov ax,4
                mov dx,7h*8
                int 33h
                mov cl,3
                shr cx,cl
                mov [byte cs:mouserow],7
                mov [byte cs:mousecolumn],dl
                mov ax,1
                int 33h
flechend1:
                jmp endmousehandler
flecha2cont:
                jmp engagebar
flecha1:
                call updmouse
                cmp [byte cs:mouserow],06
                ja flecha2cont
                jne retroceder
flech1:
                cmp [byte cs:mousecolumn],0
                jz flechend1
                mov [word cs:waittics],1
retroceder:
                cmp [byte cs:scrollrightbut],0
                jz noscrolltag1
                call taguntagselective
noscrolltag1:
                call oneminusfile
                call updatetics2
                call waitxtics
                mov ax,0003
                int 33h
                and bx,11b
                cmp bx,01b
                jz flecha1
                cmp bx,10b
                jz flecha1
                jmp setinsideup
flechamas:
                mov [word cs:waittics],9
flechamasagain:
                call onemorefile
                call updatetics2
                call waitxtics
                mov ax,0005
                xor bx,bx
                int 33h
                cmp ax,0001h
                jnz flechaend2
                cmp [byte cs:mouserow],14h
                jnz flechaend2
                cmp [byte cs:mousecolumn],0
                jnz flechaend2
                mov [word cs:waittics],1
                jmp flechamasagain
flechaend2:
                ret
setinsidedown:
                mov ax,2
                int 33h
                mov ax,3
                int 33h
                mov ax,4
                mov dx,19*8
                int 33h
                mov cl,3
                shr cx,cl
                mov [byte cs:mouserow],19
                mov [byte cs:mousecolumn],dl
                mov ax,1
                int 33h
flechend2:
                jmp endmousehandler
flecha1cont:
                jmp engagebar
flecha2:
                call updmouse
                cmp [byte cs:mouserow],14h
                jb flecha1cont
                jne avanzar
flech2:
                cmp [byte cs:mousecolumn],0
                jz flechend2
                mov [word cs:waittics],1
avanzar:
                cmp [byte cs:scrollrightbut],0
                jz noscrolltag2
                call taguntagselective
noscrolltag2:
                call onemorefile
                call updatetics2
                call waitxtics
                mov ax,0003
                int 33h
                and bx,11b
                cmp bx,01b
                jz flecha2
                cmp bx,10b
                jz flecha2
                jmp setinsidedown
pushflags:
                mov [word cs:registers],ds
                mov [word cs:registers+02],es
                mov [word cs:registers+04],si
                mov [word cs:registers+06],di
                mov [word cs:registers+08],ax
                mov [word cs:registers+0ah],bx
                mov [word cs:registers+0ch],cx
                mov [word cs:registers+0eh],dx
                pushf
                pop ax
                mov [word cs:registers+10],ax
                mov ax,[word cs:registers+08]
                ret
popflags:
                mov ds,[word cs:registers]
                mov es,[word cs:registers+02]
                mov si,[word cs:registers+04]
                mov di,[word cs:registers+06]
                mov bx,[word cs:registers+0ah]
                mov cx,[word cs:registers+0ch]
                mov dx,[word cs:registers+0eh]
                mov ax,[word cs:registers+10h]
                push ax
                popf
                mov ax,[word cs:registers+08]
                ret
waitxtics:
                mov ax,[word es:bx]
                mov dx,[word es:bx+2]
                clc
                sub ax,[word cs:targettics]
                sbb dx,[word cs:targettics+2]
                js waitxtics
                ret
locatepercentage:
                int 3
                xor ax,ax
                mov dl,[byte cs:dirpointer]
                mov al,[byte cs:mouserow]
                add dl,07
                cmp dl,al
                je nolocatepercent
                sub al,07
                mov [byte cs:dirpointer],al
                xor dx,dx
                mov cx,[word cs:filesentries]
                cmp cx,1
                jz onefilepercent
                dec cx
                clc
                mul cx
                clc
                mov cx,13
                div cx
                cmp dx,6
                jbe noresto
                inc ax
noresto:
                xor dx,dx
                clc
                mov cx,23
                mul cx
onefilepercent:
                mov [word cs:firstfileoffset],ax
                mov [word cs:currfileoffset],0
nolocatepercent:
                ret
