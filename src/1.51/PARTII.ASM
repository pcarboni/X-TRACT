CHECKANTIGENCOM:
                CMP [BYTE DS:0101H],041H
                JNE CHECKANTIGENEXE

                PUSH CS
                POP ES
                MOV SI,0143H
                MOV DI,OFFSET ANTIGENCOMID
                MOV CX,0030
                CLD
                REP CMPSB
                JNZ CHECKTHEREST

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET ANTIGENCOM
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:0151H],09090H
                MOV [WORD DS:0158H],09090H
                MOV [WORD DS:0166H],09090H
                MOV [WORD DS:01EAH],09090H
                MOV [WORD DS:043DH],09090H
                MOV [BYTE DS:0220H],0EBH
                MOV [BYTE DS:027DH],0EBH

                MOV [WORD DS:0456H],0F0CDH

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET ANTIGENCOMBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]

ANTIGENCOMBRK0:
                MOV DS,[WORD CS:DSEGMENT]
                MOV CX,[WORD DS:0820H]
                MOV [WORD CS:FILESIZECOM],CX
                PUSH DS
                POP ES
                MOV SI,0C6CH
                MOV DI,0100H
                CLD
                REP MOVSB
                JMP BRKPRX31COM1
CHECKANTIGENEXE:
                CMP [BYTE DS:0101H],066H
                JNE CHECKCRYPT115

                PUSH CS
                POP ES
                MOV SI,0168H
                MOV DI,OFFSET ANTIGENEXEID
                MOV CX,0035
                CLD
                REP CMPSB
                JNZ CHECKTHEREST

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET ANTIGENEXE
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:017DH],09090H
                MOV [WORD DS:0184H],09090H
                MOV [WORD DS:0192H],09090H
                MOV [WORD DS:0216H],09090H
                MOV [WORD DS:0559H],09090H
                MOV [BYTE DS:024CH],0EBH
                MOV [BYTE DS:02D2H],0EBH

                MOV [WORD DS:055BH],0F0CDH

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET ANTIGENEXEBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
ANTIGENEXEBRK0:

                CLI
                MOV SS,[WORD CS:INITSSSP]
                MOV SP,[WORD CS:INITSSSP+02H]
                STI

                MOV AX,3D02H
                XOR BX,BX
                XOR CX,CX
                PUSH CS
                POP DS
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX

                MOV AX,3D00H
                XOR BX,BX
                XOR CX,CX
                PUSH CS
                POP DS
                MOV DX,OFFSET LINEPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE3],AX

                MOV AH,62H
                INT 21H
                MOV ES,BX

                MOV AH,49h
                INT 21H

                MOV ES,[WORD CS:PID3]

                MOV AX,ES
                MOV BX,XT
                SUB BX,AX

                MOV AH,4AH
                INT 21H

                MOV AH,48H
                MOV BX,0500H
                INT 21H

                JNC MEMOOKANTIGEN

                MOV DX,OFFSET NOTMEMO
                CALL PRINT

                MOV AH,3EH
                MOV BX,[WORD CS:HANDLE3]
                INT 21H
                MOV AH,3EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H


                MOV AX,4301H
                MOV DX,OFFSET TEMPPARAMETERS
                XOR CX,CX
                INT 21H


                MOV AH,41H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H

                MOV AX,3D02H
                MOV DX,OFFSET LINEPARAMETERS
                INT 21H

                MOV [WORD CS:HANDLE],AX

                MOV BX,[WORD CS:HANDLE]
                MOV AX,5701H
                MOV CX,[WORD CS:TIME]
                MOV DX,[WORD CS:DATE]
                INT 21H
                MOV AH,3EH
                INT 21H
                MOV AX,4301H
                MOV DX,OFFSET LINEPARAMETERS
                MOV CX,[WORD CS:ATRIB]
                INT 21H


                MOV [BYTE CS:EXITORCONT],00H
                MOV AX,OFFSET FIN2
                PUSH AX
                RET

MEMOOKANTIGEN:
                MOV [WORD CS:RESERSEG],AX

                MOV AX,4200H
                MOV BX,[WORD CS:HANDLE3]
                XOR CX,CX
                MOV DX,01250H
                INT 21H

READAGAINANTIGEN:
                MOV AH,3FH
                MOV BX,[WORD CS:HANDLE3]
                MOV CX,4000H
                MOV DS,[WORD CS:RESERSEG]
                MOV DX,0100H
                INT 21H

                CMP AX,04000H
                JB WRITELASTANTIGEN

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,4000H
                MOV DS,[WORD CS:RESERSEG]
                MOV DX,0100H
                INT 21H
                JMP READAGAINANTIGEN

WRITELASTANTIGEN:
                MOV CX,AX
                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV DS,[WORD CS:RESERSEG]
                MOV DX,OFFSET 0100H
                INT 21H

                MOV AH,03EH
                MOV BX,[WORD CS:HANDLE3]
                INT 21H

                MOV AH,49H
                MOV ES,[WORD CS:RESERSEG]
                INT 21H

                JMP SETATTRIBEXE1

CHECKFSHIELD12COM:
                MOV SI,[WORD CS:OFFSALTO]
                MOV DI,OFFSET FSHIELD12ID1

                PUSH CS
                POP ES
                CLD
                MOV CX,19
                REP CMPSB
                JNZ CHECKMEGALOCK

                MOV BX,[WORD CS:OFFSALTO]
                ADD BX,0004H
                MOV CL,04H
                SHR BX,CL
                MOV CX,DS
                ADD CX,BX
                MOV DS,CX

                MOV SI,0020H
                MOV DI,OFFSET FSHIELD12ID2

                PUSH CS
                POP ES
                CLD
                MOV CX,0032
                REP CMPSB
                JNZ CHECKMEGALOCK

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET FSHIELD12COM
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:0AAH],0F0CDH
                JMP TNTCOMMON

CHECKFSHIELD12EXE:
                MOV SI,0000H
                MOV DI,OFFSET FSHIELD12ID3

                PUSH CS
                POP ES
                CLD
                MOV CX,0033
                REP CMPSB
                JNZ CHECKEXE2COMCOMPR

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET FSHIELD12EXE
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:072H],0F0CDH
                MOV [BYTE CS:FSHIELDTYPE],01H
                JMP FSHIELDEXEALL

CHECKEXE2COMCOMPR:
                MOV SI,0100H
                MOV DI,OFFSET EXE2COMCOMPRID1

                PUSH CS
                POP ES
                CLD
                MOV CX,0010
                REP CMPSB
                JNZ CHECKWWPACK302

                CMP [WORD DS:0110H],0CB56H
                JNZ CHECKWWPACK302

                MOV BP,DS
                ADD BP,0010H
                ADD BP,[WORD DS:010AH]
                MOV SI,[WORD DS:010EH]
                MOV [WORD CS:OFFSALTO],SI
                ADD SI,0006H
                MOV DS,BP

                MOV DI,OFFSET EXE2COMCOMPRID2

                PUSH CS
                POP ES
                CLD
                MOV CX,0024
                REP CMPSB
                JNZ CHECKWWPACK302

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET EXE2COMCOMPR
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX

                MOV SI,OFFSET EXEHEAD
                MOV DI,OFFSET EXEHEADORIG
                MOV CX,001CH
                CLD
                REP MOVSB

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H

                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV [WORD DS:SI+085H],09090H
                MOV [WORD DS:SI+08AH],0F0CDH
                MOV [BYTE DS:SI+08CH],090H
                MOV [WORD DS:SI+098H],0F0CDH
                MOV [WORD DS:SI+0A7H],0F0CDH
                MOV [WORD DS:SI+0EBH],0F0CDH

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET EXE2COMCOMPRBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
EXE2COMCOMPRBRK0:
                PUSHF
                CALL PUSHTEMP
                MOV CX,[WORD CS:TEMPCX]
                JCXZ EXE2COMCOMPRNEXTBRK

                CALL SAVERELOC2

                CALL POPTEMP
                MOV DX,[WORD ES:DI]
                POPF
                IRET
EXE2COMCOMPRNEXTBRK:
                MOV AH,3EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H
                CALL FIXHEADLENGTH

                MOV AX,[WORD CS:CANTRELOC]
                MOV [WORD CS:EXEHEADORIG+06H],AX

                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET EXE2COMCOMPRBRK1

                CALL POPTEMP
                MOV DS,[WORD CS:DSEGMENT]
                POPF
                IRET
EXE2COMCOMPRBRK1:
                PUSHF
                CALL PUSHTEMP
                MOV AX,SS
                MOV BX,[WORD CS:TEMPCX]
                MOV [WORD CS:PARAES],AX
                MOV [WORD CS:PARADI],BX
                MOV [WORD ES:03C0H],OFFSET EXE2COMCOMPRBRK2

                MOV AX,SS
                MOV [WORD CS:DSEGMENT],AX

                MOV AX,[WORD CS:PID]
                MOV ES,AX
                MOV BX,[WORD CS:DSEGMENT]
                ADD BX,0005H

                SUB BX,AX


                MOV AH,4AH
                INT 21H

                MOV AH,48H
                MOV BX,1000H
                INT 21H

                JNC MEMOOKEXE2COMCOMPR

                MOV DX,OFFSET NOTMEMO
                CALL PRINT

                MOV AH,3EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                MOV AX,4301H
                MOV DX,OFFSET TEMPPARAMETERS
                XOR CX,CX
                INT 21H


                MOV AH,41H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H

                MOV AX,3D02H
                MOV DX,OFFSET LINEPARAMETERS
                INT 21H

                MOV [WORD CS:HANDLE],AX

                MOV BX,[WORD CS:HANDLE]
                MOV AX,5701H
                MOV CX,[WORD CS:TIME]
                MOV DX,[WORD CS:DATE]
                INT 21H
                MOV AH,3EH
                INT 21H
                MOV AX,4301H
                MOV DX,OFFSET LINEPARAMETERS
                MOV CX,[WORD CS:ATRIB]
                INT 21H

                MOV [BYTE CS:EXITORCONT],00H
                MOV AX,OFFSET FIN2
                PUSH AX
                RET

