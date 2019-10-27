; Ac  est n ubicadas todas las variables del programa

string32bit     db 0bh dup (0) ; N£mero a imprimir
handle1         db 0  ; Handle n£mero 1 para cualquier tipo de dispositivo
errorlevel      db 0  ; Errorlevel que devuelve (Util cuando el programa se
                      ; ejecuta dentro de un archivo BATCH)
                      ; 0 = Acci¢n ejecutada correctamente
                      ; 1 = Versi¢n de DOS < v3.00
                      ; 2 = Par metros > o = 5
                      ; 3 = No hay memoria suficiente!
versionhi       db 0  ; N£mero de versi¢n del DOS obtenida (x.xx)
versionlo       db 0  ;
segment1        dw 0  ; Segmento de memoria reservado
dtaoriginal     dw 0,0; Puntero del Data Transfer Address original.
assume ds:dtasegment
dtaxtractoffset dw offset dtaxtract, dtasegment; Trucho pero efectivo:
assume ds:main                                 ; Segmento:Offset del DTA propio
xtractparasize  dw 0  ; Longitud en par grafos del X-TRACT.EXE (Con o sin men£)
swapsizepara    dw 0  ; Cantidad de par grafos a "swapear" ;)
swapmethod      db 0  ; M‚todo de "swap" para ganar memoria:
                      ; 0 = No hay swap que valga!
                      ; 001b = XMS
                      ; 010b = EMS
                      ; 100b = DISK
                      ;
xmsdriver       dw 0,0; Direcci¢n del driver de XMS
xmsver          db 0,0; Versi¢n x.xx
xmssize         dw 0  ; Tama¤o de la XMS libre
emsver          db 0  ; Versi¢n en formato BCD xxxxiiii xxxx=MSB iiii=LSB
emsparasize     dw 0  ; Tama¤o en par grafos de la EMS.
lodiskfree      dw 0  ; Word bajo del tama¤o en 32 bits
hidiskfree      dw 0  ;  ''  alto  '    ''   '' ''  ''
printok         db 0  ; Si este byte est  a uno, entonces comportarse en modo
                      ; "quieto" (Sin salida visible en pantalla)
textsegment     dw 0  ; Segmento del texto a imprimir
pspxtract       dw 0  ; Program Segment Prefix perteneciente al X-TRACT
savescreen      db 4000 dup (0) ; Pantalla original con caracteres y atributos.
paramamount     db 0  ; Cantidad de par metros (0, 1, 2, 3, o 4)
originalcmdtail db 0,080h dup (0) ; Este es el command line original
paramcmd1       db 0,080h dup (0) ; Si es que hay 1er par metro, lo copio aqu¡.
paramcmd2       db 0,080h dup (0) ; Si es que hay 2do par metro, lo copio aqu¡.
paramcmd3       db 0,080h dup (0) ; Si es que hay 3er par metro, lo copio aqu¡.
paramcmd4       db 0,080h dup (0) ; Si es que hay 4er par metro, lo copio aqu¡.
commandtype     db 0  ; Tipo de comando (0=menu 1=help
                      ;                  2=extraer archivo original)
                      ;
                      ;
xtrexefile      db 00ch dup (0),0 ; Nombre del ejecutable del X-TRACT
                                  ; cargado en memoria
whichparam      dw 0 ; ¨Cu l par metro estoy leyendo? ;-)
validcommandsoff:
                dw 0 ; Comando actualmente comparado
emsid           db 'EMMXXXX0',0
validcommands:
                db 05h,'/help ' ; Comando Nro 1
                db 02h,'/h    ' ;             2
                db 02h,'/?    ' ;             3
                db 06h,'/quiet' ;             4
                db 02h,'/q    ' ;             5
                db 05h,'/info ' ;             6
                db 02h,'/i    ' ;             7
                db 00h ; Con el 0, indico que no hay m s comandos

