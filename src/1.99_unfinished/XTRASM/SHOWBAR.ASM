showfilepointer:
                mov ax,main
                mov es,ax
                mov [word cs:currfileoffset],0
assume es:main
                mov ds,[word es:segment1]
                cmp [word cs:filesentries],1
                jnz showbarnormal
assume es:menu
                test [word ds:002h],0001000000000000b
                jz showbarnormal
                ret
showbarnormal:
                mov di,[word cs:firstfileoffset]
                xor ch,ch
                mov cl,[byte cs:filepointer]
                jcxz endofcalcfilepointer
calcfilepointer:
                add [word cs:currfileoffset],23
                loop calcfilepointer
endofcalcfilepointer:
                call showleftspace
                mov si,di
                add si,[word cs:currfileoffset]
                add si,5
                xor ch,ch
                mov cl,[byte ds:si-1]
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov bl,02h
                mov ah,[byte cs:colorbar]
                call printat
                call showrightspace
                call showbarsize
                call showbardate
                call showbartype
                call showbarroutid
                call showdirpointer
                ret
showleftspace:
                push ds
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                test [word ds:si+02],1b
                jz dontshowtagged2
                mov si,offset flecha
                and [byte cs:colorbar],11111110b
                jmp showprevfilechar2
dontshowtagged2:
                mov si,offset espacios
showprevfilechar2:
                mov ax,menu
                mov ds,ax
                mov cx,1
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov bl,01h
                mov ah,[byte cs:colorbar]
                call printat
                pop ds
                and [byte cs:colorbar],11111111b
                ret
showrightspace:
                push ds
                push si
                mov cx,13
                sub cl,[byte ds:si-1]
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov bl,02h
                add bl,[byte ds:si-1]
                mov ax,menu
                mov ds,ax
                mov si,offset espacios
                mov ah,[byte cs:colorbar]
                call printat
                pop si
                pop ds
                ret
showbarsize:
                push ds
                push si
                mov si,di
                add si,[word cs:currfileoffset]
                test [word ds:si+2],00010000b
                jz showbarfilenumbers
                cmp [word ds:si+4],02e02h
                jnz subdirok
                cmp [byte ds:si+6],0002eh
                jnz subdirok
                mov si,offset updir
                jmp alldirok
subdirok:
                mov si,offset subdir
alldirok:
                mov ax,menu
                mov ds,ax
                mov cx,000ah
                mov bh,07
                add bh,[byte cs:filepointer]
                mov bl,10h
                mov ah,[byte cs:colorbar]
                call printat
                pop si
                pop ds
                ret
showbarfilenumbers:
                mov bh,07
                add bh,[byte cs:filepointer]
                mov [byte cs:currrow],bh
                call showfilenumbers
                pop si
                pop ds
                ret
showbardate:
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov [byte cs:currrow],bh
                call showfiledate
                ret
showbartype:
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov [byte cs:currrow],bh
                call showinternaltype
                ret
showbarroutid:
                mov bh,07h
                add bh,[byte cs:filepointer]
                mov [byte cs:currrow],bh
                call showroutineid
                ret