MEMOOKEXE2COMCOMPR:
                MOV [WORD CS:RESERSEG],AX

                MOV AX,3D02H
                XOR BX,BX
                XOR CX,CX
                PUSH CS
                POP DS
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX

                MOV AX,4200H
                XOR CX,CX
                MOV DX,[WORD CS:EXEHEADORIG+18H]
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                MOV AX,[WORD CS:CANTRELOC]
                MOV [WORD CS:TEMPBYTE],AX
                XOR DX,DX
                MOV CX,0004H
                CLC
                MUL CX
                MOV CX,AX

                MOV AH,3FH
                MOV BX,[WORD CS:HANDLE]
                MOV DS,[WORD CS:RESERSEG]
                XOR DX,DX
                INT 21H

                MOV AX,4200H
                XOR CX,CX
                MOV DX,[WORD CS:EXEHEADORIG+18H]
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:02EH],0F0CDH

                CALL POPTEMP
                MOV DS,[WORD CS:TEMPAX]
                POPF
                IRET
EXE2COMCOMPRBRK2:
                PUSHF
                CALL PUSHTEMP
                MOV BX,SP
                MOV AX,[WORD SS:BX+02H]
                CMP AX,0034H
                JZ EXE2COMCOMPRLAST

                MOV AX,[WORD CS:TEMPDS]
                MOV BX,[WORD CS:TEMPSI]
                MOV DX,[WORD CS:TEMPDI]
                MOV CX,[WORD CS:PID]
                ADD CX,0010H
COMPAREMOS:
                CMP AX,CX
                JAE ALLEXE2COMOK
                INC AX
                SUB BX,0010H
                SUB DX,0010H
                JMP COMPAREMOS
ALLEXE2COMOK:
                MOV [WORD CS:EXEMAX],BX
                MOV CX,[WORD CS:TEMPCX]
                SUB BX,CX
                MOV [WORD CS:EXEMIN],BX

                MOV DS,[WORD CS:RESERSEG]
                XOR SI,SI
                MOV CX,[WORD CS:CANTRELOC]
                CLD
HAYMAS:
                JCXZ NOPASANADA2
                MOV BX,[WORD CS:TEMPBYTE]
                CMP BX,0000H
                JZ NOPASANADA2
                PUSH CX
                LODSW
                ADD SI,0002
                CMP AX,[WORD CS:EXEMAX]
                JA NOPASANADAEXECOM
                CMP AX,[WORD CS:EXEMIN]
                JB NOPASANADAEXECOM
                JMP ENCONTRADO
NOPASANADAEXECOM:
                POP CX
                LOOP HAYMAS
NOPASANADA2:
                CALL POPTEMP
                STD
                REP MOVSB
                POPF
                IRET
ENCONTRADO:
                MOV BX,[WORD CS:EXEMAX]
                SUB BX,AX
                PUSH DX

                SUB DX,BX

                MOV [WORD DS:SI-04H],DX

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,0004H
                MOV DS,[WORD CS:RESERSEG]
                MOV DX,SI
                SUB DX,0004H
                INT 21H

                DEC [WORD CS:TEMPBYTE]

                POP DX
                POP CX
                DEC CX
                JMP HAYMAS
EXE2COMCOMPRLAST:
                CALL PUSHTEMP
                POP AX
                POP AX
                POP AX

                MOV AH,3EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                MOV DS,[WORD CS:DSEGMENT]
                MOV AX,[WORD DS:03CH]
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+00EH],AX
                MOV AX,[WORD DS:041H]
                MOV [WORD CS:EXEHEADORIG+010H],AX
                MOV AX,[WORD DS:047H]
                MOV [WORD CS:EXEHEADORIG+014H],AX
                MOV AX,[WORD DS:049H]
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+016H],AX
                MOV AX,[WORD CS:CANTRELOC]
                MOV [WORD CS:EXEHEADORIG+006H],AX
                JMP SAVECOMMON
CHECKMEGALOCK:
                MOV SI,[WORD CS:OFFSALTO]
                ADD SI,0007H
                MOV DI,OFFSET MEGALOCKID
                PUSH CS
                POP ES
                CLD
                MOV CX,39
                REP CMPSB
                JNZ CHECKBLIZT10B

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET MEGALOCK
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV [WORD DS:SI+000H],09090H
                MOV [WORD DS:SI+002H],09090H
                MOV [WORD DS:SI+004H],09090H
                MOV [WORD DS:SI+006H],09090H
                MOV [BYTE DS:SI+008H],090H

                MOV BX,[WORD CS:OFFSALTO]
                ADD BX,000CH
                MOV CL,04H
                SHR BX,CL
                MOV AX,DS
                ADD BX,AX
                MOV [WORD CS:DSEGMENT],BX
                MOV DS,BX

                MOV [WORD DS:025H],020CH
                MOV [WORD DS:063H],0204H
                MOV [WORD DS:068H],0206H
                MOV [WORD DS:03BH],081CDH

                PUSH DS
                POP ES
                PUSH CS
                POP DS
                MOV SI,OFFSET MEGALOCKREPLACE
                MOV DI,0032H
                MOV CX,0009H
                CLD
                REP MOVSB

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET MEGALOCKBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI

                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
MEGALOCKBRK0:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:057H],0F0CDH
                MOV [BYTE DS:059H],090H
                MOV [WORD ES:03C0H],OFFSET MEGALOCKBRK1
                CALL POPTEMP
                SUB DI,0003H
                POPF
                IRET
MEGALOCKBRK1:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:091H],0F0CDH
                MOV CX,[WORD DS:0086H]
                ADD CX,0003H
                MOV [WORD CS:FILESIZECOM],CX
                MOV [WORD ES:03C0H],OFFSET MEGALOCKBRK2
                CALL POPTEMP
                MOV SI,0103H
                POPF
                IRET
MEGALOCKBRK2:
                JMP BRKPRX31COM1
CHECKPROTECT55COM:
                MOV [BYTE CS:STEP55],01H
                PUSH CS
                POP DS
                MOV ES,[WORD CS:CHILDCSIP+02]
                MOV DI,[WORD CS:CHILDCSIP]
                XOR CX,CX
CHECKDE1:
                MOV [WORD CS:INSTRPREVCX],CX
                CLD
                CMP [BYTE CS:STEP55],01H
                JNZ CHECKDE12A
                CMP [WORD CS:UNKNOWNPHASE1],0200H
                JZ HASTADONDE
                INC [WORD CS:UNKNOWNPHASE1]
CHECKDE12A:
                CMP [BYTE CS:STEP55],06H
                JNZ CHECKDE12
                CMP [WORD CS:UNKNOWNCOUNTER],0100H
                JZ HASTADONDE
                INC [WORD CS:UNKNOWNCOUNTER]
CHECKDE12:
                CMP [BYTE CS:STEP55],07H
                JNZ CHECKDE13
                CMP [WORD CS:KNOWNCOUNTER],0100H
                JZ HASTADONDE
                INC [WORD CS:KNOWNCOUNTER]
CHECKDE13:
                MOV SI,OFFSET DE1
                XOR BH,BH
                MOV BL,[BYTE ES:DI]
                MOV CX,0001H
LEAMOSDE1:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKDE2
                XOR AH,AH
                CMP AL,BL
                JZ DETODOSOK
                DEC SI
                JMP LEAMOSDE1
CHECKDE2:
                MOV SI,OFFSET DE2
                XOR BH,BH
                MOV BX,[WORD ES:DI]
                MOV CX,0002H
LEAMOSDE2:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKDE3
                CMP AL,BL
                JZ SEELENGTH
                DEC SI
                JMP LEAMOSDE2
SEELENGTH:
                CMP BL,087H
                JZ SEEIFDECRYPT
                CMP BL,089H
                JZ SEEIFDECRYPT
                CMP BL,08BH
                JZ SEEIFDECRYPT
SEEIFJUMP:
                CMP [BYTE CS:STEP55],05H
                JNZ PREVCONTRETURN
                CMP BL,074H
                JZ ESPROTECT55
                CMP BL,075H
                JZ ESPROTECT55
                JMP CONTRETURN
PREVCONTRETURN:
                CMP [BYTE CS:STEP55],06H
                JNZ CONTRETURN
                CMP BL,074H
                JZ CHECKIFREALJZ
                CMP BL,075H
                JZ CHECKIFREALJZ
                JMP CONTRETURN
CHECKIFREALJZ:
                PUSH BX
                CALL CALCULMAYORMENOR
                POP BX
                CMP BL,074H
                JZ THISISJZ
                MOV BP,DI
                ADD BP,0002H
THISISJZ:
                CMP BP,[WORD CS:JZVALUE]
                JBE CONTRETURN
                MOV [WORD CS:JZVALUE],BP
                MOV [BYTE CS:STEP55],05H
                JMP FOUNDJUMP

CALCULMAYORMENOR:
                CMP BH,080H
                JAE RETROPREV
AVANCEPREV:
                XOR BL,BL
                XCHG BH,BL
                MOV BP,DI
                ADD BP,BX
                ADD BP,0002H
                JMP ESMAYORSINO
RETROPREV:
                XOR BL,BL
                XCHG BH,BL
                NEG BL
                XOR BH,BH
                MOV BP,DI
                SUB BP,BX
                ADD BP,0002H
                JMP ESMAYORSINO
