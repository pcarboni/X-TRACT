; Ac  pongo los textos de errores correspondientes

incorrectversion        db 0dh,0ah,'This program needs DOS v3.00 or later!'
                        db 0dh,0ah,0ah,'$'
notenoughmem1           db 0dh,0ah,'Sorry, but X-TRACT needs at least $'
notenoughmem2           db 'kb of free memory.',0dh,0ah,'$'
unsupportedvideomode    db 0dh,0ah,'Unsupported video mode! - Try to execute'
                        db ' X-TRACT with command-line parameters.'
                        db 0dh,0ah
                        db '(Or execute X-TRACT /? for command-line help)'
                        db 0dh,0ah,'$'
toomanyparameters       db 'Too many parameters! - Try $'
toomanyparameters2      db ' /? for a little help.'
                        db 0dh,0ah,'$'
space                   db ' $'
xms                     db 'þ XMS version $'
ems                     db 'þ EMS version $'
disk                    db 'þ Current drive is $'
detected                db ' detected.',0dh,0ah,'$'
using                   db 'þ Using $'
xmsuse                  db 'extended $'
emsuse                  db 'expanded $'
diskuse                 db 'disk as $'
memory                  db 'memory for better performance.',0dh,0ah,'$'


