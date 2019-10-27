registers       dw 0,0,0,0,0,0,0,0,0
segment1dir     dw 0
sourcetics      dw 0,0
targettics      dw 0,0
tics            db 4,0
waittics        dw 0
clicks          db 0
insideint33     db 0
scrollrightbut  db 0
mouserow        db 0 ; Posici¢n del mouse, fila (0-24)
mousecolumn     db 0 ;    ''     '    '' , columna (0-79)
oldmouserow     db 0 ; Posici¢n PREVIA del mouse, fila (0-24)
oldmousecolumn  db 0 ;    ''      ''    '    '' , columna (0-79)
videomode       db 0 ; Modo de video actual (Solamente 80x25x16 colores, 03h)
videopage       db 0 ; P gina actual del modo de video detectado
videooffset     dw 0 ; Offset de la actual p gina de video.
videosegment    dw 0 ; Segmento del modo de video actual.
cxcursor        dw 0 ; Estado del cursor
dxcursor        dw 0 ; Fila y columna actual
savedrive       db 0            ; Drive y entrada de subdirectorio originales
savepath        db 64 dup (0),0 ;
filesentries    dw 0 ; Cantidad de entradas de directorio.
pathsize        db 0 ; Tama¤o del path
currpath:
driveletter     dw 0          ; Path actual (Drive+subdirectorio)
currentpath     db 64 dup (0),0 ;
firstfileoffset dw 0 ; Offset del primer archivo a mostrar
lastfileoffset  dw 0 ;   ''    '  £ltimo    ''   '    ''
currfileoffset  dw 0 ; Offset del archivo que se muestra cuando se imprime
                     ; parte del sub-directorio
currrow         db 0 ; L¡nea actual
filepointer     db 0   ; Localizar un puntero en el archivo Nro. xxx
dirpointer      db 0   ; Localizar un puntero del porcentaje actual de la
                       ; actual localizaci¢n del archivo
colorbar        db 0   ; Color de la barra, para poner o borrar la misma
mouse           db 0   ; 1 = Mouse presente
oldmousepointer dw 0,0 ; Puntero FAR de la rutina previa del mouse
oldmouseevent   dw 0   ; Flags del evento previo de la rutina
filedate:
fileday         db 0,0,0
filemonth       db 0,0,0,0
fileyear        db 0,0,0,0,0
filespecmenu    db '*.*',0
flecha          db ''
vbarnormal      db '°'
dirpointerchar  db 'ð'
updir           db 'PREV-DIR'
subdir          db 'SUBÄ-DIR'
months          db 'JanFebMarAprMayJunJulAugSepOctNovDec'
guiones4        db ' ---- '
pressfileinfo   db '<Enter> to get file info         '
presssubdir     db '<Enter> to get inside the sub-dir'
pressupdir      db '<Enter> to get the previous dir  '
espacios        db 14 dup (" ") ; Espacios para imprimir determinada cantidad
emptydir        db '³No directory  ³  Empty   ³   ----    ³  --  ³'
                db '             -------             ³'
                db '³entries found!³  Drive!  ³   ----    ³  --  ³'
                db '             -------             ³'
