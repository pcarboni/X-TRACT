include 'screen1.asm'
include 'datamenu.asm'
include 'printat.asm'
include 'shwfiles.asm'
include 'showbar.asm'
include 'mouse.asm'
include 'dirpoint.asm'
menumain:
                mov ah,0fh                      ;  Obtengo modo de video, y
                int 10h                         ;
                mov [byte cs:videomode],al      ;  p gina, para su posterior
                mov [byte cs:videopage],bh      ;
                ;cmp al,02h                      ;  uso. Si no es modo 02h, 03h,
                ;jz gotosavescreen               ;
                cmp al,03h                      ;  o 07h, aborto la sesi¢n y
                jz gotosavescreen               ;
                ;cmp al,07h                      ;  muestro el mensaje
                ;jz gotosavescreen               ;
                mov ax,main                     ; "Modo de video no
                mov ds,ax                       ;  soportado..." ,
assume ds:main
                mov [word ds:textsegment],main     ;
                mov dx,offset unsupportedvideomode ;  finalizando la ejecuci¢n
assume ds:menu
                call far main:print                ;  del programa.
                jmp far main:fullend               ;

gotosavescreen:                                    ;
                call getcurrentpageoffsetandsegment;
                mov [byte cs:mouse],0              ; Mouse sin inicializar
assume ds:main
                mov ax,main
                mov ds,ax
                mov ax,[word ds:segment1]
                mov [word cs:segment1dir],ax
assume ds:menu
savecurrentscreen:                                 ;
                lds si,[dword cs:videooffset]      ; De un saque, conservo la
                mov ax,main                        ;
                mov es,ax                          ; pantalla original,
                mov di,offset savescreen           ;
                mov cx,2000                        ; en un frasco
                cld                                ;
                rep movsw                          ; de "formol" ;)
getcursorstate:
                mov ah,03h                         ;  Obtengo estado y
                mov bh,[byte cs:videopage]         ;  coordenadas del cursor
                int 10h                            ;
                mov [word cs:cxcursor],cx          ;
                mov [word cs:dxcursor],dx          ;
getoutcursor:
                mov ah,02h                         ;  Mando a "mudar" al cursor
                mov bh,[byte cs:videopage]         ;
                mov dl,[byte cs:dxcursor]          ;  (Pobrecito! :-)
                mov dh,25                          ;
                int 10h                            ;
                call savecurrentpath
copymenuscreen1:
                mov ax,menu                        ;  "Inserto" la pantalla
                mov ds,ax                          ;
                mov si,offset screen1              ;   del menu en el display
                les di,[dword cs:videooffset]      ;
                mov cx,2000                        ;   de la tarjeta de video
                cld                                ;
                rep movsw                          ;
showpath:
                mov [word cs:firstfileoffset],0    ; Inicializo variables
                mov [word cs:filepointer],0        ; para la 'navegaci¢n' ;-)
                call getcurrentpath                ; Obtengo el path actual
                call makedirentries                ; Leo TODO un sub-dir
                call showcurrentpath               ; Muestro el path actual
showdir:
                call show13files                   ; Muestro solo 13 files
showfileselector:
                mov [byte cs:colorbar],063         ; Color inverso
                call showfilepointer               ; Muestro un puntero en el
                                                   ; archivo actual.
                cmp [byte cs:mouse],01h            ; Si est  (inicializado)
                jz getanykey                       ; o no existe mouse,
                cmp [byte cs:mouse],0ffh           ; desv¡o el llamado
                jz getanykey                       ;
                push ds                            ;
                call initmouse                     ;
                pop ds                             ;
getanykey:
                cmp [byte cs:insideint33],00
                jz noevent
                ret
noevent:
                xor ax,ax
                int 16h
