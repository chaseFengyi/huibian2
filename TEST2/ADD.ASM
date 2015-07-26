DATA    SEGMENT
        INFOR1  DB"Please Input the First Data(<10):$"
        INFOR2  DB 0AH,0DH,"Please Inpute the Second Data(<10):$"
        INFOR3  DB 0AH,0DH,"The Result is:$"
DATA    ENDS
CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX
        
        MOV     DX,OFFSET INFOR1
        MOV     AH,09H
        INT     21H
        MOV     AH,01H
        INT     21H
        SUB     AL,30H

        MOV     BL,AL

        MOV     DX,OFFSET INFOR2
        MOV     AH,09H
        INT     21H
        MOV     AH,01H
        INT     21H
        SUB     AL,30H

        XOR     AH,AH
        ADD    AL,BL
        AAA

        PUSH    AX

        MOV     DX,OFFSET INFOR3
        MOV     AH,09H
        INT     21H

        POP     AX
        PUSH    AX

        MOV     DL,AH
        ADD     DL,30H
        MOV     AH,02H
        INT     21H
        POP     AX
        MOV     DL,AL
        ADD     DL,30H
        MOV     AH,02H
        INT     21H

        MOV     AH,4CH
        INT     21H
CODE    ENDS
        END     START