ESMAYORSINO:
                RET

CONTRETURN:
                CMP BL,070H
                JZ ALLNORM55
                CMP BL,072H
                JZ ALLNORM55
                CMP BL,074H
                JZ ALLNORM55
                CMP BL,075H
                JZ ALLNORM55
                CMP BL,076H
                JZ ALLNORM55
                CMP BL,078H
                JZ ALLNORM55
                CMP BL,07AH
                JZ ALLNORM55
                CMP BL,07BH
                JZ ALLNORM55
                CMP BL,07CH
                JZ ALLNORM55
RETURNAGAIN:
                CMP BL,002H
                JZ SPECIAL4
                CMP BL,012H
                JZ SPECIAL4
                CMP BL,022H
                JZ SPECIAL4
                CMP BL,032H
                JZ SPECIAL4
                CMP BL,00AH
                JZ SPECIAL4
                CMP BL,01AH
                JZ SPECIAL4
                CMP BL,02AH
                JZ SPECIAL4
                CMP BL,03AH
                JZ SPECIAL4
                CMP BL,084H
                JZ SPECIAL4
                CMP BL,08AH
                JZ SPECIAL4
                CMP [BYTE CS:STEP55],07H
                JNZ RETURNAGAIN2
                JMP SPECIAL4
RETURNAGAIN2:
                AND BH,0F0H
                CMP BH,0B0H
                JZ DOSMAS
                CMP BH,0A0H
                JZ DOSMAS
                CMP BH,090H
                JZ DOSMAS
                CMP BH,080H
                JZ DOSMAS
                CMP BH,070H
                JZ UNOMAS
                CMP BH,060H
                JZ UNOMAS
                CMP BH,050H
                JZ UNOMAS
                CMP BH,040H
                JZ UNOMAS
ALLNORM55:
                JMP DETODOSOK
SPECIAL4:
                CMP BH,06H
                JZ DOSMAS
                CMP BH,0EH
                JZ DOSMAS
                CMP BH,16H
                JZ DOSMAS
                CMP BH,1EH
                JZ DOSMAS
                CMP BH,26H
                JZ DOSMAS
                CMP BH,2EH
                JZ DOSMAS
                CMP BH,36H
                JZ DOSMAS
                CMP BH,3EH
                JZ DOSMAS
                JMP RETURNAGAIN2

SEEIFDECRYPT:
                CMP BH,084H
                JZ DECRYPTSTOK
                CMP BH,085H
                JZ DECRYPTSTOK
                CMP BH,086H
                JZ DECRYPTSTOK
                CMP BH,09CH
                JZ DECRYPTSTOK
                CMP BH,09DH
                JZ DECRYPTSTOK
                CMP BH,09EH
                JZ DECRYPTSTOK
                JMP RETURNAGAIN
DECRYPTSTOK:
                CMP [BYTE CS:STEP55],03H
                JNZ ESPROTECT55
                CMP BL,087H
                JZ ESPROTECT55
                CMP BL,089H
                JZ ESPROTECT55
                JMP HASTADONDE
DOSMAS:
                ADD CX,0002H
                JMP DETODOSOK
UNOMAS:
                ADD CX,0001H
                JMP DETODOSOK
CHECKDE3:
                MOV SI,OFFSET DE3
                XOR BH,BH
                MOV BL,[BYTE ES:DI]
                MOV CX,0003H
LEAMOSDE3:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKDE4
                CMP AL,BL
                JZ DETODOSOK
                DEC SI
                JMP LEAMOSDE3
CHECKDE4:
                MOV SI,OFFSET DE4
                XOR BH,BH
                MOV BL,[BYTE ES:DI]
                MOV CX,0004H
LEAMOSDE4:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKSPECIALDE3
                CMP AL,BL
                JZ DETODOSOK
                DEC SI
                JMP LEAMOSDE4
DETODOSOK:
                ADD DI,CX
                JMP CHECKDE1
CHECKSPECIALDE3:
                MOV SI,OFFSET SPECIALDE3
                XOR BH,BH
                MOV BL,[BYTE ES:DI]
                MOV CX,0003H
LEAMOSSPECIALDE3:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKSPECIALDE2
                CMP AL,BL
                JZ DETODOSOK
                DEC SI
                JMP LEAMOSSPECIALDE3
CHECKSPECIALDE2:
                MOV SI,OFFSET SPECIALDE2
                XOR BH,BH
                MOV BL,[BYTE ES:DI]
                MOV CX,0002H
LEAMOSSPECIALDE2:
                LODSW
                CMP AX,0FFFFH
                JZ CHECKSALTOLARGO
                CMP AL,BL
                JZ DETODOSOK
                DEC SI
                JMP LEAMOSSPECIALDE2
CHECKSALTOLARGO:
                CMP BL,0E9H
                JNZ CHECKSALTOCORTO
                MOV BX,[WORD ES:DI+001H]
                ADD BX,DI
                ADD BX,0003H
                MOV DI,BX
                JMP CHECKDE1
CHECKSALTOCORTO:
                CMP BL,0EBH
                JZ CALCULSALTO
                CMP BL,071H
                JZ CALCULSALTO
                CMP BL,073H
                JZ CALCULSALTO
                CMP BL,077H
                JZ CALCULSALTO
                CMP BL,079H
                JZ CALCULSALTO
                CMP BL,07EH
                JZ CALCULSALTO
                CMP BL,07FH
                JZ CALCULSALTO
                JMP CHECKINOUT21
CALCULSALTO:
                MOV AL,[BYTE ES:DI+001H]
                CMP AL,080H
                JAE RETRO3
AVANCE3:
                XOR AH,AH
                ADD DI,AX
                ADD DI,0002H
                JMP CHECKDE1
RETRO3:
                NEG AL
                XOR AH,AH
                SUB DI,AX
                ADD DI,0002H
                JMP CHECKDE1
CHECKINOUT21:
                CMP BL,0E4H
                JZ INOUTOK
                CMP BL,0E6H
                JZ INOUTOK
                CMP [BYTE CS:STEP55],07H
                JNZ HASTADONDE
                CMP BL,0E8H
                JZ ESPROTECT55FINAL
                CMP BL,08CH
                JZ ESPROTECT55FINAL
                JMP HASTADONDE
INOUTOK:
                ADD DI,0002H
                JMP CHECKDE1
HASTADONDE:
                JMP CHECKERROR
ESPROTECT55:
                CMP [BYTE CS:STEP55],02H
                JZ ESPROTECT55PASO3
                CMP [BYTE CS:STEP55],03H
                JZ ESPROTECT55PASO4
                CMP [BYTE CS:STEP55],04H
                JZ ESPROTECT55PASO5
                CMP [BYTE CS:STEP55],05H
                JZ ESPROTECT55PASO6
                CMP [BYTE CS:STEP55],06H
                JZ ESPROTECT55PASO7
                MOV AX,[WORD ES:DI+002H]
                MOV [WORD CS:PASABANDA],AX
                ADD AX,0002H
                MOV [WORD CS:PASAALTOS],AX
                SUB AX,0004H
                MOV [WORD CS:PASABAJOS],AX
                MOV [WORD CS:OFFSETXCHG],DI
                ADD DI,0004H
                INC [BYTE CS:STEP55] ; PASO 2
                JMP CHECKDE1
ESPROTECT55PASO3:
                MOV AX,[WORD ES:DI+002H]
                CMP AX,[WORD CS:PASAALTOS]
                JZ PASO3OK
                CMP AX,[WORD CS:PASABAJOS]
                JZ PASO3OK
                JMP HASTADONDE
PASO3OK:
                ADD DI,0004H
                INC [BYTE CS:STEP55] ; PASO 3
                JMP CHECKDE1
ESPROTECT55PASO4:
                MOV AX,[WORD ES:DI+002H]
                CMP AX,[WORD CS:PASAALTOS]
                JZ PASO4OK
                CMP AX,[WORD CS:PASABANDA]
                JZ PASO4OK
                CMP AX,[WORD CS:PASABAJOS]
                JZ PASO4OK
                JMP HASTADONDE
PASO4OK:
                ADD DI,0004H
                INC [BYTE CS:STEP55] ; PASO 4
                JMP CHECKDE1
ESPROTECT55PASO5:
                MOV AX,[WORD ES:DI+002H]
                CMP AX,[WORD CS:PASAALTOS]
                JZ PASO5OK
                CMP AX,[WORD CS:PASABAJOS]
                JZ PASO5OK
                CMP AX,[WORD CS:PASABANDA]
                JZ PASO5OK
                JMP HASTADONDE
PASO5OK:
                ADD DI,0004H
                INC [BYTE CS:STEP55] ; PASO 5 ---> BUSCAR JZ O JNZ :)
                JMP CHECKDE1
ESPROTECT55PASO6:
                MOV AX,[WORD CS:INSTRPREVCX]
                CMP AX,0003
                JZ CHECKIFADDSUBDECINC
                CMP AX,0001
                JZ CHECKIFADDSUBDECINC
                JMP CONTRETURN
CHECKIFADDSUBDECINC:
                CMP  AX,0001H
                JZ CHECKIFINCDEC
                CMP [BYTE ES:DI-3],083H
                JNZ CONTRETURN
                CMP [BYTE ES:DI-1],01H
                JZ CHECKIFADDORSUB
                CMP [BYTE ES:DI-1],0FFH
                JZ CHECKIFADDORSUB
                JMP CONTRETURN