emulatekeys:
                cmp ax,05000h                    ; Se puls¢ tecla cursor abajo?
                jz dispatchdownkey               ; S¡
                cmp ax,04800h                    ; Se puls¢ cursor arriba?
                jz dispatchupkey                 ; S¡
                cmp ax,01c0dh                    ; Fue un Enter?
                jz dispatchenterkey              ; S¡
                cmp ax,04700h                    ; Fue un Home?
                jz dispatchhomekey               ; S¡
                cmp ax,04f00h                    ; Fue un End?
                jz dispatchendkey                ; S¡
                cmp ax,05100h                    ; Fue un page down?
                jz dispatchpagedownkey           ; S¡
                cmp ax,04900h                    ; Fue un page up?
                jz dispatchpageupkey             ; S¡
                cmp ax,03920h                    ; Fue un spacebar?
                jz dispatchspacebar              ; S¡
                cmp ax,0011bh                    ; Fue escape?
                jnz getanykey                    ; Si no fue, lee de vuelta el
                                                 ; teclado
                cmp [byte cs:mouse],01h          ;
                jnz nomouseoff
                mov dx,[word cs:oldmousepointer]   ; Restauro rutinas previas
                mov es,[word cs:oldmousepointer+2] ; manejadas por el mouse
                mov cx,[word cs:oldmouseevent]     ;
                mov ax,000ch
                int 33h
                xor ax,ax
                int 33h
nomouseoff:
                call restorefullscreen           ; Reestablezco la pantalla
                                                 ; original.
                call restorecurrentpath          ; Lo mismo con el Path
                jmp far main:fullend
dispatchdownkey:
                jmp onemorefile
dispatchupkey:
                jmp oneminusfile
dispatchenterkey:
                jmp changeorgetinfo
dispatchhomekey:
                jmp firstfileshow
dispatchendkey:
                jmp lastfileshow
dispatchpagedownkey:
                jmp forward13files
dispatchpageupkey:
                jmp rewind13files
dispatchspacebar:
                jmp taguntagfile
getanykey1:
                jmp getanykey
onemorefile:
                mov al,[byte cs:filesentries] ; Cantidad TOTAL de archivos
                cmp al,13                     ; Si es mayor que 13, entonces
                ja showmorefiles              ; intentar hacer "scroll" de fila
                dec al                        ; Entradas de 1 a x = 0 a x-1
                cmp [byte cs:filepointer],al
                je getanykey1
                jmp scrolldown
showmorefiles:
                cmp [byte cs:filepointer],12
                jz showmoredirs
scrolldown:
                mov [byte cs:colorbar],031
                call showfilepointer
                inc [byte cs:filepointer]
                jmp showfileselector
showmoredirs:
                mov ax,[word cs:firstfileoffset]
                xor bx,bx
                xor ch,ch
                mov cl,[byte cs:filepointer]
                jcxz dontaddpointer
addpointer:
                add bx,023
                loop addpointer
dontaddpointer:
                add ax,bx
                cmp ax,[word cs:lastfileoffset]
getanykey2:
                jz getanykey1
                add [word cs:firstfileoffset],23
                jmp showdir
oneminusfile:
                cmp [byte cs:filepointer],0
                jz showminusdirs
                mov [byte cs:colorbar],031
                call showfilepointer
                dec [byte cs:filepointer]
                jmp showfileselector
showminusdirs:
                cmp [word cs:firstfileoffset],0
                jz getanykey2
                sub [word cs:firstfileoffset],23
                jmp showdir
getcurrentpageoffsetandsegment:
                mov ax,0b000h
                cmp [byte cs:videomode],07h
                jz storevideosegment
                add ax,0800h
storevideosegment:
                mov [word cs:videosegment],ax
                xor ax,ax
                mov bx,1000h ; Tama¤o VISIBLE de la pantalla.
                xor ch,ch
                mov cl,[byte cs:videopage]
                jcxz endpageoffset
videocount:
                add ax,bx
                loop videocount
endpageoffset:
                mov [word cs:videooffset],ax
                ret

restorefullscreen:
                les di,[dword cs:videooffset]      ; De un saque, leo el
                mov ax,main                        ; puntero de la pantalla
                mov ds,ax                          ; original, y la restauro
                mov si,offset savescreen           ;
                mov cx,2000                        ;
                cld                                ;
                rep movsw                          ;
                mov ah,02h                         ; Re-establezco el cursor
                mov bh,[byte cs:videopage]         ;
                mov dx,[word cs:dxcursor]          ; original y su posici¢n.
                int 10h                            ;
                ret
makedirentries:
                mov [word cs:filesentries],0
                mov ax,menu
                mov ds,ax
                mov ah,04eh
                mov cx,00110111b ; Busco archives+hidden+readonly+system
                mov dx,offset filespecmenu
                int 21h
                jnc storeentry
fakeentry:
                mov [word cs:filesentries],1
                mov ax,main
                mov ds,ax
