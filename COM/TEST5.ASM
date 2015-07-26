STACK  SEGMENT stack
        STL     DW 100H DUP(?)
STACK ENDS
SSEG SEGMENT
        DB 100H DUP(0)
        SSEG ENDS
DSEG SEGMENT
        ;POS DB COL,ROW,CHAR

        ITSLEFT=30
        ITSBUTTOM=5
        ITSHIGH=10
        ITSLEN=20
        ITSCHAR='*'
        POS DB 0
REPT ITSHIGH
        DB ITSLEFT,ITSBUTTOM,ITSCHAR
        ITSLEFT=ITSLEFT+1
        ITSBUTTOM=ITSBUTTOM+1
        ENDM
        DSEG ENDS

CSEG SEGMENT
        ASSUME CS:CSEG,DS:DSEG,ES:DSEG,SS:SSEG
START:
        MOV AX,DSEG
        MOV DS,AX
        MOV ES,AX
        MOV AX,SSEG
        MOV SS,AX
        MOV SP,100H

        LEA SI,POS
        ADD SI,1
        MOV CX,ITSHIGH
C1:
        CALL SHOWPOSCHAR
        ADD SI,3
        LOOP C1

        MOV AX,4C00H
        INT 21H
        SHOWPOSCHAR PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV AH,02H
        MOV BH,00H
        MOV DX,[SI]
        INT 10H
        MOV AH,9
        MOV AL,2[SI]
        MOV BX,0007H
        MOV CX,ITSLEN
        INT 10H
        POP DX
        POP CX
        POP BX
        POP AX
        RET

        

        SHOWPOSCHAR ENDP
        CSEG ENDS
        END START

REPT ITSHIGH
        DB ITSLEFT,ITSBUTTOM,ITSCHAR
        ITSLEFT=ITSLEFT+1
        ITSBUTTOM=ITSBUTTOM+1
        ENDM
        DSEG ENDS

CSEG SEGMENT
        ASSUME CS:CSEG,DS:DSEG,ES:DSEG,SS:SSEG
START:
        MOV AX,DSEG
        MOV DS,AX
        MOV ES,AX
        MOV AX,SSEG
        MOV SS,AX
        MOV SP,100H

        LEA SI,POS
        ADD SI,1
        MOV CX,ITSHIGH
C1:
        CALL SHOWPOSCHAR
        ADD SI,3
        LOOP C1

        MOV AX,4C00H
        INT 21H
        SHOWPOSCHAR PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

	MOV AL,4
	INT 10H

        MOV AH,02H
        MOV BH,00H
        MOV DX,[SI]
        INT 10H
        MOV AH,9
        MOV AL,2[SI]
        MOV BX,0007H
        MOV CX,ITSLEN
        INT 10H
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        SHOWPOSCHAR ENDP
        CSEG ENDS
        END START