CHECKIFADDORSUB:
                MOV AL,[BYTE ES:DI-2]
                CMP AL,0C1H
                JZ FOUNDJUMP
                CMP AL,0C2H
                JZ FOUNDJUMP
                CMP AL,0C5H
                JZ FOUNDJUMP
                CMP AL,0C6H
                JZ FOUNDJUMP
                CMP AL,0C7H
                JZ FOUNDJUMP
                CMP AL,0E9H
                JZ FOUNDJUMP
                CMP AL,0EAH
                JZ FOUNDJUMP
                CMP AL,0EDH
                JZ FOUNDJUMP
                CMP AL,0EEH
                JZ FOUNDJUMP
                CMP AL,0EFH
                JZ FOUNDJUMP
                JMP CONTRETURN
CHECKIFINCDEC:
                MOV AL,[BYTE ES:DI-1]
                CMP AL,041H
                JZ FOUNDJUMP
                CMP AL,042H
                JZ FOUNDJUMP
                CMP AL,045H
                JZ FOUNDJUMP
                CMP AL,046H
                JZ FOUNDJUMP
                CMP AL,047H
                JZ FOUNDJUMP
                CMP AL,049H
                JZ FOUNDJUMP
                CMP AL,04AH
                JZ FOUNDJUMP
                CMP AL,04DH
                JZ FOUNDJUMP
                CMP AL,04EH
                JZ FOUNDJUMP
                CMP AL,04FH
                JZ FOUNDJUMP
                JMP CONTRETURN

FOUNDJUMP:
                MOV [WORD CS:OFFSETJZNZ],DI
                INC [BYTE CS:STEP55] ; PASO 6 ---> CHEQUEAR SI ES LOOP FALSO
                MOV [BYTE CS:JZTYPE],BL
                PUSH BX
                CALL CALCULMAYORMENOR
                MOV [WORD CS:JZVALUE],BP
                POP BX
ESJZ:
                CMP BL,074H
                JNZ ESJNZ
                XOR CX,CX
                ADD CX,0002H
                ADD DI,CX
                JMP CHECKDE1
ESJNZ:
                MOV BP,DI
                ADD BP,0002H
                MOV [WORD CS:JZVALUE],BP
                CMP BH,080H
                JAE RETRO4

                XOR BL,BL
                XCHG BL,BH
                ADD DI,BX
                ADD DI,0002H
                JMP CHECKDE1
RETRO4:
                NEG BH
                XOR BL,BL
                XCHG BL,BH
                SUB DI,BX
                ADD DI,0002H
                JMP CHECKDE1
ESPROTECT55PASO7:
                CMP DI,[WORD CS:OFFSETXCHG]
                JNZ HASTADONDE
                MOV DI,[WORD CS:OFFSETJZNZ]
                CMP [BYTE CS:JZTYPE],074H
                JZ PUTBRKCALCULATED
                ADD DI,0002H
                JMP CHECKFINALSTEP

PUTBRKCALCULATED:
                MOV BL,[BYTE ES:DI+001H]
                CMP BL,080H
                JAE RETRO5

                XOR BH,BH
                ADD DI,BX
                ADD DI,0002H
                JMP CHECKFINALSTEP
RETRO5:
                NEG BL
                XOR BH,BH
                SUB DI,BX
                ADD DI,0002H
                JMP CHECKFINALSTEP
CHECKFINALSTEP:
                MOV AX,[WORD ES:DI]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD CS:UNKNOWNCOUNTER],DI
                MOV [WORD ES:DI],0F0CDH

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET PRXCM55BRK0
                INT 21H
                MOV AH,062H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI

                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
PRXCM55BRK0:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:CHILDCSIP+02]
                MOV SI,[WORD CS:UNKNOWNCOUNTER]
                MOV AX,[WORD CS:TEMPBYTE]
                MOV [WORD DS:SI],AX
                MOV BX,SP
                MOV [WORD SS:BX+02H],SI
                INC [BYTE CS:STEP55]
                PUSH DS
                POP ES
                PUSH CS
                POP DS
                MOV DI,SI
                JMP CHECKDE1

ESPROTECT55FINAL:
                PUSH ES
                POP DS
                PUSH CS
                POP ES

                MOV SI,DI
                MOV [WORD CS:OFFSALTO],SI
                PUSH SI
                MOV DI,OFFSET PRXCM55COMID
                MOV CX,0043
                CLD
                REP CMPSB
                JNZ CHECKPROTECT55EXE
                POP SI
                MOV DX,OFFSET PROTECT55COM
                MOV [BYTE CS:PRXCM55TYPE],01H
                JMP PROTECT55OK

CHECKPROTECT55EXE:
                PUSH CS
                POP ES
                POP SI
                ADD SI,0002H
                MOV [WORD CS:OFFSALTO],SI
                MOV DI,OFFSET PRXCM55EXEID
                MOV CX,0039
                CLD
                REP CMPSB
                JNZ CHECKTHEREST

                MOV DX,OFFSET PROTECT55EXE
                MOV [BYTE CS:PRXCM55TYPE],02H
                JMP PROTECT55OK

PROTECT55OK:
                PUSH DX
                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                POP DX
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                CMP [BYTE CS:PRXCM55TYPE],02H
                JZ PRXCM55CONTEXE
                MOV AX,[WORD DS:SI+09AH]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD DS:SI+09AH],0F0CDH
                JMP ALL55COMMON

PRXCM55CONTEXE:
                MOV [WORD DS:SI+09BH],0F0CDH
                MOV [BYTE DS:SI+09DH],090H
                MOV [WORD DS:SI+005H],09090H

                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H
ALL55COMMON:
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET PRXCM55BRK1

                CALL POPTEMP
                POPF
                IRET
PRXCM55BRK1:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV AX,[WORD CS:TEMPBYTE]
                CMP [BYTE CS:PRXCM55TYPE],02H
                JZ PRXCM55CONTEXE1
                MOV [WORD DS:SI+09AH],AX
                MOV DI,[WORD CS:TEMPDI]
                MOV ES,[WORD CS:TEMPES]
                MOV [WORD ES:DI+001H],09090H
                MOV [WORD ES:DI+0E5H],09090H
                MOV [WORD ES:DI+0B3H],0F0CDH
                CMP [WORD ES:DI+060H],000E9H
                JZ COMPRESSEDCOM

                CLC
                XOR DX,DX
                MOV AX,[WORD ES:DI+025H]
                MOV CX,0002H
                MUL CX
                JMP PUTSIZEPRXCMCOM55

COMPRESSEDCOM:
                MOV AX,[WORD ES:DI+067H]
                INC AX
                SUB AX,[WORD ES:DI+093H]

PUTSIZEPRXCMCOM55:
                MOV [WORD CS:FILESIZECOM],AX

                MOV AX,SI
                ADD AX,009AH
                JMP ALL55COMMON1

PRXCM55CONTEXE1:
                MOV DI,[WORD CS:TEMPDI]
                MOV ES,[WORD CS:TEMPES]
                MOV [WORD ES:DI+03DH],09090H
                MOV [WORD ES:DI+0193H],0F0CDH
                MOV [BYTE ES:DI+0195H],090H
                MOV [WORD ES:DI+0198H],0F0CDH
                MOV [WORD ES:DI+019AH],09090H
                MOV [WORD ES:DI+019CH],09090H
                MOV [BYTE ES:DI+019EH],090H
                MOV [BYTE CS:COMPRTYPE],01H
                MOV AX,[WORD ES:DI+082H]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD ES:DI+082H],0F0CDH
                MOV [WORD CS:OFFSALTO],DI
                MOV [WORD CS:DSEGMENT],ES
                CMP [BYTE CS:PRXCM55TYPE],02H
                JZ ALL55COMMON1A
ALL55COMMON1:
                MOV BX,SP
                MOV [WORD SS:BX+002H],AX
ALL55COMMON1A:
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET PRXCM55BRK2

                CALL POPTEMP
                CMP [BYTE CS:PRXCM55TYPE],02H
                JZ DOPRXCM55EXEINST1
                POPF
                IRET
DOPRXCM55EXEINST1:
                SUB CX,0009H
                POPF
                IRET
PRXCM55BRK2:
                PUSHF
                CALL PUSHTEMP
                CMP [BYTE CS:PRXCM55TYPE],02H
                JZ SIGAMOSCON55EXE
                CALL POPTEMP
                POPF
                JMP BRKPRX31COM1
SIGAMOSCON55EXE:
                MOV AX,[WORD CS:TEMPES]
                MOV BX,[WORD CS:TEMPDI]
                SUB AX,01000H
                MOV [WORD CS:PARAES],AX
                MOV [WORD CS:PARADI],BX

                MOV AX,[WORD CS:TEMPBYTE]
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV [WORD DS:SI+082H],AX

                MOV AX,SI
                ADD AX,0082H

                MOV BX,SP
                MOV [WORD SS:BX+002H],AX
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                CMP [WORD DS:SI+08FH],00E9H
                JZ COMPRESSEDEXE
PRXCM55SINCOMPR:
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET PRXCM55BRK3
                CALL POPTEMP
                POPF
                IRET
COMPRESSEDEXE:
                MOV AX,[WORD DS:SI+0175H]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD DS:SI+0175H],0F0CDH
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET PRXCM55BRK2INTERMEDIO
                CALL POPTEMP
                POPF
                IRET
PRXCM55BRK2INTERMEDIO:
                PUSHF
                CALL PUSHTEMP
                MOV AX,[WORD CS:TEMPES]
                MOV BX,[WORD CS:TEMPBX]
                SUB AX,BX
                MOV BX,[WORD CS:TEMPDI]
                MOV [WORD CS:PARAES],AX
                MOV [WORD CS:PARADI],BX

                MOV AX,[WORD CS:TEMPBYTE]
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV [WORD DS:SI+0175H],AX

                MOV AX,SI
                ADD AX,0175H

                MOV BX,SP
                MOV [WORD SS:BX+002H],AX
                JMP PRXCM55SINCOMPR
