show13files:
                mov ax,main
                mov es,ax
                mov cx,[word cs:filesentries]
                cmp cx,1
                jnz shownormal
assume es:main
                mov ds,[word es:segment1]
assume es:menu
                test [word ds:002h],0001000000000000b
                jz shownormal
                mov ax,cs
                mov ds,ax
                mov si,offset emptydir
                mov ah,031
                mov cx,80*2
                mov bh,07h
                xor bl,bl
                call printat
                ret
shownormal:
                cmp cx,13
                jbe initamountfiles
                mov cx,13
initamountfiles:
                mov [word cs:currfileoffset],0
                mov [byte cs:currrow],07
assume es:main
                mov ds,[word es:segment1]
assume es:menu
showfileagain:
                mov si,[word cs:firstfileoffset]
                push cx
                call showfilename
                call showfilesize
                call showfiledate
                call showinternaltype
                call showroutineid
                pop cx
                add [word cs:currfileoffset],23
                inc [byte cs:currrow]
                loop showfileagain
                ret
showfilename:
                mov [byte cs:colorbar],31
                push ds
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                test [word ds:si+02],1b
                jz dontshowtagged
                mov si,offset flecha
                and [byte cs:colorbar],11111110b
                jmp showprevfilechar
dontshowtagged:
                mov si,offset espacios
showprevfilechar:
                mov ax,cs
                mov ds,ax
                mov cx,1
                mov bh,[byte cs:currrow]
                mov bl,01h
                mov ah,[byte cs:colorbar]
                call printat
                pop ds
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                push ds
                push si
                call showfileonly
                pop si
                pop ds
                push ds
                mov cx,13
                mov bh,[byte ds:si+4]
                sub cl,bh
                mov bl,02h
                add bl,bh
                mov bh,[byte cs:currrow]
                mov ax,cs
                mov ds,ax
                mov ah,31
                mov si,offset espacios
                call printat
                pop ds
                ret
showfileonly:
                add si,5
                xor ch,ch
                mov cl,[byte ds:si-1]
                mov bh,[byte cs:currrow]
                mov bl,02h
                mov ah,[byte cs:colorbar]
                call printat
                ret
showfilesize:
                push ds
                mov di,[word cs:firstfileoffset]
                mov si,di
                add si,[word cs:currfileoffset]
                test [word ds:si+2],00010000b
                jz showfilenumberssize
                cmp [word ds:si+4],02e02h
                jnz subdirok2
                cmp [byte ds:si+6],0002eh
                jnz subdirok2
                mov si,offset updir
                jmp alldirok2
subdirok2:
                mov si,offset subdir
alldirok2:
                mov ax,menu
                mov ds,ax
                mov cx,000ah
                mov bh,[byte cs:currrow]
                mov bl,10h
                mov ah,[byte cs:colorbar]
                call printat
                pop ds
                ret
showfilenumberssize:
                call showfilenumbers
                pop ds
                ret

showfilenumbers:
                mov ax,main
                mov es,ax
assume ds:main,es:main
                mov di,offset string32bit
assume ds:menu,es:menu
                mov dx,[word ds:si+013h]
                mov ax,[word ds:si+011h]
                call far main:hex2asc
                call calcleftspaces
                push cx
                mov ax,cs
                mov ds,ax
                mov si,offset espacios
                mov bh,[byte cs:currrow]
                mov bl,10h
                mov ah,[byte cs:colorbar]
                mov ch,10
                sub ch,cl
                mov cl,ch
                xor ch,ch
                call printat
assume ds:main,es:main
                mov si,offset string32bit
assume ds:menu,es:menu
                pop cx
                mov ax,main
                mov ds,ax
                xor ch,ch
                mov bl,10h
                mov bl,10h+10
                sub bl,cl
                mov bh,[byte cs:currrow]
                mov ah,[byte cs:colorbar]
                call printat
                ret
calcleftspaces:
assume ds:main,es:main
                mov cx,di
                sub cx,offset string32bit
assume ds:menu, es:menu
                ret
showfiledate:
                push ds
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                mov ax,menu
                mov es,ax
                mov di,offset filedate
                call getandstoreday
                call getandstoremonth
                call getandstoreyear
                call printdate
                pop ds
                ret
getandstoreday:
                mov ax,[word ds:si+021]
                and ax,11111b
                xor dx,dx
                cmp ax,10
                jae getday
                xchg ah,al
                mov al,'0'
                stosb
                xchg ah,al
                xor ah,ah
getday:
                call far main:hex2asc
                mov al,'-'
                stosb
                ret
getandstoremonth:
                push ds
                push si
                mov ax,[word ds:si+021]
                and ax,111100000b
                mov cx,5
                shr ax,cl
                mov si,offset months
                mov cx,ax
                dec cx
                jcxz endgetmonth
addmonth:
                add si,0003h
                loop addmonth
endgetmonth:
                mov ax,menu
                mov ds,ax
                mov es,ax
                cld
                mov cx,3
                rep movsb
                mov al,'-'
                stosb
                pop si
                pop ds
                ret
getandstoreyear:
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                mov ax,[word ds:si+021]
                and ax,1111111000000000b
                mov cx,9
                shr ax,cl
                add ax,1980
                xor dx,dx
                call far main:hex2asc
                ret
printdate:
                mov ax,menu
                mov ds,ax
                mov si,offset filedate
                mov ah,[byte cs:colorbar]
                mov bh,[byte cs:currrow]
                mov bl,27
                mov cx,11
                call printat
                ret
showinternaltype:
                push ds
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                test [word ds:si+02],100000000000b
                jz testexeflag
testexeflag:
                test [word ds:si+02],010000000000b
                jz testcomflag
testcomflag:
                test [word ds:si+02],001000000000b
                jz showguiones4
showguiones4:
                mov ax,menu
                mov ds,ax
                mov si,offset guiones4
                mov ah,[byte cs:colorbar]
                mov bh,[byte cs:currrow]
                mov bl,39
                mov cx,6
                call printat
                pop ds
                ret
showroutineid:
                push ds
                mov di,[word cs:firstfileoffset]
                add di,[word cs:currfileoffset]
                test [word ds:di+02],100000b
                jnz showcorrectid
                mov si,offset pressfileinfo
                test [word ds:di+02],10000b
                jz whatshouldIdo
                mov si,offset presssubdir
                cmp [word ds:di+4],02e02h
                jnz whatshouldIdo
                cmp [byte ds:di+6],0002eh
                jnz whatshouldIdo
                mov si,offset pressupdir
whatshouldIdo:
                mov ax,menu
                mov ds,ax
                mov ah,[byte cs:colorbar]
                mov bh,[byte cs:currrow]
                mov bl,46
                mov cx,33
                call printat
                pop ds
                ret
showcorrectid:
                pop ds
                ret


