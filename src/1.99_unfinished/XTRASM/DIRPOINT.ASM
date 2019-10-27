showdirpointer:
                        push ds
                        call calcpercent
                        cmp al,[byte cs:dirpointer]
                        je updatepointer
                        push ax
                        mov ah,31
                        mov si,offset vbarnormal
                        call printdirpointer
                        pop ax
updatepointer:
                        mov [byte cs:dirpointer],al
                        mov si,offset dirpointerchar
                        mov ah,31
                        call printdirpointer
                        pop ds
                        ret
calcpercent:
                        mov ax,[word cs:firstfileoffset]
                        add ax,[word cs:currfileoffset]
                        clc
                        xor dx,dx
                        mov cx,23
                        div cx
                        mov cx,12
                        clc
                        mul cx
                        mov cx,[word cs:filesentries]
                        dec cx
                        jcxz nodivpercent
                        clc
                        div cx
nodivpercent:
                        ret
printdirpointer:
                        mov bx,menu
                        mov ds,bx
                        mov cx,1
                        mov bh,7
                        add bh,[byte cs:dirpointer]
                        mov bl,0
                        call printat
                        ret