PRXCM55BRK3:
                PUSHF
                CALL PUSHTEMP
                MOV CX,[WORD CS:TEMPCX]
                JCXZ ALLRELOC55DONE
                CALL SAVERELOC2
                CALL POPTEMP
                POPF
                IRET
ALLRELOC55DONE:
                MOV AH,03EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                CALL POPTEMP

                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV AX,[WORD DS:SI+01A0H]
                MOV [WORD CS:EXEHEADORIG+00EH],AX
                MOV AX,[WORD DS:SI+01A8H]
                MOV [WORD CS:EXEHEADORIG+010H],AX
                MOV AX,[WORD DS:SI+01C5H]
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+016H],AX
                MOV AX,[WORD DS:SI+01C3H]
                MOV [WORD CS:EXEHEADORIG+014H],AX


                MOV AX,[WORD CS:CANTRELOC]
                MOV [WORD CS:EXEHEADORIG+006H],AX
                MOV [WORD CS:EXEHEADORIG+018H],0001CH
                MOV [BYTE CS:EPW],01H
                JMP SAVECOMMON
CHECKWWPACK302:
                MOV SI,0013H
                MOV DI,OFFSET WWPACK302ID1
                PUSH CS
                POP ES
                CLD
                MOV CX,0011
                REP CMPSB
                JNZ CHECKWWPACK302RELOC0

                ADD SI,0011
                MOV DI,OFFSET WWPACK302ID2

                PUSH CS
                POP ES
                CLD
                MOV CX,0010
                REP CMPSB
                JNZ CHECKWWPACK302RELOC0

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET WWPACK302
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
WWPACKCOMMON:
                MOV DS,[WORD CS:DSEGMENT]
                CMP [BYTE CS:WWPACK300OK],01H
                JZ ITS300

                MOV AX,[WORD DS:044H]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD DS:044H],0F0CDH
                JMP WWPACKCOMMONOK

ITS300:
                MOV AX,[WORD DS:043H]
                MOV [WORD CS:TEMPBYTE],AX
                MOV [WORD DS:043H],0F0CDH
WWPACKCOMMONOK:
                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET WWPACK302BRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
WWPACK302BRK0:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:DSEGMENT]
                MOV AX,[WORD CS:TEMPBYTE]
                MOV BX,SP
                CMP [BYTE CS:WWPACK300OK],01H
                JZ IT300OK1
                MOV [WORD DS:044H],AX
                MOV [WORD SS:BX+02H],0044H
                JMP ALLNORMAL
IT300OK1:
                MOV [WORD DS:043H],AX
                MOV [WORD SS:BX+02H],0043H
ALLNORMAL:
                MOV AX,[WORD SS:BX+008H]
                MOV [WORD CS:OFFSALTO],AX
                MOV AX,[WORD SS:BX+00AH]
                MOV [WORD CS:DSEGMENT],AX
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                MOV AX,[WORD DS:SI+0146H]
                MOV [WORD CS:TEMPBYTE],AX
                CMP [BYTE CS:WWPACK300OK],01H
                JNZ ITSNOT300
                ADD SI,0011
ITSNOT300:
                MOV [WORD DS:SI+0146H],0F0CDH
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET WWPACK302BRK1
                CALL POPTEMP
                POPF
                IRET
WWPACK302BRK1:
                PUSHF
                CALL PUSHTEMP
                MOV AX,[WORD CS:TEMPES]
                MOV BX,[WORD CS:TEMPDI]
                MOV [WORD CS:PARAES],AX
                MOV [WORD CS:PARADI],BX
                MOV [WORD CS:EXEHEADORIG+006H],0000
                MOV AX,SS
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+00EH],AX
                CMP [BYTE CS:WWPACK300OK],01H
                JZ LASTWWPACK300
                MOV AX,SP
                ADD AX,0012H
                MOV [WORD CS:EXEHEADORIG+010H],AX
                MOV BX,SP
                MOV AX,[WORD SS:BX+00EH]
                MOV [WORD CS:EXEHEADORIG+014H],AX
                MOV AX,[WORD SS:BX+010H]
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+016H],AX
                JMP LASTWWPACK300COMMON
LASTWWPACK300:
                MOV AX,SP
                ADD AX,0010H
                MOV [WORD CS:EXEHEADORIG+010H],AX
                MOV BX,SP
                MOV AX,[WORD SS:BX+00CH]
                MOV [WORD CS:EXEHEADORIG+014H],AX
                MOV AX,[WORD SS:BX+00EH]
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+016H],AX

LASTWWPACK300COMMON:
                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX
                MOV [WORD CS:EXEHEADORIG+0018H],001CH

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H

                MOV AH,03EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                JMP SAVECOMMON
CHECKWWPACK302RELOC0:
                MOV SI,[WORD CS:CHILDCSIP]
                MOV DS,[WORD CS:CHILDCSIP+02H]
                CMP [BYTE DS:SI],0BEH
                JNZ CHECKWWPACK300

                ADD SI,0003H
                MOV DI,OFFSET WWPACK302RELOCID1
                PUSH CS
                POP ES
                CLD
                MOV CX,0010
                REP CMPSB
                JNZ CHECKWWPACK302RELOC

                ADD SI,0008H
                MOV DI,OFFSET WWPACK302RELOCID2
                PUSH CS
                POP ES
                CLD
                MOV CX,0010
                REP CMPSB
                JNZ CHECKWWPACK302RELOC

                MOV [WORD CS:DSEGMENT],DS
                MOV SI,[WORD CS:CHILDCSIP]
                MOV [WORD CS:OFFSALTO],SI
                MOV [WORD DS:SI+038H],0F0CDH

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET WWPACK302RELOC0
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX
                MOV [WORD CS:EXEHEADORIG+006H],0000H
                MOV [WORD CS:EXEHEADORIG+018H],001CH

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H

                MOV AH,03EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET WWPACK302RELOC0BRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
WWPACK302RELOC0BRK0:
                MOV AX,BP
                SUB AX,[WORD CS:PID]
                SUB AX,0010H
                MOV [WORD CS:EXEHEADORIG+016H],AX
                MOV DS,[WORD CS:DSEGMENT]
                MOV SI,[WORD CS:OFFSALTO]
                CMP [BYTE CS:WWPACK300OK],01H
                JZ WWPACK300RELOCOK1
WWPACK302RELOCOK1:
                MOV AX,[WORD DS:SI+045H]
                MOV [WORD CS:EXEHEADORIG+014H],AX
                MOV AX,[WORD DS:SI+03EH]
                MOV [WORD CS:EXEHEADORIG+00EH],AX
                MOV AX,[WORD DS:SI+03AH]
                MOV [WORD CS:EXEHEADORIG+010H],AX
                JMP ALLWWPACKRELOCCOMMON
WWPACK300RELOCOK1:
                MOV AX,[WORD DS:SI+04BH]
                MOV [WORD CS:EXEHEADORIG+014H],AX
                MOV AX,[WORD DS:SI+042H]
                MOV [WORD CS:EXEHEADORIG+00EH],AX
                MOV AX,[WORD DS:SI+03EH]
                MOV [WORD CS:EXEHEADORIG+010H],AX
ALLWWPACKRELOCCOMMON:
                MOV AX,[WORD CS:DSEGMENT]
                MOV BX,[WORD CS:OFFSALTO]
                MOV [WORD CS:PARAES],AX
                SUB BX,0001H
                MOV [WORD CS:PARADI],BX

                JMP SAVECOMMON
