; Obtengo la l¡nea de comandos, y devuelvo en el registro "al" el tipo de
; comportamiento a seguir

getcommandline:
                call copycmdtailtobuffer
                mov di,offset originalcmdtail+1
                xor ch,ch
                mov cl,[byte es:di-1]
                cld
                call skipspacesandtabs
                cmp [byte cs:paramamount],00h
                jnz get1stparam
                jmp noparam
get1stparam:
                mov ax,0001h
                mov si,di
                mov di,offset paramcmd1+1
                call getparam
                cmp al,0ffh
                jnz get2ndparam
                ret
get2ndparam:
                mov ax,0002h
                mov si,di
                mov di,offset paramcmd2+1
                call getparam
                cmp al,0ffh
                jnz get3rdparam
                ret
get3rdparam:
                mov ax,0003h
                mov si,di
                mov di,offset paramcmd3+1
                call getparam
                cmp al,0ffh
                jnz get4thparam
                ret
get4thparam:
                mov ax,0004h
                mov si,di
                mov di,offset paramcmd4+1
                call getparam
                cmp al,0ffh
                jnz toomanyparam
                ret

toomanyparam:
                mov [byte cs:errorlevel],02h
                ret
getparam:
                push ax
                mov bx,di
                dec bx
                xor dx,dx
getchars:
                lodsb
                cmp al,09h
                jz getanotherparam
                cmp al,020h
                jz getanotherparam
                stosb
                inc dl
                mov [byte es:bx],dl
                loop getchars
                pop ax
pregetend:
                mov ax,00ffh ; Indico que debo identificar par metros
getend:
                ret
getanotherparam:
                call preskipsptb
                pop ax
                cmp [byte cs:paramamount],al
                jnz getend
                jmp pregetend
noparam:
                mov [byte cs:commandtype],0
                ret
preskipspacesandtabs:
                inc di
skipspacesandtabs:
                jcxz nomoreparams
                mov al,[byte es:di]
                dec cx
                cmp al,09h
                jz preskipspacesandtabs
                cmp al,020h
                jz preskipspacesandtabs
                inc [byte cs:paramamount]
                inc cx
nomoreparams:
                ret
copycmdtailtobuffer:
                mov ax,main
                mov es,ax
                mov ds,[word cs:pspxtract]
                mov si,0080h
                mov di,offset originalcmdtail
                mov cl,[byte ds:si]
                xor ch,ch
                inc cl
                cld
                rep movsb
                mov ds,ax
                ret
preskipsptb:
                dec si
                mov di,si
                call skipspacesandtabs
                ret
paramsupper2lower:
                mov si,offset paramcmd1
                call upper2lower
                mov si,offset paramcmd2
                call upper2lower
                mov si,offset paramcmd3
                call upper2lower
                mov si,offset paramcmd4
                call upper2lower
                ret
upper2lower:
                mov ax,main
                mov ds,ax
                mov es,ax
                xor ch,ch
                mov cl,[byte cs:si]
                jcxz endupper
                inc si
                mov di,si
getupperchar:
                lodsb
                cmp al,'Z'
                ja loopupperchar
                cmp al,'A'
                jb loopupperchar
                add al,020h
loopupperchar:
                stosb
                loop getupperchar
endupper:
                ret
checkforvalid:
                mov ax,0001h
                mov [word cs:validcommandsoff],offset validcommands
getcommandlength:
                mov si,[word cs:whichparam]
                mov di,[word cs:validcommandsoff]
                mov cl,[byte cs:di]
                jcxz nomorecommands
                cmp [byte cs:si],cl
                jae checkcommand
morecommands:
                inc al
                add [word cs:validcommandsoff],0007h
                jmp getcommandlength
checkcommand:
                inc si
                inc di
                xor ch,ch
                cld
                rep cmpsb
                jz returncommand
                jmp morecommands
nomorecommands:
                xor ax,ax
returncommand:
                ret
identifyparams:
                cmp [byte cs:paramamount],0
                jnz checkforoneparam
                ret
checkforoneparam:
                mov [word cs:whichparam],offset paramcmd1
                call checkforvalid
                cmp al,01h
                jz sethelpcommand
                cmp al,02h
                jz sethelpcommand
                cmp al,03h
                jz sethelpcommand
                cmp al,04h
                jz setquiet
                cmp al,05h
                jz setquiet
                ret
sethelpcommand:
                mov [byte cs:commandtype],01h
                ret
setquiet:
                mov [byte cs:printok],01h
                ret
copycurrexeloaded:
                mov ds,[word cs:pspxtract]
                mov es,[word ds:02ch]
                xor di,di
                mov cx,0ffffh
                xor ax,ax
                cld
searchstartloadpath:
                repnz scasb
                cmp [byte es:di],0
                jnz searchstartloadpath
                add di,0003h
                mov si,di
                repnz scasb
                mov cx,di
                sub cx,si
                mov al,'\'
                std
                repnz scasb
                add di,0002h
                mov si,di
                push es
                pop ds
                push cs
                pop es
                mov di,offset xtrexefile
                mov cx,000ch
                cld
getanotherenvexechar:
                lodsb
                or al,al
                jz endofenvexefile
                cmp al,'a'
                jb storeexechar
                sub al,020h
storeexechar:
                stosb
                loop getanotherenvexechar
endofenvexefile:
                mov al,'$'
                stosb
                ret

