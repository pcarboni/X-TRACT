; Esta rutina permite escribir un string en la pantalla de video, directamente
; a la memoria de la placa (Sin intervenci¢n del bios).
;
; Entrada: DS:SI = Segmento:Offset del string
;             CX = longitud del string
;             AH = Atributos de color a imprimir en la pantalla.
;          BH,BL = Fila, Columna (0-24, 0-79)
printat:
                push ds
                push si
                push es
                push di
                push ax
                push bx
                push cx
                jcxz noprintat
                cmp [byte cs:mouse],01h
                jnz nohidemouse
                call getmousepos
                call hideifmouse
nohidemouse:
                push cx
                cld
                les di,[dword cs:videooffset]
                xor ch,ch
                mov cl,bh
                jcxz calccolumna
calcfila:
                add di,80*2
                loop calcfila
calccolumna:
                mov cl,bl
                add cl,cl
                add di,cx
                pop cx
getonechar:
                lodsb
                stosb
                xchg ah,al
                stosb
                xchg ah,al
                loop getonechar
noprintat:
                pop cx
                pop bx
                pop ax
                pop di
                pop es
                pop si
                pop ds
                cmp [byte cs:mouse],01h
                jnz endprintat
                call showifmouse
endprintat:
                ret
getmousepos:
                push ax
                push bx
                push cx
                push dx
                pushf
                mov ax,0003
                int 33h
                mov ax,dx
                mov bx,cx
                mov cl,3
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
endmousepos:
                ret
hideifmouse:
                cmp bh,[byte cs:mouserow]
                jnz endhideifmouse
                push ax
                mov ax,0002h
                int 33h
                pop ax
endhideifmouse:
                ret
showifmouse:
                cmp bh,[byte cs:mouserow]
                jnz endshowifmouse
                push ax
                mov ax,0001h
                int 33h
                pop ax
endshowifmouse:
                ret