assume ds:main,es:main
                mov es,[word ds:segment1]
assume ds:menu,es:menu
                xor di,di
                xor ax,ax
                stosw
                mov ax,0001000000000000b
                stosw
                ret
storeentry:
                mov ax,main
                mov ds,ax
assume ds:main,es:main
                mov es,[word ds:segment1]
assume ds:menu,es:menu
                xor di,di
                xor al,al
                mov cx,0ffffh
                cld
                rep stosb
                xor di,di
                mov ax,dtasegment
                mov ds,ax
assume ds:dtasegment
                mov si,offset dtaxtract
assume ds:menu
startentry:
                xor ax,ax
                stosw
                xor ax,ax
                mov bl,[byte ds:si+015h]
checkdir:
                test bl,00010000b
                jz checkreadonly
                cmp [word ds:si+1eh],002eh
                jnz setdirflag
                sub di,0002h
                jmp getanotherfile
setdirflag:
                or al,00010000b
checkreadonly:
                test bl,00000001b
                jz checkhidden
                or al,00000100b
checkhidden:
                test bl,00000010b
                jz checksystem
                or al,00000010b
checksystem:
                test bl,00000100b
                jz storeflags
                or al,00001000b
storeflags:
                stosw
                xor bx,bx
getanotherfilechar:
                mov al,[byte ds:si+bx+1eh]
                or al,al
                jz storenamesize
                test [byte ds:si+015h],00010000b
                jnz nolower
                call file2lower
nolower:
                inc bl
                mov [byte es:di+bx],al
                jmp getanotherfilechar
storenamesize:
                mov al,bl
                stosb
                add di,12
                mov ax,[word ds:si+01ah]
                stosw
                mov ax,[word ds:si+01ah+2]
                stosw
                mov ax,[word ds:si+018h]
                stosw
                inc [word cs:filesentries]
getanotherfile:
                mov ah,04fh
                int 21h
                jnc startentry
                mov cx,[word cs:filesentries]
                xor ax,ax
                cmp cx,1
                jbe endfilesentries
                dec cx
addentriesoffset:
                add ax,23
                loop addentriesoffset
endfilesentries:
                mov [word cs:lastfileoffset],ax
                ret
getcurrentpath:
                mov ax,menu
                mov es,ax
                mov di,offset driveletter
                mov ah,019h
                int 21h
                mov dl,al
                inc dl
                add al,041h
                stosb
                mov ax,'\:'
                stosw
                mov ax,es
                mov ds,ax
                mov si,di
                mov ah,047h
                int 21h
                mov si,offset driveletter
                xor cx,cx
getpathletteragain:
                mov al,[byte ds:si]
                or al,al
                jz endofgetpath
                inc cl
                inc si
                cmp al,'a'
                jb getpathletteragain
                cmp al,'z'
                ja getpathletteragain
                sub al,020h
                mov [byte ds:si-1],al
                jmp getpathletteragain
endofgetpath:
                mov [byte cs:pathsize],cl
                ret
showcurrentpath:
                mov ax,menu
                mov ds,ax
                mov si,offset currpath
                xor ch,ch
                mov cl,[byte cs:pathsize]
                mov ah,031
                mov bx,030fh
                call printat
                ret
file2lower:
                cmp al,'A'
                jb retlower
                cmp al,'Z'
                ja retlower
                add al,020h
retlower:
                ret
changeorgetinfo:
                call chgorgetinf
                cmp al,0ffh
                jz jmptogetanykey
                jmp copymenuscreen1
jmptogetanykey:
                jmp getanykey

chgorgetinf:
                push ds
                push es
                push si
                push di
                push ax
                push bx
                push cx
                push dx
                pushf
                mov ax,menu
                mov es,ax
                mov ds,[word cs:segment1dir]
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                test [word ds:si+02],10000b
                jz trytogetknowninfo
                add si,0005h
                mov di,offset currentpath
                xor ch,ch
                mov cl,[byte ds:si-1]
                cld
                rep movsb
                xor al,al
                stosb
                mov ah,03bh
                push cs
                pop ds
                mov dx,offset currentpath
                int 21h
                popf
                pop dx
                pop cx
                pop bx
                pop ax
                pop di
                pop si
                pop es
                pop ds
                xor al,al
                ret
