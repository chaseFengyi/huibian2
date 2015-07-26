DATA      SEGMENT
INFO1     DB 0DH,0AH,'WELCOME YOU TO COME HERE!$'
INFO2     DB 0DH,0AH,'this is a music program!$'
INFO3     DB 0DH,0AH,'please select!$'
INFO4     DB 0DH,0AH,'INPUT ERROR!$'
INFO5     DB 0DH,0AH,'PLEASE INPUT AGAIN!$'
MUSLIST   DB 0DH,0AH,'A MUSIC1'
          DB 0DH,0AH,'B MUSIC2'
          DB 0DH,0AH,'C MUSIC3'
          DB 0DH,0AH,'Q EXIT'
          db 0dh,0ah,'$'
;音乐一*********************************************************
MUS_FREG1 DW 330,294,262,294,3 DUP (330)
          DW 3 DUP (294),330,392,392
          DW 330,294,262,294,4 DUP (330)
          DW 294,294,330,294,262,-1
MUS_TIME1 DW 6 DUP (25),50
          DW 2 DUP (25,25,50)
          DW 12 DUP (25),100
;*********************************************************音乐二
MUS_FREG2 DW 330,392,330,294,330,392,330,294,330
          DW 330,392,330,294,262,294,330,392,294
          DW 262,262,220,196,196,220,262,294,332,262,-1
MUS_TIME2 DW 3 DUP(50),25,25,50,25,25,100
          DW 2 DUP(50,50,25,25),100
          DW 3 DUP(50,25,25),100
;********************************************************音乐三
MUS_FREG3 DW 262,262,294,262,349
          DW 330,262,262,294,262
          DW 392,349,262,262,523
          DW 440,349,262,262,466
          DW 466,440,262,392,349,-1

MUS_TIME3 DW 50,50,100,100,100
          DW 100,100,50,50,100,100
          DW 100,100,100,50,50,100
          DW 100,100,100,100,100,50
          DW 50,100,100,100,100,100
DATA      ENDS
STACK     SEGMENT
          DB 200 DUP ('STACK')
STACK     ENDS

CODE      SEGMENT
          ASSUME DS:DATA,SS:STACK,CS:CODE
START:
          MOV AX,DATA
          MOV DS,AX
          MOV aH, 0
          MOV AL,00
          INT 10H
;*****定义一个宏*****
SHOW      MACRO b
          LEA DX,b
          MOV AH,9
          INT 21H
          ENDM
;**********************音乐地址宏
ADDRESS MACRO A,B
LEA SI,A
LEA BP,DS:B
ENDM
;***********************
          show INFO1
          show INFO2
          show INFO3
          show MUSLIST
INPUT:    MOV AH,01H
          INT 21H
          CMP AL,'Q'
          JZ retu
          CMP AL,'A'
          JNZ B0
          ADDRESS MUS_FREG1,MUS_TIME1
          CALL MUSIC
          JMP EXIT1
B0:       CMP AL,'B'
          JNZ C0
          ADDRESS MUS_FREG2,MUS_TIME2
          CALL MUSIC
          JMP EXIT1
C0:       CMP AL,'C'
          JNZ exit
          ADDRESS MUS_FREG3,MUS_TIME3
          CALL MUSIC
EXIT1:    show INFO5
          JMP INPUT
EXIT:
          call clear
          show INFO4
          show INFO5
          show INFO1
          show INFO2
          show INFO3
          show MUSLIST
          jmp input
RETU:     MOV AH,4CH
          INT 21H
;******************************************发声
GENSOUND PROC NEAR
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          PUSH DI
          MOV AL,0B6H
          OUT 43H,AL
          MOV DX,12H
          MOV AX,348ch
          DIV DI
          OUT 42H,AL
          MOV AL,AH
          OUT 42H,AL
          IN AL,61H
          MOV AH,AL
          OR AL,3
          OUT 61H,AL

WAIT1:    MOV CX,3314
          call waitf
DELAY1:   DEC BX
          JNZ WAIT1
          MOV AL,AH
          OUT 61H,AL
          POP DI
          POP DX
          POP CX
          POP BX
          POP AX
          RET
GENSOUND ENDP
;********************************************
waitf proc near
      push ax
waitf1:
      in al,61h
      and al,10h
      cmp al,ah
      je waitf1
      mov ah,al
      loop waitf1
      pop ax
      ret
waitf endp

;*********************************************
MUSIC   PROC NEAR
          PUSH DS
          SUB AX,AX
          PUSH AX
FREG:     MOV DI,[SI]
          CMP DI,-1
          JE END_MUS
          MOV BX,DS:[BP]
          CALL GENSOUND
          ADD SI,2
          ADD BP,2
          JMP FREG
END_MUS:
          RET
MUSIC    ENDP
;************************************************clear!!!
clear proc near
      push ax
      push bx
      push cx
      push dx
      mov  ah,6
      mov al,0
      mov ch,0
      mov cl,0
      mov dh,24
      mov dl,79
      mov bh,7
      int 10h
      pop dx
      pop cx
      pop bx
      pop ax
      ret
clear endp
CODE      ENDS
          END START
