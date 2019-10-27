Title X-TRACT v2.00 - TNG ("The Next Generation of unprotectors" ;)
Title A totally re-written version of this nice and CooL program!
Title Pablo lives in somewhere of the time ... (With Gaby, of course! :)~

.8086

                        model huge
                        ideal
                        stack 1024
segment main word use16
assume cs:main,ds:main,es:main
xtrmain:
                        call getdosversion
                        cmp al,03h
                        jae getcommands
                        mov [byte cs:errorlevel],01h
                        mov dx,offset incorrectversion
                        mov [word cs:textsegment],cs
                        call far main:print
                        jmp xtractend

getcommands:
                        mov ah,62h
                        int 21h
                        mov [word cs:pspxtract],bx
                        call getcommandline ; Obtengo la l¡nea de comandos,
                                            ; y veo que hacer ;)
                        cmp [byte cs:paramamount],04h ; Si son 0-4 par metros,
                        jbe tryswapping               ; ==> Ver si se puede
                        mov [word cs:textsegment],cs  ; hacer "swap" de memoria
                        mov dx,offset introtitle
                        call far main:print
                        mov dx,offset toomanyparameters
                        call far main:print
                        call copycurrexeloaded
                        mov dx,offset xtrexefile
                        call far main:print
                        mov dx,offset toomanyparameters2
                        call far main:print
                        jmp xtractend
tryswapping:
                        call detectswapmethodandmembase
                        jnc dowithparam
                        call showneededmem
                        jmp xtractend
dowithparam:
                        call setdta
                        cmp [byte cs:paramamount],00h
                        jz gotomenu
                        mov [word cs:textsegment],cs
                        mov dx,offset introtitle
                        call far main:print
                        call showsystemresources
                        jmp fullend
                        call paramsupper2lower
                        call identifyparams

                        cmp [byte cs:commandtype],0
                        jnz checkcommandbehaviour
gotomenu:
                        jmp far menu:menumain

checkcommandbehaviour:
                        mov [word cs:textsegment],cs
                        mov dx,offset introtitle
                        call far main:print
                        jmp checkbehaviour
fullend:
                        call freememory
                        call restoredta
xtractend:
                        mov ah,04ch
                        mov al,[byte cs:errorlevel]
                        int 21h
checkbehaviour:
                        jmp xtractend

print:
                        cmp [byte cs:printok],0
                        jnz endprint
                        mov ah,09h
                        mov ds,[word cs:textsegment]
                        int 21h
endprint:
                        retf
showneededmem:
                        mov [byte cs:errorlevel],03h
                        mov dx,offset notenoughmem1
                        mov [word cs:textsegment],cs
                        call far main:print
                        mov ax,main
                        mov es,ax
                        mov di,offset string32bit
                        clc
                        xor dx,dx
                        mov ax,[word cs:xtractparasize]
                        add ax,1001h
                        mov bx,ax
                        xor ax,ax
                        mov cx,0010h
sumamem:
                        add ax,bx
                        adc dx,0
                        loop sumamem
                        clc
                        mov cx,1024
                        div cx
                        cmp dx,0
                        jz notadd
                        xor dx,dx
                        clc
                        add ax,0001h
                        adc dx,0
notadd:
                        call far main:hex2asc
                        mov dx,offset string32bit
                        call far main:print
                        mov dx,offset notenoughmem2
                        call far main:print
                        ret
setdta:
                        mov ah,02fh
                        int 21h
                        mov [word cs:dtaoriginal],bx
                        mov [word cs:dtaoriginal+2],es
                        mov ah,01ah
                        lds dx,[dword cs:dtaxtractoffset]
                        int 21h
                        ret
restoredta:
                        mov ah,01ah
                        lds dx,[dword cs:dtaoriginal]
                        int 21h
                        ret
include 'swap.asm'
include 'dosver.asm'
include 'cmdline.asm'
include 'showres.asm'
include 'hex2asc.asm'
include 'date.asm'
include 'messages.asm'
include 'data.asm'
ends
segment dtasegment para use16
dtaxtract                db 20h dup ('dta ')
ends
segment menu para use16
assume cs:menu,ds:main,es:menu
include 'menu.asm'
ends
segment dummy
ends
include 'hidden.asm'
end xtrmain