trytogetknowninfo:
                popf
                pop dx
                pop cx
                pop bx
                pop ax
                pop di
                pop si
                pop es
                pop ds
                mov al,0ffh
                ret
firstfileshow:
                mov ax,[word cs:firstfileoffset]
                or ax,ax
                jnz endfirstfileshow
                mov ax,[word cs:currfileoffset]
                or ax,ax
                jnz endfirstfileshow
                mov al,[byte cs:filepointer]
                or al,al
                jnz endfirstfileshow
                jmp getanykey
endfirstfileshow:
                mov [word cs:firstfileoffset],0
                mov [word cs:currfileoffset],0
                mov [byte cs:filepointer],0
                jmp showdir
lastfileshow:
                mov ax,[word cs:lastfileoffset]
                mov bx,ax
                sub bx,[word cs:currfileoffset]
                cmp bx,[word cs:firstfileoffset]
                jnz showendoflist
                jmp getanykey
showendoflist:
                mov [word cs:currfileoffset],ax
                mov cx,[word cs:filesentries]
                cmp cx,13
                jbe menosentradas
                mov cx,13
menosentradas:
                dec cx
                mov [byte cs:filepointer],cl
menosloop:
                sub ax,00017h
                loop menosloop
                mov [word cs:firstfileoffset],ax
                jmp showdir
forward13files:
                mov cx,[word cs:filesentries]
                cmp cx,13
                jbe menosentradas3
                mov cx,13
menosentradas3:
                dec cx
                cmp [byte cs:filepointer],cl
                jnz gotoendofpage
                cmp [word cs:filesentries],13
                ja checkifpartialpage
                jmp getanykey
checkifpartialpage:
                mov ax,[word cs:lastfileoffset]
                mov dx,[word cs:firstfileoffset]
                add dx,[word cs:currfileoffset]
                cmp dx,ax
                jnz checkpartial2
                jmp getanykey
checkpartial2:
                sub ax,0017h*12
                add dx,0017h
                cmp dx,ax
                jbe setpage
                jmp setlastpage
setlastpage:
                mov dx,[word cs:lastfileoffset]
                sub dx,[word cs:currfileoffset]
setpage:
                mov [word cs:firstfileoffset],dx
                jmp endofpagedown
gotoendofpage:
                mov [byte cs:filepointer],cl
masloop:
                add [word cs:currfileoffset],0017h
                loop masloop
endofpagedown:
                jmp showdir
rewind13files:
                mov cx,[word cs:filesentries]
                cmp cx,13
                jbe menosentradas4
                mov cx,13
menosentradas4:
                dec cx
                cmp [byte cs:filepointer],0
                jnz gotostartofpage
                cmp [word cs:filesentries],13
                ja checkifpartialpage2
jmptogetkey:
                jmp getanykey
checkifpartialpage2:
                mov ax,[word cs:firstfileoffset]
                mov bx,ax
                add ax,[word cs:currfileoffset]
                cmp ax,0
                jz jmptogetkey
                cmp ax,017h*012
                jbe setfirstpage
                sub bx,0017h*13
setpage2:
                mov [word cs:firstfileoffset],bx
                jmp endofpageup
setfirstpage:
                xor bx,bx
                jmp setpage2
gotostartofpage:
                mov [byte cs:filepointer],0
menosloop2:
                mov [word cs:currfileoffset],0000h
endofpageup:
                jmp showdir
savecurrentpath:
                mov ax,menu
                mov ds,ax
                mov es,ax
                mov ah,19h
                int 21h
                mov [byte cs:savedrive],al
                inc al
                mov dl,al
                mov di,offset savepath
                mov al,'\'
                stosb
                mov si,di
                mov ah,047h
                int 21h
                ret
restorecurrentpath:
                mov ax,menu
                mov ds,ax
                mov ah,0eh
                mov dl,[byte cs:savedrive]
                int 21h
                mov ah,03bh
                mov dx,offset savepath
                int 21h
                ret
taguntagfile:
                call taguntagselective
                jmp onemorefile


taguntagselective:
                mov ds,[word cs:segment1dir]
                mov si,[word cs:firstfileoffset]
                add si,[word cs:currfileoffset]
                test [word ds:si+02],10000b
                jnz donttag
                xor [word ds:si+02],1b
donttag:
                mov [byte cs:colorbar],63
                call showfilepointer
                ret
