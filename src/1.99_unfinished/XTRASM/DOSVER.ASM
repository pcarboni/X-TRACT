; Obtengo la versi¢n de DOS a efectos de ejecutar el programa CORRECTAMENTE :)

getdosversion:
                mov ax,3000h
                int 21h
                mov [byte cs:versionhi],al
                mov [byte cs:versionlo],ah
                ret
