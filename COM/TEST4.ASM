DATA    SEGMENT
ATRI    DB 6EH,52H,94H,52H,6EH
DATA    ENDS
STACK   SEGMENT PARA    STACK  'STACK'
        DB  200  DUP(0)
STACK   ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,SS:STACK
START:
        MOV AX,DATA
        MOV DS,AX
        MOV AH,0
        MOV AL,3
        INT 10H
        LEA SI,ATRI
        MOV DI,5
        MOV DX,0A13H
        MOV AH,15
        INT 10H
LP:
        MOV AH,2
        INC DL
        INT 10H
        MOV AL,5
        MOV BL,[SI]
        MOV CX,1
        MOV AH,9
        INT 10H
        INC SI
        DEC DI
        JNZ LP
        MOV AH,4CH
        INT 21H
CODE ENDS
        END START