CHECKWWPACK302RELOC:
                MOV SI,[WORD CS:CHILDCSIP]
                ADD SI,0021
                MOV DI,OFFSET WWPACK302RELOCID3
                PUSH CS
                POP ES
                CLD
                MOV CX,0015
                REP CMPSB
                JNZ CHECKWWPACK300RELOC

                MOV [WORD CS:DSEGMENT],DS
                MOV SI,[WORD CS:CHILDCSIP]
                MOV [WORD DS:SI+01CH],0F0CDH
                MOV [WORD DS:SI+038H],0F0CDH
                MOV [WORD CS:OFFSALTO],SI

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET WWPACK302RELOC
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
WWPACKRELOCCOMMON:
                PUSH CS
                POP DS
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD CS:HANDLE],AX
                MOV [WORD CS:EXEHEADORIG+018H],001CH

                MOV AH,40H
                MOV BX,[WORD CS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET WWPACK302RELOCBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
WWPACK302RELOCBRK0:
                PUSHF
                CALL PUSHTEMP
                MOV CX,[WORD CS:TEMPCX]
                JCXZ ALLWWPACK302RELOCDONE
                CMP [BYTE CS:WWPACK300OK],01H
                JZ WWPACKEXCEPTRELOC
                MOV AX,[WORD CS:TEMPES]
                MOV [WORD CS:TEMPBYTE],AX
                MOV AX,[WORD CS:TEMPDS]
                MOV [WORD CS:TEMPES],AX
                CALL SAVERELOC2
                MOV AX,[WORD CS:TEMPBYTE]
                MOV [WORD CS:TEMPES],AX
                CALL POPTEMP
                POPF
                IRET
WWPACKEXCEPTRELOC:
                CALL SAVERELOC2
                CALL POPTEMP
                POPF
                IRET

ALLWWPACK302RELOCDONE:
                MOV AH,03EH
                MOV BX,[WORD CS:HANDLE]
                INT 21H

                MOV CX,[WORD CS:CANTRELOC]
                MOV [WORD CS:EXEHEADORIG+006H],CX
                JMP WWPACK302RELOC0BRK0
CHECKWWPACK300RELOC:
                MOV SI,[WORD CS:CHILDCSIP]
                ADD SI,0012
                MOV DI,OFFSET WWPACK300RELOCID1
                PUSH CS
                POP ES
                CLD
                MOV CX,0006
                REP CMPSB
                JNZ CHECKWWPACK300

                ADD SI,0002
                MOV DI,OFFSET WWPACK300RELOCID2
                PUSH CS
                POP ES
                CLD
                MOV CX,0016
                REP CMPSB
                JNZ CHECKWWPACK300

                MOV [WORD CS:DSEGMENT],DS
                MOV SI,[WORD CS:CHILDCSIP]
                MOV [WORD DS:SI+01FH],0F0CDH
                MOV [BYTE DS:SI+021H],090H
                MOV [WORD DS:SI+03AH],0F0CDH
                MOV [WORD CS:OFFSALTO],SI

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET WWPACK300RELOC
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
                MOV [BYTE CS:WWPACK300OK],01H
                JMP WWPACKRELOCCOMMON

CHECKWWPACK300:
                MOV SI,000EH
                MOV DI,OFFSET WWPACK300ID1
                PUSH CS
                POP ES
                CLD
                MOV CX,0009
                REP CMPSB
                JZ WWPACK300OK1
                JMP FAR CHECKPKLITE150COM
WWPACK300OK1:
                ADD SI,0010
                MOV DI,OFFSET WWPACK300ID2

                PUSH CS
                POP ES
                CLD
                MOV CX,0010
                REP CMPSB
                JZ WWPACK300OK2
                JMP FAR CHECKPKLITE150COM
WWPACK300OK2:
                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET WWPACK300
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
                MOV [BYTE CS:WWPACK300OK],01H
                JMP WWPACKCOMMON
CHECKMEGALITE118EXE:
                PUSH CS
                POP ES
                MOV SI,0006H
                MOV DI,OFFSET MEGALITE118EXEID
                MOV CX,0031
                CLD
                REP CMPSB
                JNZ CHECKMEGALITE120EXE

                MOV [WORD CS:DSEGMENT],DS
                MOV [BYTE CS:PKTYPE],1DH

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET MEGALITE118EXE
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
                JMP PKCOMMON
CHECKMEGALITE120EXE:
                PUSH CS
                POP ES
                MOV SI,0006H
                MOV DI,OFFSET MEGALITE120EXEID1
                MOV CX,0009
                CLD
                REP CMPSB
                JZ CHECKMEGALITE120EXEOK1
                JMP FAR CHECKMEGALITE116EXE
CHECKMEGALITE120EXEOK1:
                PUSH CS
                POP ES
                MOV SI,002AH
                MOV DI,OFFSET MEGALITE120EXEID2
                MOV CX,0024
                CLD
                REP CMPSB
                JZ MEGALITE120EXEOK
                JMP FAR CHECKMEGALITE116EXE

MEGALITE120EXEOK:
                MOV [WORD CS:DSEGMENT],DS
                MOV [BYTE CS:PKTYPE],1EH

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET MEGALITE120EXE
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB
                JMP PKCOMMON
CHECKEXEPACK403:
                CMP [WORD DS:0F8H],0FF2EH
                JNZ CHECKSCRE2B

                MOV [WORD CS:DSEGMENT],DS
                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET EXEPACK403
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:027H],0F0CDH
                MOV [WORD DS:0B7H],0F0CDH
                MOV [BYTE DS:0B9H],090H
                MOV [WORD DS:0D0H],0F0CDH
                MOV [BYTE DS:0D2H],090H
                MOV [WORD DS:0F2H],0F0CDH
                JMP EXEPACKCOMMON
CHECKCRYPT115:
                CMP [BYTE DS:0001H],008H
                JNE CHECKTHEREST

                PUSH CS
                POP ES
                MOV SI,000AH
                MOV DI,OFFSET CRYPT115ID
                MOV CX,0036
                CLD
                REP CMPSB
                JNZ CHECKTHEREST

                MOV [WORD CS:DSEGMENT],DS

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT
                MOV DX,OFFSET CRYPT115
                CALL PRINT
                CALL PAGK
                CALL GETATTRIB

                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD DS:0C5H],0F0CDH
                MOV [WORD DS:0C7H],0F0CDH

                PUSH CS
                POP ES

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                PUSH CS
                POP DS
                MOV AX,35F0H
                INT 21H
                MOV [WORD PTR CS:INTF0IP],BX
                MOV [WORD PTR CS:INTF0CS],ES
                MOV AX,25F0H
                MOV DX,OFFSET CRYPTBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV [WORD CS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP],SS
                MOV [WORD CS:INITSSSP+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP+02H]
                MOV SP,[WORD CS:CHILDSSSP]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP]
CRYPTBRK0:
                PUSHF
                CALL PUSHTEMP
                MOV DS,[WORD CS:DSEGMENT]
                MOV [WORD CS:PARAES],DS
                MOV [WORD CS:PARADI],0000H
                MOV AX,[WORD DS:006H]
                SUB AX,0010H
                MOV BX,[WORD DS:008H]
                MOV [WORD CS:EXEHEADORIG+016H],AX
                MOV [WORD CS:EXEHEADORIG+014H],BX
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET CRYPTBRK1
                MOV [WORD ES:03C2H],SEGUNDAPARTE
                CALL POPTEMP
                POPF
                IRET
SEGMENT SEGUNDAPARTE
                ASSUME CS:SEGUNDAPARTE
CSEGMENT:
                DW 0
PUSHSECOND:
                DW OFFSET PUSHTEMP2
                DW 0
POPSECOND:
                DW OFFSET POPTEMP2
                DW 0
TEMPAX2:
                DW 0
TEMPBX2:
                DW 0
TEMPCX2:
                DW 0
TEMPDX2:
                DW 0
TEMPDS2:
                DW 0
TEMPES2:
                DW 0
TEMPSI2:
                DW 0
TEMPDI2:
                DW 0
CONPKL:
                DB 007H,000H,000H,000H
SINPKL:
                DW 0,0
DSEGMENT2:
                DW 0
INITSSSP2:
                DW 0,0
CHILDSSSP2:
                DW 0,0
CHILDCSIP2:
                DW 0,0
TEMPBYTE2:
                DW 0
OVERLAYLASTBYTES:
                DW 0,0,0
PUSHTEMP2:
                MOV [WORD CS:TEMPAX2],AX
                MOV [WORD CS:TEMPBX2],BX
                MOV [WORD CS:TEMPCX2],CX
                MOV [WORD CS:TEMPDX2],DX
                MOV [WORD CS:TEMPDS2],DS
                MOV [WORD CS:TEMPES2],ES
                MOV [WORD CS:TEMPSI2],SI
                MOV [WORD CS:TEMPDI2],DI
		XOR AX,AX
		MOV ES,AX
                RET
POPTEMP2:
                MOV AX,[WORD CS:TEMPAX2]
                MOV BX,[WORD CS:TEMPBX2]
                MOV CX,[WORD CS:TEMPCX2]
                MOV DX,[WORD CS:TEMPDX2]
                MOV DS,[WORD CS:TEMPDS2]
                MOV ES,[WORD CS:TEMPES2]
                MOV SI,[WORD CS:TEMPSI2]
                MOV DI,[WORD CS:TEMPDI2]
                RET
CRYPTBRK1:
                PUSHF
                CALL PUSHTEMP2
                MOV AX,3D02H
                MOV DS,[WORD CS:CSEGMENT]
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV ES,[WORD CS:CSEGMENT]
                MOV [WORD ES:EXEHEADORIG+018H],001CH
                MOV BX,AX
                MOV AH,40H
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H
                MOV AX,SEGUNDAPARTE
                MOV DS,AX

                MOV CX,[WORD ES:EXEHEADORIG+006H]
                MOV DX,OFFSET SINPKL
                JCXZ CLOSECRYPT

                MOV DX,OFFSET CONPKL
CLOSECRYPT:
                MOV AH,40H
                MOV CX,0004H
                INT 21H
                MOV AH,3EH
                INT 21H
                MOV CX,[WORD ES:EXEHEADORIG+006H]
                JCXZ ENDCRYPT
                MOV DS,[WORD ES:EXEHEADORIG+016H]
                MOV AX,DS
                ADD AX,[WORD ES:PID]
                ADD AX,0010H
                MOV DS,AX
                ADD AX,0010H
                MOV SI,[WORD ES:EXEHEADORIG+014H]
                SUB [WORD DS:SI+007H],AX
ENDCRYPT:
                JMP FAR SAVECOMMON
CHECKMEGALITE116EXE:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,0009H
                MOV DI,OFFSET MEGALITE116EXEID1
                MOV CX,0006
                CLD
                REP CMPSB
                JZ  MEGALITEOK1
                JMP FAR CHECKPRXCM20COM
MEGALITEOK1:
                MOV SI,002AH
                MOV DI,OFFSET MEGALITE116EXEID2
                MOV CX,0024
                CLD
                REP CMPSB
                JZ MEGALITEOK2
                JMP CHECKMEGALITE119EXE
MEGALITEOK2:
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],1FH

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET MEGALITE116EXE
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON
PRINT2:
                MOV AX,[WORD CS:CSEGMENT]
                MOV DS,AX
		MOV AH,09H
		INT 21H
                RETN

PAGK4: ; Press And Get Key :)

                MOV AX,[WORD CS:CSEGMENT]
                MOV DS,AX
                MOV AH,09H
                MOV DX,OFFSET REMOVE
                INT 21H
GETKEY4:
                MOV AH,08H
                INT 21H
                CMP AL,79H
                JE LETCONT4
                CMP AL,59H
                JE LETCONT4
                CMP AL,4EH
                JE DONTCONT4
                CMP AL,6EH
                JE DONTCONT4
                JMP GETKEY4
