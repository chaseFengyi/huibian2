DATA    SEGMENT
        INFOR1  DB 0AH,0DH,"Are you really want to exit?$"
        INFOR2  DB 0AH,0DH,"Thank you for using!$"
        INFOR3  DB 0AH,0DH,"Let's continue!$"
        INFOR4  DB 0AH,0DH,"You press an error key!$"
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX
        MOV     DX,OFFSET INFOR1
        MOV     AH,09H
        INT     21H
        MOV     AH,01H
        INT     21H
        CMP     AL,'Y'
        JE      EQUAL
        ;JNE     OTHER
        CMP     AL,'y'
        JE      EQUAL
        ;JNE     OTHER
        CMP     AL,'n'
        JE      NEQUAL
        ;JNE     OTHER
        CMP     AL,'N'
        JE      NEQUAL
        JNE     OTHER
EQUAL:  MOV     DX,OFFSET INFOR2
        MOV     AH,09H
        INT     21H
        JMP     PEND
NEQUAL: MOV     DX,OFFSET INFOR3
        MOV     AH,09H
        INT     21H
        JMP     PEND
OTHER:  MOV     DX,OFFSET INFOR4
        MOV     AH,09H
        INT     21H
PEND:   MOV     AH,4CH
        INT     21H
CODE    ENDS
        END START

