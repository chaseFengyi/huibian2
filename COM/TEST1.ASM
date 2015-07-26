STACK  SEGMENT stack
        STL     DW 100H DUP(?)
STACK ENDS

DATAS SEGMENT
        INFOR2 DB 0AH,0DH,"Please Input LENGTH:$"
        ITSLEFT=30
        ITSBUTTOM=5        
        ITSHIGH=20
        ITSLEN DB 20 DUP(?)
        ITSCHAR='*'
        POS DB 0
REPT ITSHIGH
        DB ITSLEFT,ITSBUTTOM,ITSCHAR
        ITSLEFT=ITSLEFT+1
        ITSBUTTOM=ITSBUTTOM+1
        ENDM
DATAS ENDS

CODES SEGMENT
        ASSUME CS:CODES,DS:DATAS,SS:STACK
START:
        MOV AX,DATAS
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX
        MOV SP,100H

        LEA SI,POS
        ;ADD SI,1

	MOV DX,OFFSET INFOR2
        MOV AH,09H
        INT 21H
        	
	;MOV DX,OFFSET ITSLEN
        ;MOV AH,0AH
       ; INT 21H
	;MOV CL,ITSLEN+1
       ; MOV CH,0
	;MOV SI,OFFSET ITSLEN+2

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

       

        ;MOV CX,ITSLEN
        INT 10H
        POP DX
        POP CX
        POP BX
        POP AX
        RET

        

        SHOWPOSCHAR ENDP
        CODES ENDS
        END START