LETCONT4:
                CALL PRINTCHAR4
                RETN
DONTCONT4:
                CALL PRINTCHAR4
                POP AX
                MOV DX,OFFSET CARRIAGE
                CALL PRINT2
                JMP FAR FIN2

PRINTCHAR4:
                MOV AH,02H
                MOV DL,AL
                INT 21H
                RETN
GETATTRIB3:
		PUSH ES
		PUSH BX
                MOV AX,[WORD CS:CSEGMENT]
                MOV DS,AX
		MOV AX,4300H
		MOV DX,OFFSET LINEPARAMETERS
		INT 21h

                MOV [WORD DS:ATRIB],CX

		MOV AX,3D00H
		MOV DX,OFFSET LINEPARAMETERS
		INT 21h
                MOV [WORD DS:HANDLE],AX

		MOV AH,3FH
                MOV BX,[WORD DS:HANDLE]
		MOV CX,0020H
		MOV DX,OFFSET EXEHEADORIG
		INT 21H

		MOV AX,5700H
		INT 21H
                MOV [WORD DS:TIME],CX
                MOV [WORD DS:DATE],DX
		MOV AH,3EH
		INT 21H
CHANGEATTRIB3:
		MOV AX,4301H
		MOV DX,OFFSET LINEPARAMETERS
		XOR CX,CX
		INT 21h
		MOV AX,4301H
		MOV DX,OFFSET TEMPPARAMETERS
		XOR CX,CX
		INT 21h
		MOV AX,3C00H
		MOV CX,0020H
		MOV DX,OFFSET TEMPPARAMETERS
		INT 21H
		MOV BX,AX
		MOV AH,3EH
		INT 21H
		MOV AH,2FH
		INT 21H
                MOV [WORD DS:POINTDTATEMP],BX
                MOV [WORD DS:POINTDTATEMP+02H],ES
                CMP [WORD DS:EXEHEADORIG],"ZM"
                JZ SEEOVERLAY3
                CMP [WORD DS:EXEHEADORIG],"MZ"
                JZ SEEOVERLAY3
NOHEADER3:
		POP BX
		POP ES
		RETN
SEEOVERLAY3:
		MOV AH,4EH
		MOV CX,00FFH
		MOV DX,OFFSET LINEPARAMETERS
		INT 21H

		CLC
                MOV AX,[WORD DS:EXEHEADORIG+04H]
                CMP [WORD DS:EXEHEADORIG+02H],0000
                JE NOPARTIAL3
		DEC AX
NOPARTIAL3:
		XOR DX,DX
		MOV BX,0200H
		MUL BX
		CLC
                ADD AX,[WORD DS:EXEHEADORIG+02H]
		ADC DX,0000H
		MOV BX,DX
                LDS DX,[DWORD DS:POINTDTATEMP]
		XCHG BX,DX
		CMP DX,[WORD DS:BX+1CH]
                JE CHECKLSB3
                JMP CALCULPOS3

CHECKLSB3:
		CMP AX,[WORD DS:BX+1AH]
                JE RETURN3
                JMP CALCULPOS3
RETURN3:
                JMP NOHEADER3
CALCULPOS3:
                MOV [WORD DS:CXHIGH],DX
                MOV [WORD DS:DXLOW],AX
                MOV [BYTE DS:OVERLAY],01H
                JMP RETURN3
CHECKPKLITE150COM:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,0107H
                MOV DI,OFFSET PKLITE150COMID
                MOV CX,0038
                CLD
                REP CMPSB
                JZ PKLITE150OK1
                JMP CHECKPKLITE150EXE1
PKLITE150OK1:
                CMP [BYTE DS:02A8H],0CBH
                JZ PKLITE150OK2
                JMP CHECKPKLITE150EXE1
PKLITE150OK2:
                MOV [WORD CS:DSEGMENT2],DS
		MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET PKLITE150COM
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3

                MOV DS,[WORD CS:DSEGMENT2]
                MOV [WORD DS:02A6H],0F0CDH

                MOV ES,[WORD CS:CSEGMENT]

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                MOV AX,35F0H
                INT 21H
                MOV DS,[WORD CS:CSEGMENT]
                MOV [WORD PTR DS:INTF0IP],BX
                MOV [WORD PTR DS:INTF0CS],ES
                PUSH CS
                POP DS
                MOV AX,25F0H
                MOV DX,OFFSET PKLITE150COMBRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV DS,[WORD CS:CSEGMENT]
                MOV [WORD DS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP2],SS
                MOV [WORD CS:INITSSSP2+02H],SP

                CLI
                MOV SS,[WORD CS:CHILDSSSP2+02H]
                MOV SP,[WORD CS:CHILDSSSP2]
                STI
                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP2]
PKLITE150COMBRK0:
                MOV DS,[WORD CS:CSEGMENT]
                SUB DI,0100H
                MOV [WORD DS:FILESIZECOM],DI
                MOV AX,[WORD CS:INITSSSP2]
                MOV BX,[WORD CS:INITSSSP2+02H]
                MOV [WORD DS:INITSSSP],AX
                MOV [WORD DS:INITSSSP+02H],BX
                JMP FAR BRKPRX31COM1
CHECKPKLITE150EXE1:
                CMP [WORD DS:0100H],0B850H
                JZ PKLITE150EXEOK1
                JMP CHECKPKLITE150EXE2
PKLITE150EXEOK1:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,013AH
                MOV DI,OFFSET PKLITE150EXEID1
                MOV CX,0026
                CLD
                REP CMPSB
                JZ PKLITE150EXEOK2
                JMP CHECKPKLITE150EXE2
PKLITE150EXEOK2:
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],20H

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET PKLITE150EXE
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON

CHECKPKLITE150EXE2:
                CMP [WORD DS:0100H],0B850H
                JZ PKLITE150EXEOK3
                JMP CHECKPKLITE150EXE3
PKLITE150EXEOK3:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,013AH
                MOV DI,OFFSET PKLITE150EXEID2
                MOV CX,0026
                CLD
                REP CMPSB
                JZ PKLITE150EXEOK4
                JMP CHECKPKLITE150EXE3
PKLITE150EXEOK4:
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],21H

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET PKLITE150EXE
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON
CHECKPKLITE150EXE3:
                CMP [WORD DS:0100H],0B850H
                JZ PKLITE150EXEOK5
                JMP CHECKPKLITE150EXE4
PKLITE150EXEOK5:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,013AH
                MOV DI,OFFSET PKLITE150EXEID3
                MOV CX,0026
                CLD
                REP CMPSB
                JZ PKLITE150EXEOK6
                JMP CHECKPKLITE150EXE4
PKLITE150EXEOK6:
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],22H

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET PKLITE150EXEC
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON

CHECKPKLITE150EXE4:
                CMP [WORD DS:0100H],0B850H
                JZ PKLITE150EXEOK7
                JMP CHECKOVERLAY30
PKLITE150EXEOK7:
                MOV AX,[WORD CS:CSEGMENT]
                MOV ES,AX
                MOV SI,013AH
                MOV DI,OFFSET PKLITE150EXEID4
                MOV CX,0026
                CLD
                REP CMPSB
                JZ PKLITE150EXEOK8
                JMP FAR CHECKSCRE2B
PKLITE150EXEOK8:
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],23H

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET PKLITE150EXEC
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON
CHECKMEGALITE119EXE:
                MOV SI,002AH
                MOV DI,OFFSET MEGALITE119EXEID1
                MOV CX,0023
                CLD
                REP CMPSB
                JZ MEGALITE119OK
                JMP FAR CHECKPRXCM20COM
MEGALITE119OK:
                MOV SI,0165H
                MOV DI,OFFSET MEGALITE119EXEID2
                MOV CX,0005
                CLD
                REP CMPSB
                JZ MEGALITE119OK2
                JMP FAR CHECKPRXCM20COM
MEGALITE119OK2:
                PUSH DS
                PUSH ES
                PUSH DS
                PUSH ES
                POP DS
                POP ES

                MOV SI,OFFSET MEGALITE119REPLACE
                MOV DI,0165H
                MOV CX,0005
                CLD
                REP MOVSB

                POP ES
                POP DS

                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,DS
                MOV [WORD ES:DSEGMENT],AX
                MOV [BYTE ES:PKTYPE],1FH

                MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET MEGALITE119EXE
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3
                JMP FAR PKCOMMON
CHECKOVERLAY30:
                MOV SI,006H
                MOV DI,OFFSET OVERLAY30ID
                MOV CX,0044
                CLD
                REP CMPSB
                JZ OVERLAY30OK
                JMP FAR CHECKSCRE2B
