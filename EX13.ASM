DATA SEGMENT
        NUM     DB 82H,68H,88H
        SUM     DB ?
DATA ENDS



CODE SEGMENT
        ASSUME  CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX

       MOV      [BX],20H
       INC [SI]
       ADD AX,[SI+DI]
       SHL AX,3
       PUSH 2000H
       POP AL
       MOV CS,AX
       MOV DS,1000H

        MOV     AH,4CH
        INT     21H
CODE    ENDS
        END START

                                