OVERLAY30OK:
                MOV [WORD CS:DSEGMENT2],DS
		MOV DX,OFFSET FOUNDPRG
                CALL PRINT2
                MOV DX,OFFSET OVERLAY30
                CALL PRINT2
                CALL PAGK4
                CALL GETATTRIB3

                MOV DS,[WORD CS:CSEGMENT]
                MOV AX,3D02H
                MOV DX,OFFSET TEMPPARAMETERS
                INT 21H
                MOV [WORD DS:HANDLE],AX
                MOV [WORD DS:EXEHEADORIG+018H],001CH

                MOV AH,40H
                MOV BX,[WORD DS:HANDLE]
                MOV CX,001CH
                MOV DX,OFFSET EXEHEADORIG
                INT 21H

                MOV DS,[WORD CS:DSEGMENT2]
                MOV [WORD DS:048H],0F0CDH
                MOV [BYTE DS:04AH],090H

                MOV ES,[WORD CS:CSEGMENT]

                XOR AX,AX
                MOV DS,AX
                MOV SI,0
                MOV DI,OFFSET BACKUPINT
                MOV CX,4*0100H
                CLD
                REP MOVSB
                MOV AX,35F0H
                INT 21H
                MOV DS,[WORD CS:CSEGMENT]
                MOV [WORD PTR DS:INTF0IP],BX
                MOV [WORD PTR DS:INTF0CS],ES
                PUSH CS
                POP DS
                MOV AX,25F0H
                MOV DX,OFFSET OVERLAY30BRK0
                INT 21H
                MOV AH,62H
                INT 21H
                MOV DS,[WORD CS:CSEGMENT]
                MOV [WORD DS:PID],BX
                MOV ES,BX
                MOV DS,BX

                MOV [WORD CS:INITSSSP2],SS
                MOV [WORD CS:INITSSSP2+02H],SP

                XOR AX,AX
                XOR BX,BX
                XOR CX,CX
                XOR DX,DX
                XOR SI,SI
                XOR DI,DI

                PUSH AX
                POPF
                STI
                JMP [DWORD CS:CHILDCSIP2]
OVERLAY30BRK0:
                PUSHF
                CALL PUSHTEMP2
                MOV DS,[WORD CS:DSEGMENT2]
                MOV SI,[WORD CS:TEMPSI2]
                MOV AX,[WORD CS:TEMPAX2]
                SUB [BYTE DS:SI],AL
                MOV CX,[WORD CS:TEMPCX2]
                CMP CX,0001H
                JZ OVERLAYFINBRK0
                CALL POPTEMP2
                POPF
                IRET
OVERLAYFINBRK0:
                POP AX
                POP AX
                MOV [WORD CS:CHILDCSIP2],AX
                POP AX
                MOV [WORD CS:CHILDCSIP2+02],AX
                MOV AX,[WORD DS:086H]
                MOV [WORD CS:TEMPBYTE2],AX
                MOV [WORD DS:086H],0F0CDH
                MOV [WORD ES:03C0H],OFFSET OVERLAY30BRK1
                MOV SI,00B7H
                PUSH CS
                POP ES
                MOV DI,OFFSET OVERLAYLASTBYTES
                MOV CX,0003
                CLD
                REP MOVSW

                CALL POPTEMP2
                POPF
                CLI
                MOV SS,[WORD CS:CHILDSSSP2+02H]
                MOV SP,00C1H
                JMP [DWORD CS:CHILDCSIP2]
OVERLAY30BRK1:
                PUSHF
                CALL PUSHTEMP2
                MOV DS,[WORD CS:DSEGMENT2]
                MOV AX,[WORD CS:TEMPBYTE2]
                MOV [WORD DS:086H],AX
                MOV BX,SP
                MOV AX,[WORD SS:BX+02H]
                SUB AX,0002H
                MOV [WORD SS:BX+02H],AX
                MOV [WORD DS:09FH],0F0CDH
                MOV [BYTE DS:0A1H],090H
                MOV [WORD DS:0ABH],0F0CDH
                MOV [WORD DS:0ADH],09090H
                MOV [WORD DS:0AFH],09090H
                MOV [WORD DS:0B1H],09090H

                MOV DS,[WORD CS:CSEGMENT]
                MOV AX,[WORD CS:TEMPES2]
                MOV BX,[WORD CS:TEMPSI2]
                MOV [WORD DS:PARAES],AX
                MOV [WORD DS:PARADI],BX
                MOV [WORD DS:EXEHEADORIG+006H],0000
                MOV [BYTE DS:COMPRTYPE],01H
                MOV [BYTE DS:LEJOS],01H
                MOV [WORD ES:03C0H],OFFSET OVERLAY30BRK2

                POP AX
                POP AX
                MOV [WORD CS:CHILDCSIP2],AX
                POP AX
                MOV [WORD CS:CHILDCSIP2+02],AX

                CALL POPTEMP2
                POPF
                CLI
                MOV SS,[WORD CS:INITSSSP2]
                MOV SP,[WORD CS:INITSSSP2+02H]

                JMP [DWORD CS:CHILDCSIP2]

OVERLAY30BRK2:
                PUSHF
                CALL PUSHTEMP2
                MOV CX,[WORD CS:TEMPCX2]
                JCXZ OVERLAY30RELOCEND
                MOV DS,[WORD CS:CSEGMENT]
                MOV AX,[WORD CS:TEMPES2]
                MOV [WORD DS:TEMPES],AX
                MOV AX,[WORD CS:TEMPBX2]
                MOV [WORD DS:TEMPBX],AX


                CALL FAR SAVERELOC2
                CALL POPTEMP2
                POPF
                IRET
OVERLAY30RELOCEND:
                MOV AH,3EH
                MOV DS,[WORD CS:CSEGMENT]
                MOV [BYTE DS:LEJOS],00H
                MOV BX,[WORD DS:HANDLE]
                INT 21H

                MOV CX,[WORD DS:CANTRELOC]
                MOV [WORD DS:EXEHEADORIG+006H],CX

                PUSH CS
                POP DS
                MOV ES,[WORD CS:DSEGMENT2]
                MOV SI,OFFSET OVERLAYLASTBYTES
                MOV DI,00B7H
                MOV CX,0003
                CLD
                REP MOVSW

                MOV AX,3C00H
                XOR BX,BX
                MOV CX,0020H
                MOV DS,[WORD CS:CSEGMENT]
                MOV DX,OFFSET STICKERNAMECOM
                INT 21H

                MOV [WORD DS:HANDLE3],AX

                MOV DS,[WORD CS:DSEGMENT2]

                MOV AX,[WORD DS:0000H]
                MOV BX,[WORD DS:0002H]

                MOV [WORD CS:DSEGMENT2],BX
                MOV [WORD CS:OFFSALTO],AX

                MOV DS,[WORD CS:DSEGMENT2]
                MOV [WORD DS:09AH],0F0CDH
                MOV [WORD DS:0E3H],0F0CDH
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET OVERLAY30BRK3
                CALL POPTEMP2
                POPF
                IRET
OVERLAY30BRK3:
                PUSHF
                CALL PUSHTEMP2

                MOV DS,[WORD CS:DSEGMENT2]
                MOV AX,[WORD CS:TEMPAX2]
                MOV BX,[WORD CS:TEMPBX2]
                MOV CX,[WORD CS:TEMPCX2]
                MOV ES,[WORD CS:TEMPES2]
                MOV DI,[WORD CS:TEMPDI2]
OVERLAYDECRYPT:
                XOR AL,[BYTE DS:BX+011FH]
                INC BX
                AND BX,+0FH
                XOR AL,[BYTE DS:BX+0A0H]
                XOR [BYTE ES:DI],AL
                INC DI
                DEC CX
                JNZ OVERLAYDECRYPT

                MOV DS,[WORD CS:DSEGMENT2]
                MOV CX,[WORD DS:0008H]
                MOV DS,[WORD CS:CSEGMENT]
                MOV [WORD DS:FILESIZECOM],CX
                MOV BX,[WORD DS:HANDLE3]
                MOV AH,40H
                MOV DS,[WORD CS:TEMPES2]
                MOV DX,0100H
                INT 21H

                MOV AH,3EH
                MOV DS,[WORD CS:CSEGMENT]
                MOV BX,[WORD DS:HANDLE3]
                INT 21H

                CALL POPTEMP2
                POPF
                POP AX;
                POP AX; Desapilo la int f0
                POP AX;
                POP AX;  Desapilo el Retf que ejecuta el STICKER.COM
                POP AX;
                XOR AX,AX
                MOV ES,AX
                MOV [WORD ES:03C0H],OFFSET OVERLAY30BRK4
                INT 20H
OVERLAY30BRK4:
                MOV DS,[WORD CS:DSEGMENT2]
                MOV ES,[WORD CS:CSEGMENT]
                MOV AX,[WORD DS:004H]; SP
                MOV BX,[WORD DS:000H]; IP
                MOV [WORD ES:EXEHEADORIG+014H],BX
                MOV [WORD ES:EXEHEADORIG+010H],AX
                MOV AX,[WORD DS:002H]; CS
                SUB AX,[WORD ES:PID]
                SUB AX,0010H
                MOV [WORD ES:EXEHEADORIG+016H],AX
                MOV AX,[WORD DS:006H]; SS
                SUB AX,[WORD ES:PID]
                SUB AX,0010H
                MOV [WORD ES:EXEHEADORIG+00EH],AX

                PUSH ES
                POP DS

                MOV AX,[WORD DS:PARAES]
                MOV BX,[WORD DS:PARADI]

                MOV CX,0010H
                MUL CX
                CLC
                ADD AX,BX
                ADC DX,+00

                MOV CX,[WORD DS:FILESIZECOM]
                CLC
                SUB AX,CX
                SBB DX,+00
                CLC
                SUB AX,0243H ; RESTO AL LARGO 100h BYTES DE PSP y 143h del
                SBB DX,+00   ; c¢digo del OVERLAY v3.0 :-),el resto queda por
                CLC          ; las dudas...
                MOV CX,0010H
                DIV CX
                MOV [WORD DS:PARAES],AX
                MOV [WORD DS:PARADI],DX
                CLC
                CLI
                MOV SS,[WORD CS:INITSSSP2]
                MOV SP,[WORD CS:INITSSSP2+02H]

                XOR AX,AX
                MOV ES,AX
                MOV DS,[WORD CS:CSEGMENT]
                MOV SI,OFFSET BACKUPINT
                XOR DI,DI
                MOV CX,4*0100H
                CLD
                REP MOVSB
                JMP FAR SAVECOMMON

ENDS SEGUNDAPARTE
